--1 try to execute one block without exception
declare
v_first_name employees.first_name%type;
begin
  
  select first_name into v_first_name
  from
  employees
  where employee_id=1; -- there is no emp_id=1
  
end;
-------------------------------------------------
--2 the solution is to make exception

declare
v_first_name employees.first_name%type;
begin
  
  select first_name into v_first_name
  from
  employees
  where employee_id=1; -- there is not emp_id=1
 dbms_output.put_line(v_first_name);
  exception
  when no_data_found then
  dbms_output.put_line('The query doesn’t retrieve any record');
end;
---------------------------------------------------

--3 many exceptions

declare
v_emp_id employees.employee_id%type;
begin
  
  select employee_id into v_emp_id
  from
  employees
  where first_name=&name; --try 'xyx' then try 'John' then try 1
  
  exception
  when no_data_found then
  dbms_output.put_line('The query doesn’t retrieve any record');
  
  when too_many_rows then
  dbms_output.put_line('The query  retrieve more than one record');
  
  when others then 
  dbms_output.put_line('Other ERROR');
end;
-- esta siempre tiene q ser la utima instruccion o excepcion
----------------------

--this code is wrong
-- porque? Bueno, como el 99 no existe entonces va a ir directamente a la excepcion
-- con lo cual no volvera a ejecutar el codigo y solo se quedara en NULL.

declare
v_first_name employees.first_name%type;

begin
for i in 99..102
  loop
    select first_name into v_first_name
    from
    employees
    where employee_id=i;
     dbms_output.put_line(i||' ' ||v_first_name);
  end loop;
     
     exception
          when no_data_found then
           null; 
end;
-------
--...
-- LA SOLucion es colocar el begin and end dentro del codigo que corresponde al loop
-- con lo cual el exception se relaciona al bloque 
declare
v_first_name employees.first_name%type;

begin
for i in 99..102
  loop
        begin
            select first_name into v_first_name
            from
            employees
            where employee_id=i;
              dbms_output.put_line(i||' ' ||v_first_name);
        exception
          when no_data_found then
           null;
        end;
  end loop;
  
end;

