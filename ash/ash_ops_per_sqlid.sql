set pagesize 999
set lines 999

select SQL_PLAN_OPERATION, owner, object_name, object_type, round((count(*)/cnttot)*100) PCNT, count(*) nosamples, cnttot nosamplestot
from (
        select     A.SQL_PLAN_OPERATION, owner, object_name, object_type, count(*) over() cnttot
        from gv$active_session_history a  join dba_objects b on(a.CURRENT_OBJ# = b.object_id)
        where
                SAMPLE_TIME > sysdate - (&minutes_from_now/(24*60))
                and sql_id = nvl('&sql_id',sql_id)
)
group by SQL_PLAN_OPERATION, owner, object_name, object_type, cnttot
order by count(*) desc
/

-- Sample output
-- SQL_PLAN_OPERATION             OWNER      OBJECT_NAME                    OBJECT_TYPE           PCNT  NOSAMPLES NOSAMPLESTOT
-- ------------------------------ ---------- ------------------------------ --------------- ---------- ---------- ------------
--                                ERS        TR_DD_TRANSACTION_IDX03        INDEX                   97         56           58
--                                ERS        TR_DD_TRANSACTION_IDX04        INDEX                    2          1           58
--                                ERS        LOG_PAR_PK                     INDEX                    2          1           58
