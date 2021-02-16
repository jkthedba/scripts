set lines 128
col name format a60 trunc
col value format 999,999,999,999,999
select n.name, s.value
from v$sesstat s, v$statname n
where n.statistic# = s.statistic#
and s.sid = userenv('SID')
and s.value > 0
and (n.name like 'cell%'
or n.name like 'physical%'
or n.name like 'db%'
or n.name like 'Session%' -- future stat for IORM
or n.name in ('session logical reads','logical read bytes from cache'))
order by n.name;
