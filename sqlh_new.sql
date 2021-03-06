SET VERIFY OFF
SET PAGESIZE 30
SET LINESIZE 250
COLUMN BEGIN_INTERVAL_TIME FORMAT A7
COLUMN BEGIN_INTERVAL_DATE FORMAT A11
COLUMN SQL_PROFILE FORMAT A10
COLUMN EXECUTIONS_DELTA  FORMAT 999999
COLUMN MILSEC_PER_EXEC FORMAT 9999999990.999
COLUMN ROWS_PER_EXEC FORMAT 9999990.9
COLUMN BUFFER_GETS_PER_EXEC FORMAT 999999990.9
COLUMN DISK_READS_PER_EXEC FORMAT 999999990.9
COLUMN OPT_COST FORMAT 9999999
COLUMN OPT_MODE FORMAT A10
COLUMN SQL_PROFILE FORMAT A15
COLUMN INST# FORMAT 99999

  SELECT SS.INSTANCE_NUMBER as INST#,
         TO_CHAR (S.BEGIN_INTERVAL_TIME, 'DD-MON-YYYY') AS BEGIN_INTERVAL_DATE,
                 TO_CHAR (S.BEGIN_INTERVAL_TIME, 'HH24:MI') AS BEGIN_INTERVAL_TIME,
         SS.PLAN_HASH_VALUE,
                 SS.SQL_PROFILE,
         SS.OPTIMIZER_COST AS OPT_COST,
         SS.OPTIMIZER_MODE AS OPT_MODE,
         SS.EXECUTIONS_DELTA,
         CASE
            WHEN SS.EXECUTIONS_DELTA > 0
            THEN
               SS.ELAPSED_TIME_DELTA / SS.EXECUTIONS_DELTA / 1000
            ELSE
               SS.ELAPSED_TIME_DELTA
         END
            AS MILSEC_PER_EXEC,
         CASE
            WHEN SS.EXECUTIONS_DELTA > 0
            THEN
               SS.ROWS_PROCESSED_DELTA / SS.EXECUTIONS_DELTA
            ELSE
               SS.ROWS_PROCESSED_DELTA
         END
            AS ROWS_PER_EXEC,
         CASE
            WHEN SS.EXECUTIONS_DELTA > 0
            THEN
               SS.BUFFER_GETS_DELTA / SS.EXECUTIONS_DELTA
            ELSE
               SS.BUFFER_GETS_DELTA
         END
            AS BUFFER_GETS_PER_EXEC,
         CASE
            WHEN SS.EXECUTIONS_DELTA > 0
            THEN
               SS.DISK_READS_DELTA / SS.EXECUTIONS_DELTA
            ELSE
               SS.DISK_READS_DELTA
         END
            AS DISK_READS_PER_EXEC,
         CASE
            WHEN SS.EXECUTIONS_DELTA > 0
            THEN
               SS.APWAIT_DELTA / (SS.EXECUTIONS_DELTA*1000)
            ELSE
               SS.APWAIT_DELTA
         END
            AS APP_WAIT_PER_EXEC_MS
    FROM SYS.WRH$_SQLSTAT SS
         INNER JOIN SYS.WRM$_SNAPSHOT S ON S.SNAP_ID = SS.SNAP_ID
   WHERE     SS.SQL_ID = '&sql_id'
                 AND SS.INSTANCE_NUMBER = S.INSTANCE_NUMBER
         --AND SS.BUFFER_GETS_DELTA > 0
                 AND SS.EXECUTIONS_DELTA > 0
ORDER BY S.SNAP_ID, SS.PLAN_HASH_VALUE;
