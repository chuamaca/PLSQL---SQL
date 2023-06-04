/**/

declare
  c_first_name hr.employees.first_name%type;
begin
  select first_name
    into c_first_name
    from hr.employees
   where employee_id = 100;
  Dbms_Output.put_line(c_first_name);
end;

Declare
  v_name varchar(20) := 'Cesar Huamani';
begin
  dbms_output.put_line(v_name);
end;

declare
  v_emp_job       varchar(20);
  v_count_loop    BINARY_INTEGER := 0;
  v_dep_total_sal number(9, 2) := 98.8777;
  v_orderdate     date := sysdate + 7;
  c_tax_rate constant number(3, 2) := 8.25;
  v_valid boolean := true;
begin
  dbms_output.put_line(v_emp_job || v_count_loop || v_dep_total_sal || v_orderdate || c_tax_rate || 'Hola Mundo');
end;





-- Funcion para determinar si es verdadero o falso

create or replace function DeterminarBoleano( valor boolean) 
return varchar2
is
begin
return case valor when true then 'Verdadero' else 'False'
end;
end;

-- Opcion 2 determinar valor Boleano
CREATE OR REPLACE FUNCTION func_boo(ip_b_var1 BOOLEAN) RETURN VARCHAR2 IS
BEGIN
  RETURN CASE WHEN ip_b_var1 THEN 'True' WHEN NOT ip_b_var1 THEN 'False' ELSE 'Null' END;
END;



/*Declaracion para Valores Boleanos*/
declare
  v_valido boolean not null := true;
  v_rta varchar(20);
  
begin
  v_rta:=hr.DeterminarBoleano(v_valido);
  dbms_output.put_line(v_rta);
end;




-- Uso de DECODE
SELECT hr.employees.first_name,
       DECODE(job_id,
              'IT_PROG',
              'Programador',
              'AD_VP',
              'Administrador',
              'FI_ACCOUNT',
              'Gerente',
              'Otros') result
  FROM hr.employees;
  









