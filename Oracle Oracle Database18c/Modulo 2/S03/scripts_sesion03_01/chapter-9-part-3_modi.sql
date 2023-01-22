-- USER DEFINED EXCEPTION

select * from employees
where employee_id=1;
----------------------
-- el sgte seccion no contiene resultado alguno.
-- no emite ORA error u otro error relacionado con la data porque es una sentencia UPDATE valida.

declare
v_employee_id number:=1;

begin
update employees
set salary=20000
where employee_id=v_employee_id;

dbms_output.put_line(sql%rowcount);

end;
--------------------------------------


declare
v_employee_id number:=1;
e_invalid_no exception; -- aca no tenemos PRAGMA porque el update no es un oracle server error. 
-- es decie no es un error ORA-XXXXX
begin

update employees
set salary=20000
where employee_id=v_employee_id;
 
 dbms_output.put_line(sqlcode);
 dbms_output.put_line(sqlerrm); -- IMPRIMO esto pero en realidad no tengo ningun ora-xxx porque el update
 -- es un statement normal.
-- la impresion del sqlcode es cero (0) porque no hay error ORA alguno. 

 if sql%notfound then -- el sql%notfound es TRUE porque el UPDATE no tiene ningun registro que actualizar.
 raise e_invalid_no; -- entonces, ENTRA al bloque y levanta a excepcion
 end if;
 
 commit;

 exception 
 when e_invalid_no then
 dbms_output.put_line('invalid emp ID');
 dbms_output.put_line(sqlcode); -- el sqlcode para la seccion de exception del programador siempre es 1
 dbms_output.put_line(sqlerrm); -- el sqlerrm es "user-defined exception" para el excepcion del programador
end;
------------------------
/* en este otro ejemplo se pueden obviar algunas de las sentencias anteriores
y levantar codigos y descripcion de errores :
*/

declare
v_employee_id number:=1;
---e_invalid_no exception;
begin

update employees
set salary=20000
where employee_id=v_employee_id;
 

 if sql%notfound then
 ---raise e_invalid_no;
 raise_application_error(-20000, 'invalid emp ID'); 
 -- l codigo de error se puede levantar desde 20000 hasta 20999
 end if;
 
 commit;

end;

