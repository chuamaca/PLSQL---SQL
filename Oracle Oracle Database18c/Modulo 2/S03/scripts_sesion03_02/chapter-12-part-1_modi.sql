--let us know why to create a package 

--1 create a function to calc square area
create or replace function square_area
( p_side number )
return number
is
begin

return p_side*p_side;
end;

select square_area(4) from dual;

--------------------------------------------
----1 create a function to calc rectangle area
create or replace function rectangle_area
( p_l number,p_w number )
return number
is
begin

return p_l*p_w;
end;

select rectangle_area(4,5) from dual;
----------------------------------------------------------

--Now because theses 2 functions are logically grouped, 
--it is better to use package
--The code will be more organized  

create or replace package area
is

function square_area( p_side number )
return number;

function rectangle_area( p_l number,p_w number )
return number;

--we dont have begin in package specification
end;


create or replace package body area
is
      function square_area( p_side number )
      return number
      is
      begin
      return p_side*p_side;
      end;

      function rectangle_area( p_l number,p_w number )
      return number
      is
      begin
      return p_l*p_w;
      end;
--the begin section is optional--we use it for initilization
begin
DBMS_OUTPUT.PUT_LINE('welcome ');
    
end;


-- ojo cuando se ejecutan los codigos del pkg con select 
-- no se visualiza en el dbms_output
select area.square_area(4) from dual;
select area.rectangle_area(4,10) from dual;

-- pero sí se visualiza cuando se coloca el pkg dentro del dbms_output
-- aparece el resultado del mismo pakg y ademas el que corresponde a la fnc o proc q se usa:
begin
DBMS_OUTPUT.PUT_LINE(area.square_area(4));
end;



--so now no need for square_area, rectangle_area which created in step 1,2

drop function square_area;

drop function rectangle_area;





