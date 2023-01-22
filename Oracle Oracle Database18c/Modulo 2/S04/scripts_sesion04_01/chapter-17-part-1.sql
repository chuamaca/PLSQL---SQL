/* antes de ejecutar los scripts del trigger lab realizar el query a user_triggers
y eliminar todos los que están creados hasta el momento.
*/


delete from departments;


-- let us do statment level trigger
-- interpretacion :
/* El trigger impide realizar un dml en departments si la operacion se realiza
entre las 8 y 1400 hrs. */

create or replace trigger dept_check_time
before
insert or update or delete -- ccualquiera de ellos
on departments
begin
  if  to_number (to_char(sysdate,'hh24') )  between 8 and 14 then
  raise_application_error(-20010, 'NO SE PERMITEN DML');
  end if;
end;

-- probar el trigger 
delete from departments;

delete from departments
where department_id=-4;


-- otro ejemplo: crear nueva tabla y nuevo trigger
-- observar el NOT BETWEEN

drop table t purge;
create table t as select * from departments;

create or replace trigger dept_check_time_t
before
insert or update or delete -- ccualquiera de ellos
on t
begin
  if  to_number (to_char(sysdate,'hh24') )  not between 8 and 14 then
  raise_application_error(-20010, 'DML operations not allowed now ');
  end if;
end;


--try to test the trigger
delete from T;
-- =====================


delete from departments
where department_id=-4;

select * from user_objects
where object_name='DEPT_CHECK_TIME';

select * from user_triggers
where trigger_name='DEPT_CHECK_TIME';

-------------------------------


create or replace trigger dept_check_time
before
insert or update or delete
on DEPARTMENTS
begin

  if  to_number (to_char(sysdate,'hh24') ) not between 8 and 16 then
     if inserting then
     raise_application_error(-20010, 'Insert operations not allowed now ');
     elsif deleting then
     raise_application_error(-20011, 'Delete operations not allowed now ');
     elsif updating then
     raise_application_error(-20012, 'Update operations not allowed now ');
     end if;
  end if;

end;

delete from departments;

update departments
set department_name='x'
where department_id = -5;

