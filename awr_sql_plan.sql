set lines 132
set pages 200

set heading off;

select '-------------------------------------------------------------------------------------------------------' from dual
union all
select '| Operation                                   | PHV/Object Name               |  Rows | Bytes|   Cost |'  as "Optimizer Plan:" from dual
union all
select '-------------------------------------------------------------------------------------------------------' from dual
union all
select *
  from (select
       rpad('|'||substr(lpad(' ',1*(depth-1))||operation||
            decode(options, null,'',' '||options), 1, 45), 46, ' ')||'|'||
       rpad(decode(id, 0, '----- '||to_char(plan_hash_value)||' -----'
                     , substr(decode(substr(object_name, 1, 7), 'SYS_LE_', null, object_name)
                       ||' ',1, 30)), 31, ' ')||'|'||
       lpad(decode(cardinality,null,'  ',
                decode(sign(cardinality-1000), -1, cardinality||' ', 
                decode(sign(cardinality-1000000), -1, trunc(cardinality/1000)||'K', 
                decode(sign(cardinality-1000000000), -1, trunc(cardinality/1000000)||'M', 
                       trunc(cardinality/1000000000)||'G')))), 7, ' ') || '|' ||
       lpad(decode(bytes,null,' ',
                decode(sign(bytes-1024), -1, bytes||' ', 
                decode(sign(bytes-1048576), -1, trunc(bytes/1024)||'K', 
                decode(sign(bytes-1073741824), -1, trunc(bytes/1048576)||'M', 
                       trunc(bytes/1073741824)||'G')))), 6, ' ') || '|' ||
       lpad(decode(cost,null,' ',
                decode(sign(cost-10000000), -1, cost||' ', 
                decode(sign(cost-1000000000), -1, trunc(cost/1000000)||'M', 
                       trunc(cost/1000000000)||'G'))), 8, ' ') || '|' as "Explain plan"
          from dba_hist_sql_plan
         where plan_hash_value = &plan_hash_value
           AND sql_id = '&sql_id'
           AND dbid = (select dbid from v$database)
          order by plan_hash_value, id
)
union all
select '-------------------------------------------------------------------------------------------------------' from dual
;

set heading on;

set pages 60

