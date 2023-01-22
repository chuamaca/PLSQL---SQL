-- ingresar al putty. 
-- colocar la ip respectiva.
-- hacer logon con el usuario oracle.
-- ejecutar: sqlplus / as sysdba
-- continuar con el laboratorio:

------------------------------------------------------------------
---------------- EJERCICIOS CON EL DBA_OBJECTS------------------------
------------------------------------------------------------------

-- Create Table with same structure as dba_tables from Oracle Dictionary
set timi on 

create table bigtab
as
select rownum id, a.*
  from dba_objects a
 where 1=0;

 alter table bigtab nologging;

-- Fill 5'000'000 Rows into the Table
declare
    l_cnt  number;
    l_rows number := 1000000;
begin
    -- Copy dba_objects
    insert /*+ append */ into bigtab
    select rownum, a.*
      from dba_objects a;
    l_cnt := sql%rowcount;
    commit;

    -- Generate Rows
    while (l_cnt < l_rows)
    loop
        insert /*+ APPEND */ into bigtab
        select rownum+l_cnt,
               OWNER, OBJECT_NAME, SUBOBJECT_NAME,
               OBJECT_ID, DATA_OBJECT_ID,
               OBJECT_TYPE, CREATED, LAST_DDL_TIME,
               TIMESTAMP, STATUS, TEMPORARY,
               GENERATED, SECONDARY, NAMESPACE, EDITION_NAME
          from bigtab
         where rownum <= l_rows-l_cnt;
        l_cnt := l_cnt + sql%rowcount;
        commit;
    end loop;
end;
/

-- ejecutamos estadisticas :
EXEC DBMS_STATS.gather_table_stats(USER, 'bigtab', cascade=>TRUE);

-- =========================
-- ver el plan de ejecucion: 
SET AUTOTRACE TRACEONLY EXP
set line 200
SELECT * FROM bigtab WHERE object_id = 100;

-- es columna candidata?
-- se hacen wheres constantemente?
-- son valores unicos?

CREATE INDEX bigtab_objid ON bigtab(object_id);

-- ejecutar de nuevo la sentencia: 
SELECT * FROM bigtab WHERE object_id = 100;
-- está pasando por el índice construído?

-- este índice debería de ser PK o primary key ??
-- si es así entonces ejecutar: 
alter table bigtab add constraint PK_BIGTAB_OBJID primary key  (object_id) using index bigtab_objid;
-- todo bien ?? o algun error? ¿porqué?


-----------------------------------------------------------
-- VIRTUAL INDICES -- 9i
----------------------------------------------------------
drop table objects_tab purge;


CREATE TABLE objects_tab AS SELECT * FROM all_objects;

ALTER TABLE objects_tab ADD (
  CONSTRAINT objects_tab_pk PRIMARY KEY (object_id)
);
  
EXEC DBMS_STATS.gather_table_stats(USER, 'objects_tab', cascade=>TRUE);


-- plan de ejecucion

SET AUTOTRACE TRACEONLY EXP
set line 200
SELECT * FROM objects_tab WHERE object_id = 10;
-- (ver que pasa por el idx)

-- Full scan table:
SET AUTOTRACE TRACEONLY EXP
SELECT * FROM objects_tab WHERE object_name = 'USER_TABLES';
-- (ver que no pasa por idx)
CREATE INDEX objects_tab_object_name_vi ON objects_tab(object_name) NOSEGMENT;

--repetir el query:
SET AUTOTRACE TRACEONLY EXP
SELECT * FROM objects_tab WHERE object_name = 'USER_TABLES';

-- que paso? porque no se ve? -- habilitar el parametro.
ALTER SESSION SET "_use_nosegment_indexes" = TRUE;

SET AUTOTRACE TRACEONLY EXP
SELECT * FROM objects_tab WHERE object_name = 'USER_TABLES';

-- generando estadisticas
EXEC DBMS_STATS.gather_index_stats(USER, 'objects_tab_object_name_vi');


------------------------------------------------------------
-- INVISIBLE INDEX 
------------------------------------------------------------
create table t as select * from USER_objects;

-- CREAR INDICE INVISIBLE
create index t_ind1 on t(object_name) invisible;

-- VIENDO EL TIPO DE INDICE CREADO EN LA VISTA DINAMICA
select index_name,VISIBILITY from DBA_INDEXES where index_name='T_IND1';
SET AUTOTRACE TRACEONLY EXP
-- VEAMOS SI USA EL INDICE: 
select * from t where object_name='STANDARD';


-- ACTIVANDO EL PARAMETRO A NIVEL DE SESION:
ALTER SESSION SET "OPTIMIZER_USE_INVISIBLE_INDEXES" = TRUE;

-- VEAMOS AHORA 
SET AUTOTRACE TRACEONLY EXP
select * from t where object_name='STANDARD';

-- ABRIR OTRA SESION EN PUTTY  y ejecutar el mismo query
SET AUTOTRACE TRACEONLY EXP
select * from t where object_name='STANDARD';

-- SI EL INDICE es usado y causa impacto, puedes hacer el indices VISIBLE.
alter index t_ind1 visible;

-- verificar en las sesiones si es que hace uso del indice.
SET AUTOTRACE TRACEONLY off
select index_name,VISIBILITY from DBA_INDEXES where index_name='T_IND1';

SET AUTOTRACE TRACEONLY off