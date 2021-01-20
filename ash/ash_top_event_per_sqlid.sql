-- this script will list wait events per sql_id

set pagesize 999
set lines 999


select  decode(grouping(event),1,'TOTAL',event) event,
                decode(grouping(wait_class),1,'TOTAL', wait_class) wait_class,
                sum(PCNT), sum(nosamples), sum(nosamplestot),
                decode(grouping(owner),1,'TOTAL', owner)owner, decode(grouping(object_name),1,'TOTAL', object_name) object_name, decode(grouping(object_type),1,'TOTAL', object_type) object_type,
                decode(grouping(P1TEXT),1,'TOTAL', P1TEXT) P1TEXT, decode(grouping(P2TEXT),1,'TOTAL', P2TEXT) P2TEXT, decode(grouping(P3TEXT),1,'TOTAL', P3TEXT) P3TEXT
from (
        select event, wait_class,round((count(*)/cnttot)*100) PCNT, count(*) nosamples, cnttot nosamplestot,P1TEXT, P2TEXT, P3TEXT,
                owner, object_name, object_type
        from (
        select  event, wait_class, P1TEXT, P2TEXT, P3TEXT, owner, object_name, object_type,  count(*) over() cnttot
        from gv$active_session_history a  join dba_objects b on(a.CURRENT_OBJ# = b.object_id)
        where
        SAMPLE_TIME > sysdate - (&minutes_from_now/(24*60))
        and session_state= 'WAITING' and WAIT_TIME = 0
        and sql_id = nvl('&sql_id',sql_id)
        and SQL_CHILD_NUMBER = nvl('&SQL_CHILD_NUMBER',0)
        )t
        group by event, wait_class,  P1TEXT, P2TEXT, P3TEXT, owner, object_name, object_type, cnttot
        --order by count(*) desc
)
group by rollup(event, (wait_class,  P1TEXT, P2TEXT, P3TEXT, owner, object_name, object_type))
order by sum(PCNT) desc
/
