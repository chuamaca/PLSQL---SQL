Declare
Cursor c_employee_salary is
SELECT first_name, last_name, salary from employees;
v_first_name employees.first_name%type;
v_last_name employees.last_name%type;
v_salary employees.salary%type;
 
Begin
open c_employee_salary;
    FETCH c_employee_salary into v_first_name, v_last_name, v_salary;
    dbms_output.put_line(v_first_name ||' '|| v_last_name || ' Gana ' || v_salary );
close c_employee_salary;
End;