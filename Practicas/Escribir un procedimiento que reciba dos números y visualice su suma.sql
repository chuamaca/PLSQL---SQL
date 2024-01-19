-- Escribir un procedimiento que reciba dos números y visualice su suma

Create or replace procedure sumar_numeros
(
v_num1 number,
v_num2 number
)
is
v_suma number(6);
begin
  v_suma:=v_num1 + v_num2;
  dbms_output.put_line('La suma es: '|| v_suma);
end sumar_numeros;

-- Codificar un procedimiento que reciba una cadena y la visualice al revés.
create or replace procedure cadena_reves(v_cadena varchar2) as
  v_cad_reves varchar2(50);
begin
  for i in reverse 1 .. length(v_cadena) loop
    v_cad_reves := v_cad_reves || substr(v_cadena, i, 1);
  end loop;
  dbms_output.put_line(v_cad_reves);
end cadena_reves;


/*Escribir una función que reciba una fecha y devuelva el año, en número,
correspondiente a esa fecha

*/
create or replace function anio(v_fecha date) return number as
  v_anio number(4);
begin
  v_anio := to_number(to_char(v_fecha,'YYYY');
  return v_anio;
end anio;

-- Haciendo uso de la Funcion
declare
  v_numero number(4);
begin
  v_numero := hr.anio(sysdate);
  dbms_output.put_line('La año en numeros es: ' || v_numero);
end;


create or replace procedure crear_departamento(v_department_name departments.department_name%type,
                                               v_manager_id      departments.manager_id%type default '',
                                               v_location_id     departments.location_id%type default 1700) as
begin
 insert into departments values(departments_seq.nextval,v_department_name,v_manager_id,v_location_id);
end crear_departamento;



