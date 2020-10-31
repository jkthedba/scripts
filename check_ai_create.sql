@dtfmt.sql
set lin 199 pages 99
col execution_name for a50
select EXECUTION_NAME,EXECUTION_START,EXECUTION_END,status from DBA_AUTO_INDEX_EXECUTIONS order by 2;
