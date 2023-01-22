-- exception handling in multiple blocks
-- la tabla que esta en el script anterior, crearla pero no agregarle resgistro alguno, 

delete products;

truncate table products;

select * from products;

create or replace procedure add_products
(p_prod_id number,p_prod_name varchar2:='Ukowun',p_prod_type  varchar2 default 'Ukowun')
is
begin

  insert into products values (p_prod_id,p_prod_name,p_prod_type);
  dbms_output.put_line(p_prod_id||' '||p_prod_name||'  inserted ' );
 commit;

exception
when others then
dbms_output.put_line ('error in insert '||p_prod_id||' '||p_prod_name);
dbms_output.put_line (sqlcode);
dbms_output.put_line (sqlerrm);
end;
-----------

begin
add_products(10,'PC');
add_products(10,'Labtop'); -- al ingresar este registro emitira un error por la PK
add_products(20,'Keyboard');
end; 

-- reviso que solo dos registros hayan sido ingresados: 
select * from products;
-- es importante manejar la excepcion en el procedimiento.
-----------------------------------------------------------------------------------------------

-- en esta parte la excepcion NO esta en el procedimiento.
delete products;
select * from products;


create or replace procedure add_products
(p_prod_id number,p_prod_name varchar2:='Ukowun',p_prod_type  varchar2 default 'Ukowun')
is
begin

  insert into products values (p_prod_id,p_prod_name,p_prod_type);
  dbms_output.put_line(p_prod_id||' '||p_prod_name||'  inserted ' );
 commit;
end;
-----------
-- como la excepcion no estan el prc solo ingresara un registro
begin
add_products(10,'PC');
add_products(10,'Labtop');
add_products(20,'Keyboard');
end;

select * from products;
----------------------------------------------------------------------------------------------
-- OJO donde esta yendo o ubicado el commit. 
-- que creen que pasara? insertara alguna linea en la tabla?

delete products;
select * from products;

-- ahora creo el PRCC pero sin el COMMIT: 
create or replace procedure add_products
(p_prod_id number,p_prod_name varchar2:='Ukowun',p_prod_type  varchar2 default 'Ukowun')
is
begin

  insert into products values (p_prod_id,p_prod_name,p_prod_type);
  dbms_output.put_line(p_prod_id||' '||p_prod_name||'  inserted ' );

end;
-----------

begin
add_products(10,'PC'); -- este insertara correctamente gracias al INSERT del PRC
add_products(10,'Labtop'); -- como emite error por la pk hace rollback a la primera insercion
-- y ya cono continua con la tercera ni con el commit.
add_products(20,'Keyboard');
 commit;
end;

select * from products;

