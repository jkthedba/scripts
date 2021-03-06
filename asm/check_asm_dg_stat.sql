col NAME for a10
col SEC_SZ for 999
col BLK_SZ for 9999
col STR_MB for 99
col GROUP_NUMBER for 99 head GRP
col COMPATIBILITY for a10
col DB_COMPAT for a10
col STATE for a7
col TYPE for a7
col TOT_GB for 999.9
col USABLE_GB for 999.9
col OFF_DSK for 999
col UNBLC for a5
col DB_COMPAT for a10
col USABLE_GB for 99999999.999999

select GROUP_NUMBER ,
 NAME               ,
 SECTOR_SIZE SEC_SZ ,
 BLOCK_SIZE  BLK_SZ ,
 ALLOCATION_UNIT_SIZE/1024/1024 AU_SIZE_MB,
 STATE              ,
 TYPE               ,
 TOTAL_MB/1024 SIZE_GB,
 USABLE_FILE_MB/1024 USABLE_GB     ,
 OFFLINE_DISKS   OFFLINE_DSK  ,
 VOTING_FILES      VOTE_FILE ,
 DATABASE_COMPATIBILITY DB_COMPAT
from v$asm_diskgroup_stat
/