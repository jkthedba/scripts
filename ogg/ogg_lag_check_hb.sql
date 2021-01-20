-- this script will check lag from OGG Heartbeat table on Replica side
-- Sometimes info all dont show lag when have long running txn on Master
-- This script will identify those lag.
-- Assumption Source is on UTC timezone & Destination is local TZ`
-- If source and destination on Same TZ have to use


-- SOURCE & TARGET DIFFERENT TZ ( Correct your SRC TZ if it is other than UTC)
-- DEST Is local TZ so no need modification
set linesize 250
col replicat for a20
set lines  199
col CURRENT_TS for a30
col INCOMING_TS for a30
select
INCOMING_REPLICAT as REPLICAT,
to_char(cast(from_tz(INCOMING_HEARTBEAT_TS,'UTC') at local as date),'dd-mm-yy hh24:mi:ss') as INCOMING_TS,
to_char(cast(systimestamp as date),'dd-mm-yy hh24:mi:ss') as CURRENT_TS,
trunc(extract( hour from systimestamp - (from_tz(INCOMING_HEARTBEAT_TS,'UTC') at local ) ),0)*60+
trunc(extract( minute from systimestamp - (from_tz(INCOMING_HEARTBEAT_TS,'UTC') at local ) ),0)  as LAG_MINUTES
from ggadmin.GG_HEARTBEAT;



-- SOURCE & TARGET SAME TZ 
set linesize 250
col replicat for a20
set lines  199
col CURRENT_TS for a30
col INCOMING_TS for a30
select
INCOMING_REPLICAT as REPLICAT,
to_char(cast(INCOMING_HEARTBEAT_TS as date),'dd-mm-yy hh24:mi:ss') as INCOMING_TS,
to_char(cast(systimestamp as date),'dd-mm-yy hh24:mi:ss') as CURRENT_TS,
trunc(extract( hour from systimestamp - INCOMING_HEARTBEAT_TS ),0)*60+
trunc(extract( minute from systimestamp - INCOMING_HEARTBEAT_TS  ),0)  as LAG_MINUTES
from ggadmin.GG_HEARTBEAT;