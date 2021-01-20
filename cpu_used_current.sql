col metric_name for a25
col metric_unit for a25
select metric_name, value, metric_unit from v$sysmetric where metric_name like'%CPU%' and group_id=2;