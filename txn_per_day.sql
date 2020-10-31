SELECT V1          "Total Commits",
       V2          "Total Rollbacks",
       V3          "Total User Calls",
       T1          "Uptime in days",
       S1 / T1     "Avg Daily DML Transactions",
       V3 / T1     "Avg Daily User Calls"
  FROM (SELECT VALUE     V1
          FROM V$SYSSTAT
         WHERE NAME = 'user commits'),
       (SELECT VALUE     V2
          FROM V$SYSSTAT
         WHERE NAME = 'user rollbacks'),
       (SELECT SUM (VALUE)     S1
          FROM V$SYSSTAT
         WHERE NAME IN ('user commits', 'user rollbacks')),
       (SELECT VALUE     V3
          FROM V$SYSSTAT
         WHERE NAME = 'user calls'),
       (SELECT SYSDATE - STARTUP_TIME T1 FROM V$INSTANCE);
