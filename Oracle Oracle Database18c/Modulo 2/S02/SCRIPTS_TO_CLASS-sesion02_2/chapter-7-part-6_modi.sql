-- se almacena en el arreglo la tabla employees con todas sus columnas completas.
-- el valor en el arreglo es un registro que contiene todas las cols de employees table.

declare
type tab_no is table of employees%rowtype
index by pls_integer;

v_tab_no tab_no;
v_total number;

begin
-- si se ingresan solo 3 valores quiere decir que las otras columnas 
-- contienen NULL values

v_tab_no(1).employee_id:=1;
v_tab_no(1).first_name:='ahmed';
v_tab_no(1).last_name:='jad';

v_tab_no(2).employee_id:=2;
v_tab_no(2).first_name:='khaled';
v_tab_no(2).last_name:='yaser';

dbms_output.put_line(v_tab_no(1).employee_id||' '||v_tab_no(1).first_name||' '||v_tab_no(1).last_name);
dbms_output.put_line(v_tab_no(2).employee_id||' '||v_tab_no(2).first_name||' '||v_tab_no(2).last_name);

end;
----------------------------

declare
-- definicion del arreglo
type tab_no is table of employees%rowtype
index by pls_integer; -- es la key
-- variable de tipo arreglo:
v_tab_no tab_no;

begin
 for i in 100..104
 loop
 select * into v_tab_no(i)
 from
 employees 
 where employee_id=i;
 dbms_output.put_line(v_tab_no(i).employee_id||' '||
                      v_tab_no(i).first_name||' '||v_tab_no(i).last_name  
                     );
 end loop;
 

end;
-------------------------------------

declare
type tab_no is table of employees%rowtype
index by pls_integer;

v_tab_no tab_no;

begin
 for i in 100..104
   loop
   select * into v_tab_no(i)
   from
   employees 
   where employee_id=i;
  
   end loop;
 
 for i in v_tab_no.first..v_tab_no.last
   loop
   -- se puede hacer uso o mandar a imprimir las cols que uno desee porque el
   -- arreglo contiene todas las cols de la tabla employees
    dbms_output.put_line(v_tab_no(i).employee_id);
    dbms_output.put_line(v_tab_no(i).first_name);
    dbms_output.put_line(v_tab_no(i).last_name);
    dbms_output.put_line(v_tab_no(i).salary);
   end loop;
 
end;

