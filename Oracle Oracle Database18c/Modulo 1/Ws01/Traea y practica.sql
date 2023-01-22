chijar@gmail.com
997409474


sqlplus / as sysdba

--Consultar la vista DBA_TABLESPACES
select tablespace_name,status from dba_tablespaces;

-- Consultar los datafiles de los tablespaces
set line 180
col TABLESPACE_NAME format a15
col FILE_NAME format a60
select tablespace_name,file_name,bytes from dba_data_files;

--Consultar los espacios de tabla de la PDB XEPDB1
connect /@XEPDB1 as sysdba
connect /@XEPDB1 as sysdba
select tablespace_name,status from dba_tablespaces;

--Consultar los segmentos de la tabla EMPLOYEES
col SEGMENT_NAME format a20
select segment_name,segment_type,tablespace_name,extents,blocks  from dba_segments where segment_name='EMPLOYEES';

--Consultar la vista de performance V$TABLESPACE
select * from v$tablespace;

-- Creando un tablespace
CREATE TABLESPACE DATOS02
DATAFILE 'C:\app\Cesar\product\18.0.0\oradata\XE\XEPDB1\maestro01.dbf' SIZE 2M
EXTENT MANAGEMENT LOCAL
UNIFORM SIZE 100K;

---------- EJERCICIO 01 - INICIO ---------
connect /@PDBPC1 as sysdba
select * from v$tablespace;

CREATE TABLESPACE TBSMAESTROS
DATAFILE 'C:\app\Cesar\product\18.0.0\oradata\XE\PDBPC1\maestro01.dbf' SIZE 5M;
--EXTENT MANAGEMENT LOCAL
--UNIFORM SIZE 100K;

ALTER TABLESPACE TBSMAESTROS
ADD DATAFILE 'C:\app\Cesar\product\18.0.0\oradata\XE\PDBPC1\maestro02.dbf'
size 15M;

set line 180
col TABLESPACE_NAME format a15
col FILE_NAME format a60
select tablespace_name,file_name,bytes from dba_data_files where tablespace_name='TBSMAESTROS';

--Colocar el tablespace DATOS02 en modo OFFLINE
ALTER TABLESPACE TBSMAESTROS OFFLINE NORMAL;

-- SE CREO UNA CARPETA EN XE Y SE MOVIO UN DATAFILE MANUALMENTE


ALTER TABLESPACE TBSMAESTROS
RENAME DATAFILE 'C:\app\Cesar\product\18.0.0\oradata\XE\PDBPC1\maestro02.DBF'
TO 'D:\PC TableSpace\maestro02.DBF'

--Colocar el tablespace DATOS02 en modo ONLINE

ALTER TABLESPACE TBSMAESTROS ONLINE;



---------- EJERCICIO 01 - FIN ---------










--ELIMINAR UN TABLESPACE
drop tablespace TBSMAESTROS including contents and datafiles;

--Consultamos el diccionario de datos para obtener información del tablespace creado
select tablespace_name,status from dba_tablespaces where tablespace_name='TBSMAESTROS';

-- 3. Crea tablespace UNDO

CREATE UNDO TABLESPACE UNDO02 DATAFILE 'C:\APP\CESAR\PRODUCT\18.0.0\ORADATA\XE\\undotbsp02.dbf' SIZE 2M;

-- Consultamosd la informacion de los tablespaces

select tablespace_name,status from dba_tablespaces;

--4. Creando un tablespace TEMPORARY
CREATE TEMPORARY TABLESPACE TEMP02
TEMPFILE 'C:\APP\CESAR\PRODUCT\18.0.0\ORADATA\XE\XEPDB1\temptbsp02.dbf'
SIZE 2M
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 100K;

-- 5. Redimensionamiento de datafiles
sqlplus /@XEPDB1 as sysdba

--
CREATE TABLESPACE DATOS02
DATAFILE 'C:\app\Cesar\product\18.0.0\oradata\XE\XEPDB1\dflDATOS02.dbf' SIZE 5M;
--b. Consultar el tamaño del datafile
set line 220
col TABLESPACE_NAME format a15
col FILE_NAME format a50
select tablespace_name,file_name,bytes from dba_data_files where tablespace_name='DATOS02';

--c. Consultar el archivo y tamaño del archivo el disco.
host dir C:\app\Cesar\product\18.0.0\oradata\XE\XEPDB1\dflDATOS02.dbf

--d. Aumentar el tamaño del datafile a 15 MB
ALTER DATABASE datafile 'C:\app\Cesar\product\18.0.0\oradata\XE\XEPDB1\maestro01.dbf' resize 5M;

--d. Agregar un datafile al tablespace DATOS02
ALTER TABLESPACE DATOS02
ADD DATAFILE 'C:\app\Cesar\product\18.0.0\oradata\XE\XEPDB1\maestro02.dbf'
SIZE 15M;

---- 7. Mover un datafile-----------------
col TABLESPACE_NAME format a15
col FILE_NAME format a50
select tablespace_name,file_name,bytes
from dba_data_files
where tablespace_name='DATOS02';

-- Consultar el estado del tablespace
SELECT tablespace_name, status from dba_tablespaces;

--Colocar el tablespace DATOS02 en modo OFFLINE
ALTER TABLESPACE DATOS02 OFFLINE NORMAL;

-- SE CREO UNA CARPETA EN XE Y SE MOVIO UN DATAFILE MANUALMENTE


ALTER TABLESPACE DATOS02
RENAME DATAFILE 'C:\app\Cesar\product\18.0.0\oradata\XE\XEPDB1\DFLDATOS02B.DBF'
TO 'D:\PC TableSpace\DFLDATOS02B.DBF'

--Colocar el tablespace DATOS02 en modo ONLINE

ALTER TABLESPACE DATOS02 ONLINE;


------- 8. Eliminar un datafile ------
col TABLESPACE_NAME format a15
col FILE_NAME format a50
select tablespace_name,file_name,bytes
from dba_data_files
where tablespace_name='DATOS02';

-- Eliminar un datafile al tablespace DATOS02
ALTER TABLESPACE DATOS02 DROP DATAFILE 'C:\app\Cesar\product\18.0.0\oradata\XE\LAB05\DFLDATOS02B.DBF';

---------------- EJERCICIO 02 (Archivo LAB REDOLOG.PDF) s03------------------

--6. Activar el modo ARCHIVELOG
--connect /@PDBPC1 as sysdba
sqlplus / as sysdba

--Consultamos el modo de log de la base de datos
select name,log_mode from v$database;


--c. Consultamos el destino de los archivelog
col dest_name format a20
col destination format a37
select dest_name,status,destination from v$archive_dest where status='VALID';


col name format a22
col value format a55
select name,value from v$parameter where name='db_recovery_file_dest';

--d. Consultamos el contenido del directorio de archivelog


host dir C:\app\Cesar\product\18.0.0\dbhomeXE\RDBMS\*.* /b /AD

--Bajamos la base de datos
shutdown immediate

--Iniciamos la base de datos en estado MOUNT
startup mount

--Cambiamos el modo a ARCHIVELOG
alter database archivelog;

--Abrimos la base de datos
alter database open;

--Consultamos el modo de log de la base de datos

select name,log_mode from v$database;



--ruta C:\app\Cesar\product\18.0.0\dbhomeXE\RDBMS














-- PARA CREAR LOS spool LOG

connect /@PDBPC1 as SYSDBA


