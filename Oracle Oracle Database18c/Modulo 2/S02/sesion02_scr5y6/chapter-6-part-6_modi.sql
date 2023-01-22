begin
  for i in 1..3

  loop
  dbms_output.put_line('welcome '||i);
  end loop;

end;
------------------------
begin
  for i in 1..1

  loop
  dbms_output.put_line('welcome '||i);
  end loop;

end;
--------------------
-- en este caso oracle define implicitamente la variable i
-- como de tipo integer
begin
  for i in 3..5

  loop
  dbms_output.put_line('welcome '||i);
  end loop;

end;
----------------
-- ojo con el reverse. Esto toma la lista en el for loop
-- al revés.
begin
  for i in reverse 1..3 

  loop
  dbms_output.put_line('welcome '||i);
  end loop;

end;
-------------------------
-- en el sgte ejemplo oracle tomara el resultado de la division 9/2=4.5
-- pero lo redondea a 5. es decir lo ejecutará 5 veces.

begin
  for i in 1..9/2

  loop
  dbms_output.put_line('welcome '||i);
  end loop;

end;
------------------------------------------------
-- ahora un ejemplo real: 

declare
v_name varchar2(200);
begin
for i in 100..102
    loop
        select first_name||' '||last_name
        into v_name
        from
        employees
        where employee_id=i;
        
        dbms_output.put_line(i||':'||v_name);
        
    end loop;
end;

-- ejercicio

/*
try to do print this 

*
**
***
****
*****

*/


  


