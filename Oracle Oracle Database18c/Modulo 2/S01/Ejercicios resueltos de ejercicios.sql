declare
 v_balance Decimal:=2000;
begin
dbms_output.put_line(v_balance);
end;

declare
 v_valor NVARCHAR2(50);
begin
v_valor:=CONCAT('Primera ', ' sesion');
dbms_output.put_line(v_valor);
end;

begin
dbms_output.put_line('Hola amigos.! ');
dbms_output.put_line('Copa america Brasil 2019');
end;


select LENGTH('gobernadores-regionales-electos-reconocen-lentitud-obras-reconstruccion-noticia') FROM DUAL;



variable v_salary number
set autoprint on
BEGIN
SELECT salary INTO :v_salary FROM employees WHERE employee_id=178;
END;


declare
v_a DECIMAL:=10;
v_b DECIMAL:=10;
BEGIN
dbms_output.put_line(AVG(v_a,v_b));
END;







