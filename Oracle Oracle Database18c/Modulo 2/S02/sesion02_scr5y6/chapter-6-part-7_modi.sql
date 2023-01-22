-- resolver el sgte ejercicio. 
-- print en ese orden las estrellas que se muestran.

/*
try to do print this 

*
**
***
****
*****

*/





--------------------------------

-- oracle le puede dar nombres a los loops
-- estos nombres son llamados LABELS

declare
v_star varchar2(100);
begin
<<outer_loop>>
for i in 1..5
  loop
        <<inner_loop>>
        for j in 1..i
        loop
        v_star:=v_star||'*';
		
		end loop inner_loop;
  dbms_output.put_line(v_star); 
  v_star:=null;
  end loop outer_loop;
end;
-----------------------------------------

declare
v_star varchar2(100);
begin
<<outer_loop>>
for i in 1..5
  loop
        <<inner_loop>>
        for j in 1..i
        loop
        v_star:=v_star||'*';
        exit;  -- si le pongo este exit el control regresa al outer_loop por lo tanto
				-- el inner_loop solo ejecutara una sola vez.        
        end loop inner_loop;
  dbms_output.put_line(v_star); 
  v_star:=null;
  end loop outer_loop;
end;

-------------------

declare
v_star varchar2(100);
begin
<<outer_loop>>
for i in 1..5
  loop
        <<inner_loop>>
        for j in 1..i
        loop
        v_star:=v_star||'*';
        exit outer_loop when i=3 ;
        end loop inner_loop;
  dbms_output.put_line(v_star); 
  v_star:=null;
  end loop outer_loop;
end;

-- el beneficio es hacer un exit al outer_loop desde el inner_loop (desde adentro)
