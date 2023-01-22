-- ######### CREAR ARCHIVO CSV ############

SHOW CON_NAME
SHO PDBS
ALTER SESSION SET CONTAINER=xepdb1;

alter pluggable database pdborcl open;

select * from dba_users where username='HR';

-- creando archivo SEPARADO POR COMAS #################

 SELECT DIRECTORY_NAME FROM DBA_DIRECTORIES;
 

drop directory DEMO_TALLER;

--CREATE DIRECTORY DEMO_TALLER AS '/home/oracle/tempo';

-- envio 
CREATE DIRECTORY DEMO_TALLER AS 'D:\taller_tempo';

GRANT READ, WRITE ON DIRECTORY DEMO_TALLER TO public;

-- ######## VERIFICAR QUE TABLA SE CARGARA ##########3
-- VISTAS
-- DESCCRIBE COMMAND
-- SE CARGARA LA TABLA HR.COUNTRIES #########
DESC HR.COUNTRIES


DECLARE
    F UTL_FILE.FILE_TYPE;
    CURSOR C1 IS 
		SELECT COUNTRY_ID, COUNTRY_NAME, REGION_ID
		FROM HR.COUNTRIES
		ORDER BY 1 DESC;
    C1_R C1%ROWTYPE;
BEGIN
    F := UTL_FILE.FOPEN('DEMO_TALLER','COUNTRIES.CSV','w',32767);
    FOR C1_R IN C1
    LOOP
        UTL_FILE.PUT(F,C1_R.COUNTRY_ID);
        UTL_FILE.PUT(F,','||C1_R.COUNTRY_NAME);
        UTL_FILE.PUT(F,','||C1_R.REGION_ID);        
        UTL_FILE.NEW_LINE(F);
    END LOOP;
    UTL_FILE.FCLOSE(F);
END;
/

------ ========== LEYENDO ARCHIVO O CARGANDO A LA BD =======================

-- solo para verificar la ddl de la tabla.
set linesize 200
set longchunksize 200000 long 200000 pages 0
select dbms_metadata.get_ddl('TABLE','COUNTRIES','HR') from dual;



 -- conectarse con el usuario hr
 
 drop table HR.COUNTRIES_load purge;
 
CREATE TABLE HR.COUNTRIES_load
   (ID CHAR(2) NOT NULL,
	NAME VARCHAR2(40),
	REGION NUMBER 
	 ) 
	 ;

 DECLARE
   F UTL_FILE.FILE_TYPE;
   V_LINE VARCHAR2 (1000);
      V_id VARCHAR2 (2);
      V_name varchar2(40);
      V_region number;
      
    BEGIN
      F := UTL_FILE.FOPEN ('DEMO_TALLER', 'COUNTRIES.CSV', 'R');
    IF UTL_FILE.IS_OPEN(F) THEN
      LOOP
        BEGIN
          UTL_FILE.GET_LINE(F, V_LINE, 1000);
          IF V_LINE IS NULL THEN
            EXIT;
          END IF;
          v_id := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 1);
          V_name := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 2);
          V_region := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 3);
          --V_DNAME := REGEXP_SUBSTR(V_LINE, '[^,]+', 1, 4);
         INSERT INTO COUNTRIES_load VALUES(v_id, V_NAME, V_region);
          COMMIT;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
          EXIT;
        END;
      END LOOP;
    END IF;
    UTL_FILE.FCLOSE(F);
  END;
/



