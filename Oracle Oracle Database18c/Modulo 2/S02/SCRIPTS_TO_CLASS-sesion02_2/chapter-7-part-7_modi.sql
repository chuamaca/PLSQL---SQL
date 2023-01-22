-- nested tables

declare
type t_locations is table of varchar2(100);

loc t_locations;

begin

loc:=t_locations('USA','UK','JORDAN');

dbms_output.put_line(loc(1) );
dbms_output.put_line(loc(2) );
dbms_output.put_line(loc(3) );

end;
-----------------
-- ahora haremos el ejercicio con el for i

declare
type t_locations is table of varchar2(100);

loc t_locations;

begin

loc:=t_locations('USA','UK','JORDAN');
  for i in loc.first..loc.last -- estos metodos solo funcionan con NESTED TABLES
    loop
  dbms_output.put_line(loc(i) );
  end loop;

end;
-----------------
--otro  ejemplo

declare
type t_locations is table of varchar2(100);

loc t_locations;

begin

loc:=t_locations('USA','UK','JORDAN');
-- ".extend" significa que deseo agregar otro valor al arreglo o al neste table
loc.extend;
loc(4):='Lebanon';
dbms_output.put_line(loc(1) );
dbms_output.put_line(loc(2) );
dbms_output.put_line(loc(3) );
dbms_output.put_line(loc(4) );

end;
---------------------

declare
type t_locations is table of varchar2(100);

loc t_locations;

begin

loc:=t_locations('jordan','uae','Syria');
loc.delete(2); -- voy a eliminar el registro con key=2 
loc(2):='Iraq'; -- luego lo reemplazo por Iraq.
dbms_output.put_line(loc(1) );
dbms_output.put_line(loc(2) );
dbms_output.put_line(loc(3) );

end;
------------------------------------------------------------------------

--how to use is in SQL
drop table x_customer;
drop type t_tel;


create or replace type t_tel as table of number;

create table x_customer
( cust_id number,
  cust_name varchar2(100),
  tel t_tel
)
nested table tel store as t_tel_tbl; -- nested table in sql necesita un storage area: t_tel_tbl

insert into x_customer (cust_id,cust_name,tel)
values (1,'khaled',t_tel(050121,0501245,0589877));

select * from x_customer;
-- normalmente no se hace esto en sql sino en plsql
-- porque es mas manejable en plsql.







