-- este es solo figurativo. 
create or replace PROCEDURE p(x boolean)
is
begin

    if x then
    DBMS_OUTPUT.PUT_LINE('x is true');
    end if;
end;

-----
declare
v boolean;
begin
v:=true;
p(v);

end;
----------------
-- este sí se puede probar y verificar despues en la tabla departments
create or replace PROCEDURE test_plsql_records
( rec in DEPARTMENTS%rowtype )
is
begin
insert into DEPARTMENTS values rec;

end;

-------
declare
v DEPARTMENTS%rowtype;
begin
v.DEPARTMENT_ID:=3;
v.DEPARTMENT_NAME:='v dept';

test_plsql_records (v);
end;

select * from DEPARTMENTS


