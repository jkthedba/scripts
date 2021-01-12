-- displays one row for every disk discovered by the ASM instance, 
-- including disks which are not part of any disk group
set lin 199 pages 99
col PATH form a25
col GB_read for 99999
col GB_written for 9999
select PATH,
        mount_status,
        state,
        TOTAL_MB/1024 size_in_gb,
        FREE_MB/1024 free_gb,
        mount_date,
        bytes_read/1024/1024/1024 GB_read,
        BYTES_WRITTEN/1024/1024/1024 GB_written
from v$asm_disk_stat
order by path,mount_status;