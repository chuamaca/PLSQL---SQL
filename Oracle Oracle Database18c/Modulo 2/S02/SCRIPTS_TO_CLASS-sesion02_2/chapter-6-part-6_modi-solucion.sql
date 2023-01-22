declare
v_star varchar2(100);
begin
for i in 1..5
  loop
        for j in 1..i
        loop
        v_star:=v_star||'*';
    
        end loop;
  dbms_output.put_line(v_star); 
  v_star:=null;
  end loop;
end;