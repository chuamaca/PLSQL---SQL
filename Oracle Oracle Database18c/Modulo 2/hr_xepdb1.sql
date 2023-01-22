select * from employees Where Employee_id = 206;

begin
update employees set salary = 0  where  Employee_id = 207;
exception
when no_data_found then
dbms_output.put_line('xyz');
end;

--5
declare
v_lastname employees.first_name%type;
begin
select last_name into v_lastname
  FROM employees where Employee_id = 100;
dbms_output.put_line(v_lastname);
exception
when others then null;
when no_data_found then
dbms_output.put_line('Thge query doenst retrive any record');
end;




declare
v_lastname employees.first_name%type;
begin

select last_name into v_lastname
  FROM employees where Employee_id = 100;
dbms_output.put_line(v_lastname);

end;
