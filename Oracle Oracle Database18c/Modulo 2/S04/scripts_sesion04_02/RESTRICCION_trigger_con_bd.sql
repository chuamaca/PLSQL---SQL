

-------- restriccion de operaciones en la base de datos.
-- trigger on schema
-- ejecutar cada instruccion. Una por una.

CREATE OR REPLACE TRIGGER before_create_trigger
BEFORE CREATE
 ON SCHEMA
BEGIN
if  to_number(to_char(sysdate,'hh24')) between 8 and 23 then
raise_application_error(-20001, 'no esta permitida la creacion de tablas');
end if;
END;
/

-- deberia de salir un error porque la hora de creacion se esta restringiendo:
create table  t2 (value1 number );

create or replace view x_y as select * from employees;
-- 	create or replace view x_y as select * from dba_views;

drop trigger before_create_trigger;


