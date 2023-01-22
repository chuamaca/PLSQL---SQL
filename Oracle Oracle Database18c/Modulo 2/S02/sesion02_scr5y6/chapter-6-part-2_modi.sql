-- leccion muy importante 

declare
x number:=5;
-- el valor de y es NULL.
y number;
begin

  if x<>y then
  -- muchos piensan que al evaluar esta condicion el valor sera : welcome.
  -- estan errados porque cuando se compara con el NULL sale, NULL.
  
  dbms_output.put_line('welcome');
  else
  dbms_output.put_line('Operator with null value always =null');
  end if;

end;

---solution
declare
x number:=5;
y number;
begin

  if nvl(x,0)<>nvl(y,0) then
  dbms_output.put_line('welcome');
  else
  dbms_output.put_line('Operator with null value always =null');
  end if;

end;
-------------------------

declare
-- para este caso ambos valores estan con NULL values
-- pero el valor que dará este bloque de codigo es lo que esta dentro 
-- del else
-- operadores con NULL value siempre darán NULL
x number;
y number;
begin

  if x=y then
  dbms_output.put_line('welcome');
  else
  dbms_output.put_line('Operator with null value always =null');
  end if;

end;

--solution
declare
x number;
y number;
begin
-- para comparar NULL values usar NVL o la palabra NULL
  if x is null and y is null then
  dbms_output.put_line('welcome');
  else
  dbms_output.put_line('Operator with null value always =null');
  end if;

end;
---------------------





