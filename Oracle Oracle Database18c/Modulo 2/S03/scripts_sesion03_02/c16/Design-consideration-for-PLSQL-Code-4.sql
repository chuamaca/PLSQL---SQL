--1 Cache and parallel are only in oracle enterprise editions 
--also the DBA make changes in these values
--parameter shared_pool_size
--parameter result_cache_max_size
--parameter result_cache_mode

create or replace function get_sum_sal_dept
( dept_id number )  
return number result_cache
is
v_sal number;
begin
  select sum(salary)
  into v_sal
  from
  employees
  where department_id =dept_id;
  return v_sal;
  
end;

select get_sum_sal_dept(10) from dual;
select get_sum_sal_dept(20) from dual;
select get_sum_sal_dept(30) from dual;

--now when you do :
select get_sum_sal_dept(10) from dual;
--it should be faster because the resulte is stored in cashe,


--relies_on (employees) is optional 
--This option has become obsolete since version 11G release 2. 
--The database figures out where the function relies on. 
--You can still include the relies_on clause, 
--but it will be for documentation purposes only.
create or replace function get_sum_sal_dept
( dept_id number )  
return number result_cache relies_on (employees)
is
v_sal number;
begin
  select sum(salary)
  into v_sal
  from
  employees
  where department_id =dept_id;
  return v_sal;
  
end;
------------
-- En caso haya cambios en la tabla employees oracle se encarga de recalcular en auto
-- Eso es lo que hacia el relies_on, pero ahora 11.2 ya lo hace en auto








