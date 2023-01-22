-- GROUP FUNCTIONS AND EXCEPTIONS
------------------------------------
-- valores a usar en el ejemplo: 10 y 888

select * from EMPLOYEES
where EMPLOYEE_ID=15154;

select sum(salary) from employees
where DEPARTMENT_ID=888; -- este resultado arroja NULL value

Declare
v_sum_sal number;
begin
   
   select sum(salary) into v_sum_sal
   from employees
   where DEPARTMENT_ID=&dno;
   DBMS_OUTPUT.PUT_LINE('the sum is '||v_sum_sal);
   DBMS_OUTPUT.PUT_LINE(sql%rowcount);
   
   
   EXCEPTION 
   when no_data_found then
   DBMS_OUTPUT.PUT_LINE('no data found');

end;
--------------------------------------------------------
/* entonces el codigo anterior no tiene una EXCEPTION para validar o denotar
el NULL value. por lo tanto se usa el sgte codigo: 
*/

Declare
v_sum_sal number;
v_er exception;
begin
   
   select sum(salary) into v_sum_sal
   from employees
   where DEPARTMENT_ID=&dno;
   
   if v_sum_sal is not null then  -- se hace la pregunta si el resultado no es nulo
   DBMS_OUTPUT.PUT_LINE('the sum is '||v_sum_sal);
   DBMS_OUTPUT.PUT_LINE(sql%rowcount);
   else
   raise v_er; -- levantas la excepcion
   end if;
  
   EXCEPTION 
   when v_er then
   DBMS_OUTPUT.PUT_LINE('no data found');

end;

------------------
-- MANY BLOCKS AND MANY EXCEPTIONS
------------------------
-- en este caso si la excepcion no es manejada en el bloque interno
-- entonces se manejara desde el externo,
-- primer caso: probar con el valor 888
-- segundo caso: probar con el valor 10 (porque sale error?) -- error manejado por el bloque de fuera.

Declare
v_sum_sal number(2);
v_er exception;
begin
   
   begin
   select sum(salary) into v_sum_sal
   from employees
   where DEPARTMENT_ID=&dno;
    
       if v_sum_sal is not null then 
       DBMS_OUTPUT.PUT_LINE('the sum is '||v_sum_sal);
       DBMS_OUTPUT.PUT_LINE(sql%rowcount);
       else
       raise v_er;
       end if;
   
   EXCEPTION 
   when v_er then
   DBMS_OUTPUT.PUT_LINE('no data found');
   end;
   
EXCEPTION    
when others then 
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);
end;
