set lin 199 pages 99
select distinct snap_id ,instance_number, to_char(BEGIN_INTERVAL_TIME,'dd-mm-yy hh24:mi')
from dba_hist_snapshot
where
to_char(BEGIN_INTERVAL_TIME,'dd-mm-yy hh24:mi') between '&Start_time'	and '&END_time'
order by 1
/
