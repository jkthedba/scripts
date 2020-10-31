declare
  ar_hint_table    sys.dbms_debug_vc2coll;
  ar_profile_hints sys.sqlprof_attr := sys.sqlprof_attr();
  cl_sql_text      clob;
  i                pls_integer;
begin

select OUTLINE as outline_hints bulk collect
  into ar_hint_table
from 
(
select -1, 'BEGIN_OUTLINE_DATA' "OUTLINE" from dual
union
select rownum, info "OUTLINE" from (
SELECT substr(extractValue(value(d), '/hint'),1,4000 )info
FROM acs_sqlplan p, table(xmlsequence(extract(xmltype(p.other_xml), '/*/outline_data/hint'))) d 
WHERE other_xml is not NULL and sql_id='amqhp7wtac85x' and plan_hash_value=1054156218)
union
select 5000, 'END_OUTLINE_DATA' "OUTLINE" from dual
);

select sql_fulltext into cl_sql_text
from acs_sqlarea
where sql_id = 'amqhp7wtac85x';

  i := ar_hint_table.first;
  while i is not null
  loop
    if ar_hint_table.exists(i + 1) then
      if substr(ar_hint_table(i + 1), 1, 1) = ' ' then
        ar_hint_table(i) := ar_hint_table(i) || trim(ar_hint_table(i + 1));
        ar_hint_table.delete(i + 1);
      end if;
    end if;
    i := ar_hint_table.next(i);
  end loop;
i := ar_hint_table.first;
  while i is not null
  loop
    ar_profile_hints.extend;
    ar_profile_hints(ar_profile_hints.count) := ar_hint_table(i);
    i := ar_hint_table.next(i);
  end loop;
dbms_sqltune.import_sql_profile(
    sql_text    => cl_sql_text
  , profile     => ar_profile_hints
  , name        => 'SQL_PROF_amqhp7wtac85x'
  , force_match => false
  );
end;
/





