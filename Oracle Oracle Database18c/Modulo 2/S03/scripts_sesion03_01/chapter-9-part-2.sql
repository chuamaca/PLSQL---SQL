desc departments;

insert into departments(DEPARTMENT_ID ,DEPARTMENT_NAME)
values (1,null );

--SQL Error: ORA-01400: cannot insert NULL into ("HR"."DEPARTMENTS"."DEPARTMENT_NAME")


-- el mismo resultado si lo pongo en un bloque
begin
insert into departments(DEPARTMENT_ID ,DEPARTMENT_NAME)
values (1,null );

end;
----------------------------------------------
declare
e_insert exception; -- defines una variable de tipo exception
pragma exception_init(e_insert,-01400); -- relacionas el codigo ORA con la variable exception
begin
    insert into departments(DEPARTMENT_ID ,DEPARTMENT_NAME)
    values (1,null );
    
    exception 
    when e_insert then
    dbms_output.put_line('insert failed');
    dbms_output.put_line(sqlcode);
    dbms_output.put_line(sqlerrm);
    
    when others then
    null;
end;
------------------------------------------------

--now the way for creating this code is wrong
-- the update will not executed when there is exception in the first insert
-- uno de los errores mas conocidos al programar plsql. 
-- el update no se ejecutará

declare
e_insert exception;
pragma exception_init(e_insert,-01400);
begin
      insert into departments(DEPARTMENT_ID ,DEPARTMENT_NAME)
      values (1,null ); -- salta a la exception
      
        update employees
        set employee_id='ss'
        where employee_id=100;
        
      exception 
      when e_insert then
      dbms_output.put_line('insert failed');
      dbms_output.put_line(sqlcode);
      dbms_output.put_line(sqlerrm);

end;
------------------------------------------------------------

--this is the correct code
declare
e_insert exception;
pragma exception_init(e_insert,-01400);
begin     
          begin
            insert into departments(DEPARTMENT_ID ,DEPARTMENT_NAME)
            values (1,null );
          exception 
          when e_insert then
            dbms_output.put_line('insert failed');
            dbms_output.put_line(sqlcode);
            dbms_output.put_line(sqlerrm);
          end;
          
          begin
             update employees
             set employee_id='ss'
             where employee_id=100;
          exception
          when others then
            dbms_output.put_line('update failed');
            dbms_output.put_line(sqlcode);
            dbms_output.put_line(sqlerrm);
          end;
          

end;

