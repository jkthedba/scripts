set lin 199 pages 99
select sql_text ,sql_id  from gv$sqlarea where upper(sql_text) like '%&tabname%';
