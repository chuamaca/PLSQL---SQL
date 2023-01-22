SELECT e.employee_id, e.last_name, j.job_id, e.hire_date as STARTDATE 
FROM employees e INNER JOIN job_history j
ON e.job_id=j.job_id;


SELECT e.employee_id as "Emp #", e.last_name as Employee, j.job_id as Job, e.hire_date as "Hire Date" 
FROM employees e INNER JOIN job_history j
ON e.job_id=j.job_id;

SELECT e.last_name||', '||j.job_id as "Employee and Title"
FROM employees e INNER JOIN job_history j
ON e.job_id=j.job_id;


SELECT e.last_name, e.salary
FROM employees e where (e.salary <5000 or e.salary > 12000);

SELECT e.last_name, e.salary ,e.department_id  FROM employees e
where (e.salary >5000 or e.salary < 12000) 
and (e.department_id=20 or e.department_id = 50) order by e.last_name desc;


SELECT e.last_name  FROM employees e
where e.manager_id is null;

SELECT e.last_name, e.salary, e.commission_pct FROM employees e
where e.commission_pct is not null
Order by e.salary, e.commission_pct desc;

/*
a.	El departamento de HR desea un reporte que muestre el Employee ID, Last Name, Salary, 
Salary incrementado en 15% y la diferencia de los salarios.
*/
SELECT e.employee_id, e.last_name, e.salary + e.salary*0.15 as Incremento,  (e.salary + e.salary*0.15) - e.salary as Diferencia  FROM employees e;

/*
b.	Generar un reporte que muestre el Last Name (con la primera letra en mayúscula y las demás en minúsculas)
y la longitud del Last Name de los empleados cuyo apellido
inicie con las letras “J,” “A,” o “M”. Ordenas los resultados por Last Name.
*/

SELECT e.last_name FROM employees e where last_name Like 'J%' or last_name Like 'A%'or  last_name Like 'M%';


/*
c.	Generar un reporte que muestre el Last Name y el tiempo que un empleado tiene contratado en meses como números enteros.
Nombre la columna MONTHS_WORKED y ordene los resultados por el número de meses contratados.
*/

























