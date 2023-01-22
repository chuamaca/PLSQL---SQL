--=========================================================================================
-- dbms_output
--=========================================================================================


	begin
	dbms_output.put_line('this the first line');
	dbms_output.put_line('this is the second line');
	end;
---------------------------------------------

declare
begin
dbms_output.put_line('hello world');
end;

----------------------------------------------

declare
v number;
begin
v:=5;
dbms_output.put_line('hello world');
dbms_output.put_line(v);
end;


--=========================================================================================
---------------------------  ejemplo de export data pump con paquete plsql
--=========================================================================================


-- -- ====================================== export datapump ======================================
expdp system/oracle@xepdb1 full=y directory=DEMO_TALLER dumpfile=expnormal.dmp logfile=expnormal.log exclude=statistics

expdp system/oracle@xepdb1 
schemas=hr 
directory=DEMO_TALLER 
dumpfile=expnormalhr.dmp 
logfile=expnormalhr.log 
exclude=statistics

-- =========================================================================


-- verificacion de directorios para poder ejecutar el pump
-- D:\taller_tempo

DECLARE
hdnl NUMBER;
BEGIN
hdnl := DBMS_DATAPUMP.OPEN( operation => 'EXPORT', job_mode => 'SCHEMA', job_name=>'EXP HR 20200930');
DBMS_DATAPUMP.ADD_FILE( handle => hdnl, filename => 'hr_dbms.dmp', directory => 'DEMO_TALLER', filetype => dbms_datapump.ku$_file_type_dump_file);
DBMS_DATAPUMP.ADD_FILE( handle => hdnl, filename => 'hr_dbms.log', directory => 'DEMO_TALLER', filetype => dbms_datapump.ku$_file_type_log_file);
DBMS_DATAPUMP.METADATA_FILTER(hdnl,'SCHEMA_EXPR','IN (''HR'')');
DBMS_DATAPUMP.START_JOB(hdnl);
END;
/    


-- para monitorear el job :
-- monitor: 
col owner_name format a20
col job_name format a20
col OPERATION format a20
col job_mode format a20
col state format a20
col attached_sessions format a20
select owner_name, job_name, rtrim(operation) "OPERATION",
         rtrim(job_mode) "JOB_MODE", state, attached_sessions
      from dba_datapump_jobs
     where job_name not like 'BIN$%'
  order by 1,2;


-- importacion:
-- asegurarse de crear el usuario hr2.


create user hr2 identified by hr2;
grant connect  to hr2;
grant resource  to hr2;
grant unlimited tablespace to hr2;
alter user hr2 default tablespace sysaux;

DECLARE
hdnl NUMBER;
BEGIN
hdnl := DBMS_DATAPUMP.OPEN( operation => 'IMPORT', job_mode => 'SCHEMA', job_name=>'import a hr2 20200930');
DBMS_DATAPUMP.ADD_FILE( handle => hdnl, filename => 'HR_DBMS.dmp', directory => 'DEMO_TALLER', filetype => dbms_datapump.ku$_file_type_dump_file);
DBMS_DATAPUMP.ADD_FILE( handle => hdnl, filename => 'm_HR_DBMS.log', directory => 'DEMO_TALLER', filetype => dbms_datapump.ku$_file_type_log_file);
--DBMS_DATAPUMP.METADATA_FILTER(hdnl,'SCHEMA_EXPR','IN (''SCHEMA_1'')');
DBMS_DATAPUMP.METADATA_REMAP(hdnl,'REMAP_SCHEMA','HR','HR2');
DBMS_DATAPUMP.START_JOB(hdnl);
END;
/ 