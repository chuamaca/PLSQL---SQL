drop table t1;

create table t1
( emp_id number,
 ename varchar2(100)
);

insert into t1 values (1,'ford');
insert into t1 values (2,'aya');

---statement trigger
create or replace trigger t1_b4_update
before update --this timing + event 
on t1 -- t1 es el nombre de la tabla
begin
DBMS_OUTPUT.PUT_LINE(':)');
end;

-- el sgte update solamente actualizara una sola fila de las dos
-- que tiene la tabla t1. El trigger sí se ejecutará.
update t1
set ename=ename||' s';

-- en el sgte update no existe un emp_id=5555
-- el trigger se ejecutará a pesar de que no se actualizara ningun registro
update t1
set ename=ename||' s'
where emp_id=5555;

------------------------

--row trigger
create or replace trigger t1_b4_update
before update --this timeing + event 
on t1
for each row -- se le agrega para hacerlo de tipo row trigger
begin
DBMS_OUTPUT.PUT_LINE(':)');
end;


-- ahora el trigger se ejecutara 2 veces. observar el dbms output
update t1
set ename=ename||' s';

-- el update no actualizara ningun registro y por lo tanto
-- el trigger tampoco se ejecutara
update t1
set ename=ename||' s'
where emp_id=5555;


