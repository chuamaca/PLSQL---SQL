DECLARE
-- defines un tipo  registro: 
TYPE t_EMP IS RECORD
( V_EMP_id employees.employee_id%type,
  v_first_name employees.first_name%type,
  v_last_name employees.last_name%type
);
-- defines la variable de tipo registro: 
v_emp t_EMP;
-- esta es una forma de mencionar, colocando cada variable correspondiente
-- a cada campo
BEGIN
  select employee_id  ,first_name        ,last_name
  into v_emp.V_EMP_id, v_emp.v_first_name,v_emp.v_last_name
  from
  employees 
  where employee_id=100;
  dbms_output.put_line(v_emp.V_EMP_id||' '||v_emp.v_first_name||' '||v_emp.v_last_name);
END;

----

DECLARE
TYPE t_EMP IS RECORD
( V_EMP_id employees.employee_id%type,
  v_first_name employees.first_name%type,
  v_last_name employees.last_name%type
);

v_emp t_EMP;
-- otra manera de realizar lo de la parte superio

BEGIN
  select employee_id  ,first_name        ,last_name
  into v_emp -- difernete con respecto a la parte superior. Para usar este tipo de variable
  -- se debe de colocar en el select todos los campos de la tabla
  from
  employees 
  where employee_id=100;
  dbms_output.put_line(v_emp.V_EMP_id||' '||v_emp.v_first_name||' '||v_emp.v_last_name);
END;


-- ahora el ejemplo superior pero con loop

DECLARE
TYPE t_EMP IS RECORD
( V_EMP_id employees.employee_id%type,
  v_first_name employees.first_name%type,
  v_last_name employees.last_name%type
);

v_emp t_EMP;

BEGIN
  for i in 100..103
  loop
	  select employee_id  ,first_name        ,last_name
	  into v_emp
	  from
	  employees 
	  where employee_id=i;
  dbms_output.put_line(v_emp.V_EMP_id||' '||v_emp.v_first_name||' '||v_emp.v_last_name);
  end loop;
  
END;
