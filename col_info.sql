set lines 199 pages 999
col column_name for a40
Select column_name,num_distinct,num_nulls,density,histogram from dba_tab_cols where table_name='&TABLE_NAME' order by column_nAME;


