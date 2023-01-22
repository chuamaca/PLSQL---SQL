--- hablaremos de VARRAY. 
-- la diferencia con nested table es que este VARRAY es fijo (fix size) (varray(3) en 
-- nro de registros o keys

declare
type t_locations is varray(3) of varchar2(100);

loc t_locations;

begin

loc:=t_locations('jordan','uae','Syria');

dbms_output.put_line(loc(1) );
dbms_output.put_line(loc(2) );
dbms_output.put_line(loc(3) );

end;
-----------------------------------------------

--you can not extend the varray, it will give error
declare
type t_locations is varray(3) of varchar2(100);

loc t_locations;

begin

loc:=t_locations('jordan','uae','Syria');
loc.extend;
loc(4):='aa';
dbms_output.put_line(loc(1) );
dbms_output.put_line(loc(2) );
dbms_output.put_line(loc(3) );

end;
-- dio error porque quiero extender el varray
-------------

declare
type t_locations is varray(3) of varchar2(100);

loc t_locations;

begin
-- NO puedes eliminar un elemento de un VARRAY 
-- desde el inicio o del medio, sino del final.

loc:=t_locations('jordan','uae','Syria');
loc.trim(1); -- this delete one element from last
dbms_output.put_line(loc(1) );
dbms_output.put_line(loc(2) );
---dbms_output.put_line(loc(3) );

end;

-----------------------------------------------

--how to use is in SQL
drop table x_customer;
drop type t_tel;


create or replace type t_tel as varray(10) of number;

create table x_customer
( cust_id number,
  cust_name varchar2(100),
  tel t_tel
)
--no need for this: "nested table tel store as t_tel_tbl;"
-- en nested table sí es necesrio realizar la linea superior, 
-- pero en el caso de VARRAY no es necesario
insert into x_customer (cust_id,cust_name,tel)
values (1,'khaled',t_tel(050121,0501245,0589877));

select * from x_customer;
-- como el anterior el uso de VARRAY no es usual realizarlo en SQL.
