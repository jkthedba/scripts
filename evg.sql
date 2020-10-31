set lin 199 pages 99
 select event,inst_id,count(1) from gv$session group by event,inst_id order by 3,2;

