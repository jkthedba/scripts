col av for 9999999
col mx for 9999999
col mn for 9999999

select
   sql_id,
   count(*),
   round(min(delta),0) mn,
   round(avg(delta),0) av,
   round(max(delta),0) mx,
   substr(max(times),12) max_run_time
from (
   select
        sql_id,
        sql_exec_id,
        max(delta) delta ,
        -- lpad sets a fixed width on delta so it can be
        -- stripped off above with substr
        -- delta in "times" is just for sorting not displaying
        lpad(round(max(delta),0),10) || ' ' ||
        to_char(min(start_time),'YY-MM-DD HH24:MI:SS')  || ' ' ||
        to_char(max(end_time),'YY-MM-DD HH24:MI:SS')  times
   from ( select
                                            sql_id,
                                            sql_exec_id,
              cast(sample_time as date)     end_time,
              cast(sql_exec_start as date)  start_time,
              ((cast(sample_time    as date)) -
               (cast(sql_exec_start as date))) * (3600*24) delta
           from
dba_hist_active_sess_history
           where sql_exec_id is not null
        )
   group by sql_id,sql_exec_id
)
group by sql_id
having count(*) > 10
order by mx
/