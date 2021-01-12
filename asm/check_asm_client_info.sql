-- check clients connected to ASM
-- can show which DB using
-- group number is Number of the disk group being used by the client database instance 
-- STATUS 
--		CONNECTED - Database instance client has an active connection to the Automatic Storage Management instance
--		DISCONNECTED - Database instance client normally ended its connection to the Automatic Storage Management instance
--		BROKEN - Connection with the database instance client terminated abnormally
set pages 50000 lines 100 
col INSTANCE_NAME form a20
col SOFTWARE_VERSION form a20
col COMPATIBLE_VERSION form a20
select * from v$asm_client;


-- Sample output 

--  GROUP_NUMBER INSTANCE_NAME	  DB_NAME  CLUSTER_NAME 		   STATUS	SOFTWARE_VERSION     COMPATIBLE_VERSION       CON_ID
--  ------------ -------------------- -------- ------------------------------- ------------ -------------------- --  --	---  -------- ----------
--  	   1 +ASM1		  +ASM	   labdb-cluster		   CONNECTED	19.0.0.0.0	     19.0.0.0.0 		   0
--  	   1 mn-labdb01 	  _OCR	   labdb-cluster		   CONNECTED	-		     -				   0
--  	   2 +ASM1		  +ASM	   labdb-cluster		   CONNECTED	19.0.0.0.0	     19.0.0.0.0 		   0
--  	   2 dnextlb1		  dnextlb				   CONNECTED	11.2.0.4.0	     11.2.0.4.0 		   0
--  	   2 snextlb1		  snextlb				   CONNECTED	11.2.0.4.0	     11.2.0.4.0 		   0
--  	   2 stgnextl1		  stgnextl				   CONNECTED	11.2.0.4.0	     11.2.0.4.0 		   0
--  	   2 test1		  test					   CONNECTED	11.2.0.4.0	     11.2.0.4.0 		   0
--  	   3 dnextlb1		  dnextlb				   CONNECTED	11.2.0.4.0	     11.2.0.4.0 		   0
--  	   3 snextlb1		  snextlb				   CONNECTED	11.2.0.4.0	     11.2.0.4.0 		   0
--  	   3 stgnextl1		  stgnextl				   CONNECTED	11.2.0.4.0	     11.2.0.4.0 		   0
--  	   3 test1		  test					   CONNECTED	11.2.0.4.0	     11.2.0.4.0 		   0--  