VARIABLE b_emp_salary NUMBER
BEGIN
select salary into : b_emp_salary from 
hr.employees where employee_id=178;
end;
/

select first_name, last_name from hr.employees where salary=:b_emp_salary;
