/* 1-  create a procedure that take emp_id as parameter and return the 
first_name and salary
note: use bind variable to print the firat_name and salary
*/

create or replace procedure query_emp
(p_emp_id employees.employee_id%type,  -- este es del tipo IN parametro
 p_f_name out employees.first_name%type,  -- los dos sgtes son del tipo OUT parameter
 p_sal out employees.salary%type
 )
is

begin
   select first_name,salary
   into p_f_name,p_sal
   from
   employees
   where employee_id=p_emp_id;

exception
when others then 
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);

end;
-----------------------------------------------------------------------
-- cuando tienes que imprimir variables tipo OUT, tienes que definir variables de tipo BIND.
--you should declare 2 bind variables
variable b_first_name varchar2(100)
variable b_sal number
/* cuando usa bind variable con VARCHAR2 tienes que colocar el size.
cuando usas bind variable con NUMBER no debes de colocar el size.
Esto se usa cuando se tiene el procedure con OUT parameter (2 out = 2 bind variable)
*/
execute query_emp(105,:b_first_name,:b_sal )

print b_first_name b_sal ;

-- no es muy recomendable usar este tipo de codigo para imprimir las variables del procedure.
-- no es muy usado
-----------------------------------------------------------------------

--2 the other way to print the out parameter:

declare
-- definir dos variables, una por cada OUT parameter:
v_first_name employees.first_name%type;
v_sal employees.salary%type;
begin
 query_emp(105,v_first_name,v_sal ); -- (porque no se le coloca el "execute" para ejecutar el proc?)
-- ... y despues se imprime mediante el dbms_output_put_line:
 dbms_output.put_line(v_first_name);
  dbms_output.put_line(v_sal);
end;


