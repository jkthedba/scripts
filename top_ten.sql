col owner format a20 trunc
col object_name format  a30 
col touches format 9,999,999
select * from (select count(*), sum(tch) touches, u.name, o.name object_name
from x$bh x,obj$ o,user$ u
where x.obj = o.obj#
 and  o.owner# = u.user#
group by u.name,o.name
order by 2 desc )
where rownum < 51 
/
