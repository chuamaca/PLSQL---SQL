-- BULK BINDING

-- sin bulkbinding:

select * from employees
where employee_id in (100,101,102);

create or replace procedure update_sal_withoutbulk
( p_amount number )
is
type emp_table_type is table of number index by binary_integer;
emp_table emp_table_type;
begin
emp_table(1):=100;
emp_table(2):=101;
emp_table(3):=102;
  for i in emp_table.first..emp_table.last
  loop
  update employees
  set salary=salary+p_amount
  where employee_id =emp_table(i);
  end loop;
  commit;
end;

execute update_sal_withoutbulk(10);

select * from employees
where employee_id in (100,101,102);
-------------------------------------------------------------
-- ahora con BULK BINDING
--here with bulk using  forall
--no need for the loop
create or replace procedure update_sal_withbulk
( p_amount number )
is
type emp_table_type is table of number index by binary_integer;
emp_table emp_table_type;
begin
emp_table(1):=100;
emp_table(2):=101;
emp_table(3):=102;
  forall i in emp_table.first..emp_table.last
  update employees
  set salary=salary+p_amount
  where employee_id =emp_table(i);
  commit;
end;

execute update_sal_withbulk(10);

select * from employees
where employee_id in (100,101,102);
-------------------------------------------------------------------
