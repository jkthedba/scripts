select DISTINCT 'VAR ' || SUBSTR(NAME,2) || CASE WHEN DATATYPE_STRING='DATE' THEN ' VARCHAR2(20)' ELSE ' ' || DATATYPE_STRING END || ';' || CHR(10) ||
	'EXEC ' || NAME || ':=' || CASE WHEN DATATYPE_STRING='NUMBER' then VALUE_STRING ELSE '''' || VALUE_STRING || ''';' END "DECLARE_VAR"
from DBA_HIST_SQLBIND where sql_id='&sqlid'
and SNAP_ID ='&snapid'
and instance_number='&instance_id';