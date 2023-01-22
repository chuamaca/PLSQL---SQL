

====================================

- en la express realizar

--CLONAR PDB
-----------------

sqlplus / as sysdba
alter pluggable database PDB_CURSO close immediate;


--Open the PDB that you want to clone in READ ONLY mode.:

alter pluggable database pdb_curso open read only;

exit



--Creating a Directory for the New Clone PDB

C:\oracleXE\product\18.0.0\oradata\XE\pdbtemp

--Configuring OMF to the Directory of the Clone PDB
--Use SQL*Plus to connect as sysdba and set the following parameter:

-- crear el directorio en windows
sqlplus / as sysdba
alter system set db_create_file_dest='C:\oracleXE\product\18.0.0\oradata\XE\pdbtemp';
 

--Use SQL*Plus to clone the PDB within the same CDB.

--Execute the following statement:
create pluggable database pdbtemp from pdb_curso;

--Open the new pdb.
alter pluggable database pdbtemp open;

--Connect to the new pdb.

alter session set container=pdbtemp 

connect system/oracle@lenovo-pc:1521/pdbtemp 
 

--Verify that you are connected to the new PDB:

show con_name

--Connect to the root in the CDB.

connect / as sysdba
?
alter session set container=cdb$root;

--Execute the following statement:

alter pluggable database pdb_ah close immediate; 

--Open the source pdb.
alter pluggable database pdb_ah open;

-- eliminar PDB

--Perform the following steps to reset your environment prior to repeating the activities covered in this OBE or starting another OBE.
--Close the clone PDB.

alter pluggable database pdbtemp close immediate;

--Delete the clone PDB and its data files.
drop pluggable database pdbtemp including datafiles;

alter system set db_create_file_dest='';


==================== xxxx =========================================0
/*
-- en la mv
--migrar una bd noncdb to pdb

--STEP 1: PERFORM A CLEAN SHUTDOWN

--Set the environment to noncdb.
shutdown immediate

STEP 2: OPEN THE DATABASE AS READ-ONLY

startup mount exclusive

alter database open read only;

STEP 3: GENERATE A PDB MANIFEST FILE

Set the environment to noncdb.

exec dbms_pdb.describe (pdb_descr_file=>'/tmp/noncdb12c_manifest_file.xml');


STEP 4: SHUTDOWN THE NON-CDB
--Set the environment to noncdb
shutdown immediate



STEP 5: START THE CDB

Set the environment to cdb1.



CREATE PLUGGABLE DATABASE orapdb2
   USING '/tmp/noncdb12c_manifest_file.xml'
      NOCOPY
      TEMPFILE REUSE;
-- copy: noncdb --> cdb1 (orapdb2)
/oracle/ *.* --> orapdb2
--move:  antes: /oracle/ *.* -- dspues: /oracpdb2/*.*


ALTER SESSION SET CONTAINER=ORAPDB2;


@$ORACLE_HOME/rdbms/admin/noncdb_to_pdb.sql


alter database open;

Select file_name from dba_data_files;

select file_name from dba_temp_files;


sho con_name


alter pluggable database open;
SELECT name, open_mode FROM v$pdbs;
*/