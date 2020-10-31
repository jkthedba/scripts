select ''''||s.sid||','||s.serial#||',@'||s.inst_id||'''',s.status ,s.sql_id,s.program,s.module, st.sql_text
from gv$session s, gv$sqltext st
where s.sql_id=st.sql_id and s.program like '%replicat%'  and status='ACTIVE' and st.sql_text like '%&tabname%';
