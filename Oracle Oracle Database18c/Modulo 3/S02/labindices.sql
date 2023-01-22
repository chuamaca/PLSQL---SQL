drop sequence emp_test_emp_id_seq;
create sequence emp_test_emp_id_seq INCREMENT BY 1 START WITH 1;
DROP table emp_test PURGE;
CREATE table emp_test 
    (
        employee_id,
        job_id,
        manager_id,
        manager_id2,
        department_id,
        location_id,
        country_id,
        first_name,
        last_name,
        salary,
        commission_pct,
        department_name,
        job_title,
        city,
        state_province,
        country_name,
        region_name
    )
AS
SELECT e.employee_id, 
       e.job_id, 
       e.manager_id,
       e.manager_id manager_id2,
       e.department_id,
       d.location_id,
       l.country_id,
       e.first_name,
       e.last_name,
       e.salary,
       e.commission_pct,
       d.department_name,
       j.job_title,
       l.city,
       l.state_province,
       c.country_name,
       r.region_name
  FROM hr.employees e,
       hr.departments d,
       hr.jobs j,
       hr.locations l,
       hr.countries c,
       hr.regions r
 WHERE e.department_id = d.department_id
   AND d.location_id = l.location_id
   AND l.country_id = c.country_id
   AND c.region_id = r.region_id
   AND j.job_id = e.job_id
   AND 1=2;
begin
    for i in 1..9433 loop  -- 500,000 (4717); 1000,000 (9434)
        insert into emp_test
        SELECT emp_test_emp_id_seq.NEXTVAL, 
               e.job_id, 
               e.manager_id,
               e.manager_id manager_id2,
               e.department_id,
               d.location_id,
               l.country_id,
               e.first_name,
               e.last_name,
               e.salary,
               e.commission_pct,
               d.department_name,
               j.job_title,
               l.city,
               l.state_province,
               c.country_name,
               r.region_name
          FROM hr.employees e,
               hr.departments d,
               hr.jobs j,
               hr.locations l,
               hr.countries c,
               hr.regions r
         WHERE e.department_id = d.department_id
           AND d.location_id = l.location_id
           AND l.country_id = c.country_id
           AND c.region_id = r.region_id
           AND j.job_id = e.job_id ;
        if i = 1000 then
            begin
                commit;
                dbms_output.put_line(to_char(i) || ' registros insertados'); 
            end;
        end if;
    end loop;
    commit;
end;
/
set timing on