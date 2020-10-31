set lines 200 pages 1200
select sid, serial#,sql_hash_value,sql_id,program,last_call_et/60,logon_time,status,osuser,inst_id from gv$session where event like '%&ev%' order by 6;

