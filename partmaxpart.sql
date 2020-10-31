col high_value format a30
select high_value,partition_name,a.table_name
from dba_tab_partitions a,(Select MAX(PARTITION_POSITION) position ,name from dba_part_key_columns b,dba_tab_partitions c where b.name=c.table_name  and COLUMN_NAME like '%DATE%' and table_OWNER='TBAADM' group by name)d
where a.table_owner='TBAADM'
and a.table_name=d.name
and PARTITION_POSITION=d.position
/
