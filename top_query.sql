select sql_id, executions, buffer_gets, round(buffer_gets/executions) bu_ex, round(elapsed_time/executions) elapsed_time,rows_processed, child_number
from (select a.*, rownum from v$sql a where executions>0) where executions >1000
order by executions, buffer_gets/executions
/
