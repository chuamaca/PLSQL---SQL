
-- dos nuevas maneras de crear una funcion
WITH
  FUNCTION fun_with_plsql (p_sal NUMBER) RETURN NUMBER IS
        BEGIN
        RETURN (p_sal * 12);
        END;
SELECT first_name, last_name, fun_with_plsql (salary) "annual_sal"
FROM employees;

select * FROM DBA_OBJECTS WHERE OBJECT_NAME ='FUN_WITH_PLSQL'



-- performance

/*Create a function with PRAGMA UDF*/
CREATE OR REPLACE FUNCTION fun_with_plsql (p_sal NUMBER)
RETURN NUMBER is
PRAGMA UDF;
BEGIN
RETURN (p_sal *12);
END;
/


/*
Since the objective of the feature is performance, let us go ahead with a case study to
compare the performance when using a standalone function, a PRAGMA UDF function,
and a WITH clause declared function.
*/

/*Create a table for performance test study*/
CREATE TABLE t_fun_plsql
(id number,
str varchar2(30))
/
/*Generate and load random data in the table*/
INSERT /*+APPEND*/ INTO t_fun_plsql
SELECT ROWNUM, DBMS_RANDOM.STRING('X', 20)
FROM dual
CONNECT BY LEVEL <= 1000000
/
COMMIT
/


-- TEST: 
-- ================================
Case 1: Create a PL/SQL standalone function as it used to be until Oracle
Database 12c. The function counts the numbers in the str column of the table.
/*Create a standalone function without Oracle 12c enhancements*/
CREATE OR REPLACE FUNCTION f_count_num (p_str VARCHAR2)
RETURN PLS_INTEGER IS
BEGIN
RETURN (REGEXP_COUNT(p_str,'\d'));
END;
/

/*
The PL/SQL block measures the elapsed and CPU time when working with a
pre-Oracle 12c standalone function. These numbers will serve as the baseline
for our case study.
*/

/*Set server output on to display messages*/
SET SERVEROUTPUT ON
/*Anonymous block to measure performance of a standalone
function*/
DECLARE
l_el_time PLS_INTEGER;
l_cpu_time PLS_INTEGER;
CURSOR C1 IS
SELECT f_count_num (str) FROM t_fun_plsql;
TYPE t_tab_rec IS TABLE OF PLS_INTEGER;
l_tab t_tab_rec;
BEGIN
l_el_time := DBMS_UTILITY.GET_TIME ();
l_cpu_time := DBMS_UTILITY.GET_CPU_TIME ();
OPEN c1;
FETCH c1 BULK COLLECT INTO l_tab;
CLOSE c1;
DBMS_OUTPUT.PUT_LINE ('Case 1: Performance of a standalone function');
DBMS_OUTPUT.PUT_LINE ('Total elapsed time:'||to_char(DBMS_UTILITY.GET_TIME () - l_el_time));
DBMS_OUTPUT.PUT_LINE ('Total CPU time:'||to_char(DBMS_UTILITY.GET_CPU_TIME () - l_cpu_time));
END;
/

-- resultados:
/*
Case 1: Performance of a standalone function
Total elapsed time:1006
Total CPU time:857

Procedimiento PL/SQL terminado correctamente.
*/


-- ================================
Case 2: Create a PL/SQL function using PRAGMA UDF to count the numbers in
the str column

/*Create the function with PRAGMA UDF*/
CREATE OR REPLACE FUNCTION f_count_num_pragma (p_str VARCHAR2)
RETURN PLS_INTEGER IS
PRAGMA UDF;
BEGIN
RETURN (REGEXP_COUNT(p_str,'\d'));
END;
/



Let us now check the performance of the PRAGMA UDF function using the
following PL/SQL block.
/*Set server output on to display messages*/
SET SERVEROUTPUT ON
/*Anonymous block to measure performance of a PRAGMA UDF
function*/
DECLARE
l_el_time PLS_INTEGER;
l_cpu_time PLS_INTEGER;
CURSOR C1 IS
SELECT f_count_num_pragma (str) FROM t_fun_plsql;
TYPE t_tab_rec IS TABLE OF PLS_INTEGER;
l_tab t_tab_rec;
BEGIN
l_el_time := DBMS_UTILITY.GET_TIME ();
l_cpu_time := DBMS_UTILITY.GET_CPU_TIME ();
OPEN c1;
FETCH c1 BULK COLLECT INTO l_tab;
CLOSE c1;
DBMS_OUTPUT.PUT_LINE ('Case 2: Performance of a PRAGMA UDF function');
DBMS_OUTPUT.PUT_LINE ('Total elapsed time:'||to_char(DBMS_UTILITY.GET_TIME () - l_el_time));
DBMS_OUTPUT.PUT_LINE ('Total CPU time:'||to_char(DBMS_UTILITY.GET_CPU_TIME () - l_cpu_time));
END;
/

-- resultados:
Case 2: Performance of a PRAGMA UDF function
Total elapsed time:640
Total CPU time:635

