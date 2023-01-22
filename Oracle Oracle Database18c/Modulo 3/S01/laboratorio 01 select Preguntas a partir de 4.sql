/*
a.	Listar el Salary mayor, menor, suma y promedio de todos los empleados. Nombre las columnas Maximum, Minimum, Sum, y Average, respectivamente. Redondee los resultados al entero más cercano.
*/

SELECT  max(salary) MAX, MIN(SALARY) MIN, SUM(SALARY) SUM, AVG(salary) SUM FROM employees;


/*
b.	Listar el Salary mayor, menor, suma y promedio de los empleados agrupados por Job Id. 
Nombre las columnas Maximum, Minimum, Sum, y Average, respectivamente. Redondee los resultados al entero más cercano.
*/

SELECT job_id, max(salary) MAX, MIN(SALARY) MIN, SUM(SALARY) SUM, AVG(salary) SUM 
FROM employees
GROUP BY JOB_ID;

/*
c.	Listar la cantidad de empleados por Departamento. Ordene por cantidad de empleados de forma descendente.
*/

SELECT COUNT(department_id) CANTIDAD, department_id FROM employees
GROUP BY  department_id
ORDER BY CANTIDAD DESC;

/*
d.	Cree un reporte que liste el Manager Id y el Salary del empleado menos pagado para ese Manager.
Excluya a todos cuyo Manager es desconcido. Excluya todos los grupos cuyo salario mínimo sea $6000 o menor. 
Ordene los resultados descendentemente por Salary.
*/

SELECT manager_id,  MIN(salary) FROM employees
    WHERE manager_id is NOT null AND SALARY>=6000
    GROUP BY manager_id,salary
      ORDER BY salary DESC
      ;