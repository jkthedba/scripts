set lin 199 pages 99
@dtfmt
col owner for a30
col object_name for a30
col object_type for a30
col status for a10
col created for a20
select owner,object_name,object_type,status,created from dba_objects where UPPER(object_name)=UPPER('&objname');
