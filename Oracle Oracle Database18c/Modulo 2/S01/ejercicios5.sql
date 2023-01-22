--EJERCICIO 1
--que esta mal con: 
--balance = balance + 2000;
--balance := balance + 2000;



/*EJERCICIO 2
escribir un codigo  plsql que concatenet : "Primera" y "sesion"
y lo asigne a una variable */

declare
v_concatenar varchar2(100);
c_primera constant varchar2(10):='Primera';
c_sesion constant varchar2(10):='sesion';
begin
    v_concatenar:=c_primera||c_sesion;
    dbms_output.put_line('Resultado: '||v_concatenar )  ;
end;


/*EJERCICIO 3
realizar lo necesario para presentar el sgte resultaado :

Hola amigos.! 
Copa america Brasil 2019*/

declare
c_hola constant varchar2(30):='Hola amigos.!';
c_copa constant varchar2(30):='Copa america Brasil 2019';
begin
    dbms_output.put_line(c_hola)  ;
    dbms_output.put_line(c_copa)  ;
end;


/*EJERCICIO 4
-- armar un bloque plsql para saber la longitud del texto: 
"gobernadores-regionales-electos-reconocen-lentitud-obras-reconstruccion-noticia"*/

declare
v_text constant varchar2(300):='gobernadores-regionales-electos-reconocen-lentitud-obras-reconstruccion-noticia';
v_numero number:=10;
begin
    v_numero:=length(v_text);
    dbms_output.put_line('Longitud: '||v_numero)  ;
end;


/*EJERCICIO 5
--- mostrar el salario del empleado de ID 178.
-- hacaer uso de la variable de tipo BIND y mostrar ese resultado.*/
declare
v_id number:=10;
begin
    select EMPLOYEE_ID into v_id from employees where EMPLOYEE_ID = 178;
    dbms_output.put_line('ID: '||v_id)  ;
end;

------------------

/*EJERCICIO 6
Escribir un bloque PL/SQL que calcule la media de dos números dados por el usuario.*/
declare
v_numero1 number:=10;
v_numero2 number:=10;
v_media number:=10;
begin
    v_media:=(v_numero1 + v_numero2)/2;
    dbms_output.put_line('Media: '||v_media)  ;
end;

