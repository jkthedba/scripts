set lin 199 pages 99
col constraint_name for a50
col owner for a20
col table_name for a20
select owner,table_name,constraint_name,constraint_type from dba_constraints where table_name='&tab_name';

