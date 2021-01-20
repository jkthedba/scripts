 -- System V$SYSTEM_WAIT will show wait class Foreground (user session) for instance
set lin 199 pages 99
col event for a50
SELECT 
event, 
wait_class, 
average_wait, 
average_wait_fg, 
( average_wait - average_wait_fg ) AS AVERAGE_WAIT_BG 
FROM   v$system_event 
WHERE  wait_class <> 'Idle' 
ORDER  BY average_wait 