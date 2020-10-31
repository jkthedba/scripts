set long 900000000
select dbms_metadata.get_ddl('&OBJ_TYPE','&OBJ_NAME','&OBJ_ONWER') from dual;
