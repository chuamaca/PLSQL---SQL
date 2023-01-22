
-- query para cuando se quejan de lentitud en el service center la bd es ACSR y esta en roadrnr

set linesize 300
set pagesize 100
--ALTER SESSION SET NLS_DATE_FORMAT = 'YYYYMMDD HH24:MI:SS'
col sid format 9999
col spid format a8
col serial# format 99999
col sofar format 9999999
col totalwork format 99999999
col opname format a22
col module format a20
col program format a22
col machine  format a25
col osuser  format a20
col SCHEMANAME fromat a8
SELECT   l.SID, p.spid,
         --l.serial# , 
         --l.sofar, 
         --l.totalwork,     
         ROUND(l.sofar/l.totalwork*100,2) "% Complete",l.OPNAME,v.module,v.program,v.machine,v.osuser, v.SCHEMANAME
FROM V$SESSION_LONGOPS L, v$session v, v$process p
WHERE L.totalwork != 0
and  L.sid =v.sid
and L.sofar <> L.totalwork
--and v.SCHEMANAME like 'CE10'
and v.paddr=p.addr
order by 3 desc;





-- show PROCESS id for all the active sessions
-- el join de v$process y v$session se hace por la paddr y addr (Join v$session.paddr with v$process.addr)

select p.spid,s.sid,s.serial#,s.username,s.status,s.last_call_et,p.program,p.terminal,logon_time,module,s.osuser,s.sid,s.serial#
from V$process p,V$session s
where s.paddr = p.addr 
--and p.spid='4862'
and s.status = 'ACTIVE' and s.username like '%SYS%';

-- cuando te dan el spid o proceso de OS solo :
select p.spid,s.sid,s.serial#,s.username,s.status,s.last_call_et,p.program,p.terminal,logon_time,module,s.osuser,s.sid,s.serial#
from V$process p,V$session s
where s.paddr = p.addr 
and p.spid='4862';



--###########################################################################################################################

cuando en la bd se cualge al SHUTDOWN IMMEDIATE

There may be processes still running and holding locks at the time a shutdown is issued. 
Sometimes these are failed jobs or transactions, which are effectively 'zombies', which are not able to receive a signal from Oracle. 


If this occurs, the only way to shutdown the database is by doing: 
sql> 
shutdown abort 
startup restrict 
shutdown normal 


The startup does any necessary recovery and cleanup, so that a valid cold backup can be taken afterward. 

If this issue occurs frequently, it would be a good practice to see if there are any active user processes running in v$session or v$process before shutting down the instance. 


If the problem persists, and no apparent user processes are active, you can set this event prior to issuing the shutdown command in order to see what is happening. This will dump a systemstate every 5 minutes while shutdown is hanging 
SQL> 
connect / as sysdba 
alter session set events '10400 trace name context forever, level 1'; 

Then issue the shutdown command. 

---#####################################################################################################

verificar parametros, si los parametros son dinamicos (alter system) o si se pueden cambiar sin reiniciar la bd.
describe V$parameter.

set line 150
col name format a20
col value format a15
col display_value format a15
col ISSES_MODIFIABLE format a10
col ISSYS_MODIFIABLE format a10
col ISMODIFIED format a10
select name, value, display_value, ISSES_MODIFIABLE, ISSYS_MODIFIABLE,ISMODIFIED
from v$parameter
where name='db_cache_size';

leyenda de los campos: 

ISSES_MODIFIABLE	VARCHAR2(5)	Indicates whether the parameter can be changed with ALTER SESSION (TRUE) or not (FALSE)

ISSYS_MODIFIABLE	VARCHAR2(9)	Indicates whether the parameter can be changed with ALTER SYSTEM and when the change takes effect:
IMMEDIATE - Parameter can be changed with ALTER SYSTEM regardless of the type of parameter file used to start the instance. The change takes effect immediately.
DEFERRED - Parameter can be changed with ALTER SYSTEM regardless of the type of parameter file used to start the instance. The change takes effect in subsequent sessions.
FALSE - Parameter cannot be changed with ALTER SYSTEM unless a server parameter file was used to start the instance. The change takes effect in subsequent instances.

