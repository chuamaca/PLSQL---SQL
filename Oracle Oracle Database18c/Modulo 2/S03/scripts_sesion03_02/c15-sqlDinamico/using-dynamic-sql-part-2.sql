-- EXECUTE IMMEDIATE with USING
delete from emp1;

select * from emp1;

--this proc can work with any table contain 1 coulmn and this column should be number
create or replace procedure add_rows 
( p_table_name varchar2,p_value number )
is
begin
-- puedo colocar la sgte linea, la cual es correcta: 
--EXECUTE IMMEDIATE 'insert into '||p_table_name ||' values('||p_value||') ';
-- pero para hacer uso del USING, uso la sgte linea: 
EXECUTE IMMEDIATE 'insert into '||p_table_name ||' values(:1) ' using p_value;
end;

-- ejecuto
execute add_rows ('emp1',10);

select * from emp1;
------------------------------
-- otro ejemplo con el USING: 
delete emp1;

create or replace procedure add_rows 
( p_table_name varchar2,p_value number )
is
val1 number:=20;
val2 number:=30;
begin
EXECUTE IMMEDIATE 'insert into '||p_table_name ||' values(:1) ' using p_value;
EXECUTE IMMEDIATE 'insert into '||p_table_name ||' values(:yy) ' using val1;
EXECUTE IMMEDIATE 'insert into '||p_table_name ||' values(:uuu) ' using val2;
end;

execute add_rows ('emp1',10);

select * from emp1;
-----------------------------------------------


