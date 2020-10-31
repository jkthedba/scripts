select PARTITION_NAME,HIGH_VALUE,NUM_ROWS,BLOCKS,LAST_ANALYZED from dba_tab_partitions
where table_name = '&table'
order by 5
/