ISINSTANCE_MODIFIABLE	VARCHAR2(5)	For parameters that can be changed with ALTER SYSTEm, indicates whether the value of the parameter can be different for every instance (TRUE) or whether the parameter must have the same value for all Real Application Clusters instances (FALSE). If the ISSYS_MODIFIABLE column is FALSE, then this column is always FALSE.

ISMODIFIED	VARCHAR2(10)	Indicates whether the parameter has been modified after instance startup:
MODIFIED - Parameter has been modified with ALTER SESSION
SYSTEM_MOD - Parameter has been modified with ALTER SYSTEM (which causes all the currently logged in sessions' values to be modified)
FALSE - Parameter has not been modified after instance startup
'


-- ################################## ABOUT TRACE SESSION ############################################
para identificar el trace que se va a generar en el user_dump_dest: 
la ruta esta en el parametro user_dump_dest


alter session set timed_statistics = true;
alter session set statistics_level=all;
alter session set max_dump_file_size = unlimited;
alter session set tracefile_identifier = "MY_REPRODUCE_SESSION";
alter session set events '10046 trace name context forever,level 12'; -- esto puede variar depende de lo q te pidan, este es por defecto.
-- execute lo que deseas....
alter session set events '10046 trace name context off'; -- se apaga de acuerdo a lo que se ponga en ON arriba.


/*
To find the trace file for your current session:
SELECT VALUE FROM V$DIAG_INFO WHERE NAME = 'Default Trace File';
The full path to the trace file is returned.

To find all trace files for the current instance:
SELECT VALUE FROM V$DIAG_INFO WHERE NAME = 'Diag Trace';
*/


-- ###################################################3333


-- ####################################################################
-- check espacio en el tablespace temporal.

SELECT A.tablespace_name tablespace, D.mb_total,
SUM (A.used_blocks * D.block_size) / 1024 / 1024 mb_used,
D.mb_total - SUM (A.used_blocks * D.block_size) / 1024 / 1024 mb_free
FROM v$sort_segment A,
(
SELECT B.name, C.block_size, SUM (C.bytes) / 1024 / 1024 mb_total
FROM v$tablespace B, v$tempfile C
WHERE B.ts#= C.ts#
GROUP BY B.name, C.block_size
) D
WHERE A.tablespace_name = D.name
GROUP by A.tablespace_name, D.mb_total;


	


PAQUETES O SOFTWARE INSTALADO EN ORACLE

col comp_id for a14
SQL> col comp_name for a36
SQL> col version for a14
SQL> select COMP_ID, COMP_NAME, VERSION, STATUS from dba_registry;



-- #######################################
espacio usado en asm groups
space used in asm groups

SET LINESIZE  145
SET PAGESIZE  9999
SET VERIFY    off
COLUMN group_name             FORMAT a20           HEAD 'Disk Group|Name'
COLUMN sector_size            FORMAT 99,999        HEAD 'Sector|Size'
COLUMN block_size             FORMAT 99,999        HEAD 'Block|Size'
COLUMN allocation_unit_size   FORMAT 999,999,999   HEAD 'Allocation|Unit Size'
COLUMN state                  FORMAT a11           HEAD 'State'
COLUMN type                   FORMAT a6            HEAD 'Type'
COLUMN total_mb               FORMAT 999,999,999   HEAD 'Total Size (MB)'
COLUMN used_mb                FORMAT 999,999,999   HEAD 'Used Size (MB)'
COLUMN pct_used               FORMAT 999.99        HEAD 'Pct. Used'

break on report on disk_group_name skip 1
compute sum label "Grand Total: " of total_mb used_mb on report

SELECT
    name                                     group_name
  , sector_size                              sector_size
  , block_size                               block_size
  , allocation_unit_size                     allocation_unit_size
  , state                                    state
  , type                                     type
  , total_mb                                 total_mb
  , (total_mb - free_mb)                     used_mb
  , ROUND((1- (free_mb / total_mb))*100, 2)  pct_used
FROM
    v$asm_diskgroup
ORDER BY
    name
/

=======================================================================================================================================
- O falta espacio en un tablespace q esta sobre asm. La cosa es darle o aumentarle un dbf.
- O agregar discos al ASM. OJO, para saber discos de cuanto se debe de agregar tenemos que hacer el query: 
set lines 200
                col path for a42
                col name for a18
                set pagesize 200
                select GROUP_NUMBER,DISK_NUMBER,NAME,PATH,TOTAL_MB,FREE_MB,CREATE_DATE,MODE_STATUS,STATE,HEADER_STATUS
                from  v$asm_disk
                order by 1,2;
				
mostrara los datos asi:
GROUP_NUMBER DISK_NUMBER NAME               PATH                                         TOTAL_MB    FREE_MB CREATE_DA MODE_ST STATE    HEADER_STATU
------------ ----------- ------------------ ------------------------------------------ ---------- ---------- --------- ------- -------- ------------
           1           0 BDW_DG_0000        /dev/mapper/xrx12bdw1p1                        102382      70334 18-MAR-13 ONLINE  NORMAL   MEMBER
           1           1 BDW_DG_0001        /dev/mapper/xrx12bdw2p1                        102382      70343 18-MAR-13 ONLINE  NORMAL   MEMBER
           1           2 BDW_DG_0002        /dev/mapper/xrx12bdw3p1                        102382      70330 18-MAR-13 ONLINE  NORMAL   MEMBER
           1           3 BDW_DG_0003        /dev/mapper/xrx12bdw4p1                        102382      70346 18-MAR-13 ONLINE  NORMAL   MEMBER
           1           4 BDW_DG_0004        /dev/mapper/xrx12bdw5p1                        102382      70338 18-MAR-13 ONLINE  NORMAL   MEMBER
           1           5 BDW_DG_0005        /dev/mapper/xrx12bdw6p1                        102382      70340 18-MAR-13 ONLINE  NORMAL   MEMBER
           1           6 BDW_DG_0006        /dev/mapper/xrx12bdw7p1                        102382      70343 18-MAR-13 ONLINE  NORMAL   MEMBER
           1           7 BDW_DG_0007        /dev/mapper/xrx12bdw8p1                        102382      70333 18-MAR-13 ONLINE  NORMAL   MEMBER
           1           8 BDW_DG_0008        /dev/mapper/xrx12bdw9p1                        102382      70338 18-MAR-13 ONLINE  NORMAL   MEMBER
           1           9 BDW_DG_0009        /dev/mapper/xrx12bdw10p1                       102382      70336 18-MAR-13 ONLINE  NORMAL   MEMBER
           1          10 BDW_DG_0010        /dev/mapper/xrx12bdw11p1                       102382      70336 18-MAR-13 ONLINE  NORMAL   MEMBER
           2           0 BDW_FRA_0000       /dev/mapper/xrx12bdw12p1                       102382     102158 27-MAR-13 ONLINE  NORMAL   MEMBER
           2           1 BDW_FRA_0001       /dev/mapper/xrx12bdw13p1                       102382     102151 27-MAR-13 ONLINE  NORMAL   MEMBER
           2           2 BDW_FRA_0002       /dev/mapper/xrx12bdw14p1                       102382     102150 28-MAR-13 ONLINE  NORMAL   MEMBER
           2           3 BDW_FRA_0003       /dev/mapper/xrx12bdw16p1                       102382     102234 28-MAY-13 ONLINE  NORMAL   MEMBER
           2           4 BDW_FRA_0004       /dev/mapper/xrx12bdw15p1                       102382     102240 28-MAY-13 ONLINE  NORMAL   MEMBER
           3           0 BPORTAL_DG_0000    /dev/mapper/xrx12bportal1p1                     51183      46846 18-MAR-13 ONLINE  NORMAL   MEMBER
           4           0 BPORTAL_FRA_0000   /dev/mapper/xrx12bportal2p1                     51183      50463 18-MAR-13 ONLINE  NORMAL   MEMBER

18 rows selected.

SQL>

de los cuales se puede ver para el primer reg que el disco es de casi 100 GB porque ME FIJO EN LA COLUMNA TOTAL_MBs


para el caso de aumento de espacio de un tbs, despues de verificar que sí hay FREE_MB aumento un datafile con la sgte instrucción:

alter tablespace BSARA_ETL_STAGE add datafile '+BDW_DG' size 80G;

select file_name from dba_data_files where tablespace_name='BSARA_ETL_STAGE'

=======================================================================================================================================

------------------------------------------------------------------------------------

--------- verificar las tareas programadas.
SELECT JOB_NAME, STATUS, ACTUAL_START_DATE,INSTANCE_ID FROM DBA_SCHEDULER_JOB_RUN_DETAILS
WHERE OWNER='ORACLE_OCM';

-----
----##########################################################################################
-- backups CON RMAN
-- HACIA TAPE DE FRENTE NOMAS 
Run
{
crosscheck archivelog all;
crosscheck backupset;
ALLOCATE CHANNEL ch1 TYPE 'SBT_TAPE';
backup database plus archivelog delete input; 
delete noprompt expired archivelog all;
delete noprompt expired backupset
delete noprompt force obsolete;
}


----##########################################################################################
ANTES DE HACER UN SHUTDOWN A UNA BASE DE DATOS:
- debe de revisar el status de los tbs y dbfs.
- consultar siempre la vista v$backup y tambien las dba_tablespaces y dba_data_file, y para todas verificar en los campos STATUS el mismo, la idea es que estén online para que no haya problemas al momento de realizar el startup.

SELECT f.name,b.status,b.change#,b.time FROM v$backup b,v$datafile f WHERE b.file# = f.file# AND b.status='ACTIVE';


 -- ####################################3
 --QUERYS PARA SABER LONG_OPS  de rman
 select
  sid,
serial#
  start_time,
time_remaining,elapsed_seconds,
  totalwork
  sofar, 
 (sofar/totalwork) * 100 pct_done
from 
   v$session_longops
where 
   totalwork > sofar
AND 
   opname NOT LIKE '%aggregate%'
AND 
   opname like 'RMAN%';
 

--##############################################################
-- Monitor long running operations using v$session_longops
-- operaciones con ejecucion mas larga. 

set line 500
column opname format a30
col target format a15
col username format a10
SELECT SID, SERIAL#, opname, target, SOFAR, TOTALWORK, username,to_CHAR(start_time,'MMDD HH24:MI:SS'),
ROUND(SOFAR/TOTALWORK*100,2) COMPLETE  
FROM   V$SESSION_LONGOPS  
WHERE  
TOTALWORK != 0  
AND    SOFAR != TOTALWORK  
order by 1;
---------------------------------------------------------------
SELECT osuser,
       sl.sid,
       sl.sql_hash_value,
       opname,
       target,
       elapsed_seconds,
       time_remaining
  FROM v$session_longops sl
inner join v$session s ON sl.SID = s.SID AND sl.SERIAL# = s.SERIAL#
WHERE time_remaining > 0
----------------------------------------------------------------
-- Show long running SQL Statements
-- sql statements mas largos en ejecucion:

SELECT s.username,
       sl.sid,
       sq.executions,
       sl.last_update_time,
       sl.sql_id,
       sl.sql_hash_value,
       opname,
       target,
       elapsed_seconds,
       time_remaining,
       sq.sql_fulltext
  FROM v$session_longops sl
 INNER JOIN v$sql sq ON sq.sql_id = sl.sql_id
 INNER JOIN v$session s ON sl.SID = s.SID AND sl.serial# = s.serial#
 WHERE time_remaining > 0

 --##############################################################
-- database size --> How large is the database -- tamaño de base de datos

col "Database Size" format a20
col "Free space" format a20
col "Used space" format a20
select    round(sum(used.bytes) / 1024 / 1024 / 1024 ) || ' GB' "Database Size"
,    round(sum(used.bytes) / 1024 / 1024 / 1024 ) - 
    round(free.p / 1024 / 1024 / 1024) || ' GB' "Used space"
,    round(free.p / 1024 / 1024 / 1024) || ' GB' "Free space"
from    (select    bytes
    from    v$datafile
    union    all
    select    bytes
    from     v$tempfile
    union     all
    select     bytes
    from     v$log) used
,    (select sum(bytes) as p
    from dba_free_space) free
group by free.p
/

--##############################################################
-- esquemas que ocupan la mayor cantidad de espacio en la bd
-- Which schemas are taking up all of the space

set pages 999
col "size MB" format 999,999,999
col "Objects" format 999,999,999
select    obj.owner "Owner"
,    obj_cnt "Objects"
,    decode(seg_size, NULL, 0, seg_size) "size MB"
from     (select owner, count(*) obj_cnt from dba_objects group by owner) obj
,    (select owner, ceil(sum(bytes)/1024/1024) seg_size
    from dba_segments group by owner) seg
where     obj.owner  = seg.owner(+)
order    by 3 desc ,2 desc, 1
/
