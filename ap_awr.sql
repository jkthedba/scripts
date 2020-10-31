
set lin 199 pages 99
select * from table(dbms_xplan.display_awr('&sql_id'));

