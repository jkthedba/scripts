 select sql_id,sum(time_waited) from v$active_session_history where event='&event' and sample_time >= sysdate-&Minutes/(60*24)
group by sql_id
order by 2
/

