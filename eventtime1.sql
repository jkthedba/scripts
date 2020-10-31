col "End Time" for a20
SELECT /*+ rule */ to_char(b.end_interval_time,'DD-MON-YY HH24:MI')"End Time" ,b.snap_id,b.snap_id+1,ee.total_waits - be.total_waits
,(ee.time_waited_micro-be.time_waited_micro ) / (( ee.total_waits - be.total_waits ) * 1000) "Avg(ms)"
    FROM
    dba_hist_system_event be, dba_hist_system_event ee,
    dba_hist_snapshot b,
    dba_hist_snapshot e
   WHERE be.event_name = 'latch: shared pool'
   and b.snap_id +1  = e.snap_id
   and b.dbid = e.dbid
   and b.instance_number = e.instance_number
   and be.snap_id = b.snap_id
   and be.snap_id +1 = ee.snap_id
   and be.dbid = ee.dbid
   and be.instance_number = ee.instance_number
   and be.event_name = ee.event_name
   and be.instance_number=1
   and b.instance_number=1
   and trunc(e.end_interval_time) = trunc(sysdate-7)
   and ee.total_waits - be.total_waits  <>0
ORDER BY b.end_interval_time
/
