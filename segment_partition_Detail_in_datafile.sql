 col SEGMENT_NAME for a30
 
 select TABLESPACE_NAME,owner, segment_name,partition_name,tablespace_name,bytes/1024/1024/1024 "Size in GB" from dba_segments where tablespace_name = (select name from v$tablespace where ts# =(select ts# from file$ where file#=20));
 /