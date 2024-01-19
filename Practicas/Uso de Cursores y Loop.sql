declare
  v_job_title jobs.job_title%type;
begin
  select job_title into v_job_title from jobs where job_id = 'AD_VP';
  dbms_output.put_line(v_job_title);
end;


-- Numeros Multiples
declare
  v_multiple number := 0;
begin
  for v_numero in 1 .. 100 loop
    if (mod(v_numero, 3) = 0) then
    
      v_multiple := v_multiple + 1;
      dbms_output.put_line('Los numeros Multiples de 3 son: ' ||
                           v_multiple);
    end if;
  end loop;
end;

/*
Elabore un bloque anónimo PL/SQL que almacene en un 
objeto cursor la lista de empleados
 (código, nombres, apellidos y salario) 
 que tiene un sueldo menor e igual $ 2,800. 
 Mostrar el resultado por cada registro. 
 Utilizar el esquema de base de datos HR (Human Resources)
  que viene por defecto en Live SQL.*/
  
  DECLARE
    CURSOR c_employees is
      select employee_id, first_name, last_name, salary
        from employees
       where salary <= 2500;
  
    v_employee_id employees.employee_id%type;
    v_firts_name  employees.first_name%type;
    v_last_name   employees.last_name%type;
    v_salary      employees.salary%type;
    v_num number :=0;
  
  begin
    open c_employees;
    loop
      fetch c_employees
        into v_employee_id, v_firts_name, v_last_name, v_salary;
      exit when c_employees%notfound;
      v_num := v_num + 1;
      dbms_output.put_line('Sueldos menores a 2500 ' || v_employee_id || ' ' ||
                           v_firts_name || ' ' || v_last_name || ' - ' ||
                           v_salary);
    end loop;
    close c_employees;
  end;


-- Practicando PLSQL
declare
  v_job_id    jobs.job_id%type;
  v_job_title jobs.job_title%type;

  cursor c_cursor_Jobs is
    select job_id, job_title from jobs;
begin
  open c_cursor_Jobs;

  loop
    fetch c_cursor_Jobs
      into v_job_id, v_job_title;
    exit when c_cursor_Jobs%Notfound;
    dbms_output.put_line('Id: ' || v_job_id || ' Nombre: ' || v_job_title);
  end loop;
  close c_cursor_Jobs;
End;









