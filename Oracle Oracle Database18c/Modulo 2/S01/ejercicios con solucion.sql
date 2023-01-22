
que esta mal con: 
balance = balance + 2000;



escribir un codigo  plsql que concatenet : "Primera" y "sesion"
y lo asigne a una variable 



EJERCICIO 1
realizar lo necesario para presentar el sgte resultaado :

Hola amigos.! 
Copa america Brasil 2019

-- respuesta

DECLARE 
   --lines dbms_output.chararr; 
   num_lines number:=3; 
BEGIN 
   -- enable the buffer with default size 20000 
   --dbms_output.enable; 
   
   dbms_output.put_line('Hola amigos.!'); 
   dbms_output.put_line('Copa america Brasil 2019 '); 
       
   --dbms_output.get_lines(lines, num_lines); 
   dbms_output.PUT_line(NUM_LINES); 
  
  END; 
/





-- armar un bloque plsql para saber la longitud del texto: 
"gobernadores-regionales-electos-reconocen-lentitud-obras-reconstruccion-noticia"

--RESPUESTA: 

DECLARE
v_desc_size INTEGER(5);
--v_prod_description VARCHAR2(70):='You can use this product with your radios for higher frequency';
v_prod_description VARCHAR2(100):='gobernadores regionales electos reconocen lentitud obras reconstruccion noticia';

BEGIN
-- get the length of the string in prod_description
v_desc_size:= LENGTH(v_prod_description);
DBMS_OUTPUT.PUT_LINE('The length of the product description is:'||v_desc_size);

END;
/



--- mostrar el salario del empleado de ID 178.
-- hacaer uso de la variable de tipo BIND y mostrar ese resultado.

--declare b_emp_salary NUMBER; -- esta linea se puede reemplazar con la uqe sigue.
VARIABLE b_emp_salary NUMBER

BEGIN
    SELECT salary
    INTO   :b_emp_salary
    FROM   employees
    WHERE  employee_id = 178;

END;
/

PRINT b_emp_salary



------------------


Escribir un bloque PL/SQL que calcule la media de dos números dados por el usuario.


SET SERVEROUTPUT ON
SET VERIFY OFF

declare
v_num number:= &v;
d_num number:= &d;
x number;
begin
x:=(v_num+d_num)/2;
dbms_output.put_line('MEDIA '||x);
end;
/