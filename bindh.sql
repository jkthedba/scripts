col VALUE_STRING format a40
select snap_id, NAME, POSITION, DATATYPE_STRING, VALUE_STRING from DBA_HIST_SQLBIND where sql_id='&sql_id'
order by 1,3
/