Procedimiento PL/SQL terminado correctamente.


-- ============================
/*Case 3: The following PL/SQL block dynamically executes the function in
the WITH clause subquery. Note that, unlike other SELECT statements, a
SELECT query with a WITH clause declaration cannot be executed statically in
the body of a PL/SQL block
*/

/*Set server output on to display messages*/
SET SERVEROUTPUT ON
/*Anonymous block to measure performance of inline function*/
DECLARE
	l_el_time PLS_INTEGER;
	l_cpu_time PLS_INTEGER;
	l_sql VARCHAR2(32767);
	c1 sys_refcursor;
	TYPE t_tab_rec IS TABLE OF PLS_INTEGER;
	l_tab t_tab_rec;
BEGIN
	l_el_time := DBMS_UTILITY.get_time;
	l_cpu_time := DBMS_UTILITY.get_cpu_time;
	l_sql := 'WITH FUNCTION f_count_num_with (p_str VARCHAR2)
				RETURN NUMBER IS
				BEGIN
					RETURN (REGEXP_COUNT(p_str,'''||'\'||'d'||'''));
				END;
				SELECT f_count_num_with(str) FROM t_fun_plsql';
OPEN c1 FOR l_sql;
FETCH c1 bulk collect INTO l_tab;
CLOSE c1;
DBMS_OUTPUT.PUT_LINE ('Case 3: Performance of an inline function');
DBMS_OUTPUT.PUT_LINE ('Total elapsed time:'||to_char(DBMS_UTILITY.GET_TIME () - l_el_time));
DBMS_OUTPUT.PUT_LINE ('Total CPU time:'||to_char(DBMS_UTILITY.GET_CPU_TIME () - l_cpu_time));
END;
/

-- resultados
Case 3: Performance of an inline function
Total elapsed time:476
Total CPU time:473

Procedimiento PL/SQL terminado correctamente.






'
-- ===================================================
--            Understanding the NOT NULL constraint 
-- ======================================================

/*Enable the SERVEROUTPUT to display block results*/
SET SERVEROUTPUT ON
/*Start the PL/SQL block*/
DECLARE
    l_nn_num NUMBER NOT NULL := 0;
    l_num NUMBER := 0;
    clock_in NUMBER;
    clock_out NUMBER;
BEGIN
/*Capture the start time*/
    clock_in := DBMS_UTILITY.GET_TIME();
/*Start the loop*/
FOR I IN 1..1000000 LOOP
    l_nn_num := l_nn_num + i;
END LOOP;
    clock_out := DBMS_UTILITY.GET_TIME();
/*Compute the time difference and display*/
    DBMS_OUTPUT.PUT_LINE('Time for NOT NULL:'||TO_CHAR(clock_out-clock_in));
/*Capture the start time*/
    clock_in := DBMS_UTILITY.GET_TIME();
/*Start the loop*/
FOR I IN 1..1000000 LOOP
    l_num := l_num + i;
END LOOP;
    clock_out := DBMS_UTILITY.GET_TIME();
/*Compute the time difference and display*/
    DBMS_OUTPUT.PUT_LINE('Time for NULL:'||TO_CHAR(clock_out-clock_in));
END;
/



En el ejemplo visto, la variable que acepta valores NULL supera
a la variable NOT NULL una vez y media. El motivo de esta ganancia de rendimiento 
es la reducción del número de comprobaciones de nulabilidad que se han realizado a l_nn_num
 



-------- ====================================================
--- 	Selection of an appropriate numeric data type
--- =======================================================
/*Enable the SERVEROUTPUT to display block results*/
SET SERVEROUTPUT ON
/*Start the PL/SQL block*/
DECLARE
    l_pls_int PLS_INTEGER := 1;
    l_num NUMBER:= 1;
    l_factor PLS_INTEGER := 2;
    clock_in NUMBER;
    clock_out NUMBER;
BEGIN
/*Capture the start time*/
    clock_in := DBMS_UTILITY.GET_TIME();
/*Begin the loop to perform a mathematical calculation*/
FOR I IN 1..10000000 LOOP
    /*The mathematical operation increments a variable by one*/
    l_num := l_num + l_factor;
END LOOP;
clock_out := DBMS_UTILITY.GET_TIME();
/*Display the execution time consumed*/
    DBMS_OUTPUT.PUT_LINE('Time by NUMBER:'||TO_CHAR(clock_out-clock_in));
/*Capture the start time*/
    clock_in := DBMS_UTILITY.GET_TIME();
/*Begin the loop to perform a mathematical calculation*/
FOR J IN 1..10000000
LOOP
/*The mathematical operation increments a variable by one*/
    l_pls_int := l_pls_int + l_factor;
END LOOP;
    clock_out := DBMS_UTILITY.GET_TIME();
/*Display the time consumed*/
    DBMS_OUTPUT.PUT_LINE('Time by PLS_INTEGER:'||TO_CHAR(clock_out-clock_in));
END;
/


-- resultados:
Time by NUMBER:31
Time by PLS_INTEGER:13
