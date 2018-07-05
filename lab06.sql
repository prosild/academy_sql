-- 실습문제
-- PL/SQL

-- 7)
CREATE OR REPLACE PROCEDURE log_execution
(   v_log_user  IN  log_table.USERID%TYPE
  , v_log_date  OUT log_table.LOG_DATE%TYPE )
IS
BEGIN
    v_log_date := sysdate;
    INSERT INTO log_table VALUES(v_log_user, v_log_date);
END log_execution;
/

VAR v_log_date_bind VARCHAR2(30);

EXEC log_execution('myid', :v_log_date_bind);

PRINT v_log_date_bind;
/*
Procedure LOG_EXECUTION이(가) 컴파일되었습니다.

PL/SQL 프로시저가 성공적으로 완료되었습니다.

V_LOG_DATE_BIND
---------------
18/07/03
*/

-- 8)
-- 1. 프로시저 작성
CREATE OR REPLACE PROCEDURE sp_change_date_format
( v_date IN OUT VARCHAR2 )
IS
BEGIN
  v_date := TO_CHAR(TO_DATE(v_date), 'YYYY Mon dd');
END sp_change_date_format;
/

-- 2. 컴파일 / 디버깅
-- Procedure SP_CHANGE_DATE_FORMAT이(가) 컴파일되었습니다.

-- 3. VAR : BIND 변수 선언
-- IN OUT으로 사용 될 변수
VAR v_date_bind   VARCHAR2(30)

-- 4. EXEC : 실행
EXEC :v_date_bind := sysdate

EXEC sp_change_date_format(:v_date_bind)

-- 5. PRINT : BIND 변수 출력
PRINT v_date_bind
/*
V_DATE_BIND
-----------
18/07/03
*/

-- 9)
CREATE OR REPLACE PROCEDURE insert_dept
(   v_dname IN dept.DNAME%TYPE
  , v_loc   IN dept.LOC%TYPE )
IS
    v_max_deptno  NUMBER;  
BEGIN
    SELECT MAX(d.deptno)
      INTO v_max_deptno
      FROM dept d
    ;
    
    INSERT INTO dept (deptno, dname, loc)
    VALUES (v_max_deptno + 10, v_dname, v_loc)
    ;
    
    COMMIT;
    
END insert_dept;
/
-- Procedure INSERT_DEPT이(가) 컴파일되었습니다.

-- 10)
-- 위치 전달
EXEC insert_dept('EX', 'SEOUL');

SELECT d.*
  FROM dept d
;
/*---------------------------
DEPTNO, DNAME,      LOC
-----------------------------
10	    ACCOUNTING	NEW YORK
20	    RESEARCH	  DALLAS
30	    SALES	      CHICAGO
40	    OPERATIONS	BOSTON
50	    EX	        SEOUL
----------------------------*/

-- 변수명 전달
EXEC insert_dept(v_loc => 'DAEJEON', v_dname => 'HUMAN RESOUCE');

SELECT d.*
  FROM dept d
;
/*-----------------------------
DEPTNO, DNAME,        LOC
-------------------------------
10	    ACCOUNTING	  NEW YORK
20	    RESEARCH	    DALLAS
30	    SALES	        CHICAGO
40	    OPERATIONS	  BOSTON
50	    EX	          SEOUL
60	    HUMAN RESOUCE	DAEJEON
------------------------------*/

-- 11)
CREATE TABLE new_emp
AS
SELECT e.*
  FROM emp e
 WHERE 1 = 1
;

CREATE OR REPLACE PROCEDURE sp_change_commission
(   v_empno   IN  new_emp.EMPNO%TYPE )
IS
    v_job   new_emp.JOB%TYPE;
    v_comm  new_emp.COMM%TYPE;
BEGIN
    SELECT e.JOB
      INTO v_job
      FROM new_emp e
     WHERE e.EMPNO = v_empno
    ;
    
    IF      v_job = 'SALESMAN'  THEN v_comm := 1000;
    ELSIF   v_job = 'MANAGER'   THEN v_comm := 1500;
    ELSE v_comm := 500;
    END IF;
    
    UPDATE new_emp e
       SET e.COMM = v_comm
     WHERE e.EMPNO = v_empno
    ;
    COMMIT;
    
END sp_change_commission;
/

SELECT e.*
  FROM new_emp e
;
/*--------------------------------------------------------
EMPNO,  ENAME,  JOB,      MGR,  HIREDATE, SAL, COMM,  DEPTNO
7369	  SMITH	  CLERK	    7902	80/12/17	800		      20
7499	  ALLEN	  SALESMAN	7698	81/02/20	1600	300	  30
7521	  WARD	  SALESMAN	7698	81/02/22	1250	500	  30
7566	  JONES	  MANAGER	  7839	81/04/02	2975		    20
7654	  MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7698	  BLAKE	  MANAGER	  7839	81/05/01	2850		    30
7782	  CLARK	  MANAGER	  7839	81/06/09	2450		    10
7839	  KING	  PRESIDENT		    81/11/17	5000		    10
7844	  TURNER	SALESMAN	7698	81/09/08	1500	0	    30
7900	  JAMES	  CLERK	    7698	81/12/03	950		      30
7902	  FORD	  ANALYST	  7566	81/12/03	3000		    20
7934	  MILLER	CLERK	    7782	82/01/23	1300		    10
--------------------------------------------------------*/

EXEC sp_change_commission(7369);
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.

SELECT e.*
  FROM new_emp e
 WHERE e.EMPNO = 7369
;
/*-------------------------------------------------------
EMPNO,  ENAME,  JOB,  MGR,  HIREDATE, SAL,  COMM, DEPTNO
---------------------------------------------------------
7369	  SMITH	  CLERK	7902	80/12/17	800	  500	  20
--------------------------------------------------------*/

-- 12)
SET SERVEROUTPUT ON;

DECLARE
  v_count NUMBER := 1;
BEGIN
  LOOP
    DBMS_OUTPUT.PUT_LINE(v_count);
    v_count := v_count + 1;
  EXIT WHEN v_count > 10;
  END LOOP;
END;
/
/*
1
2
3
4
5
6
7
8
9
10
*/

-- 13)
DECLARE
  v_count NUMBER := 0;
BEGIN
  FOR v_count IN REVERSE 1 .. 10 LOOP
    IF MOD(v_count, 2) = 0
       THEN DBMS_OUTPUT.PUT_LINE(v_count);
    END IF;
  END LOOP;
END;
/
/*
PL/SQL 프로시저가 성공적으로 완료되었습니다.

10
8
6
4
2
*/

-- 14)
DECLARE
  v_count NUMBER := 1;
BEGIN
  WHILE v_count <= 10 LOOP
    DBMS_OUTPUT.PUT_LINE(v_count);
    v_count := v_count + 1;
  END LOOP;
END;
/
/*
PL/SQL 프로시저가 성공적으로 완료되었습니다.

1
2
3
4
5
6
7
8
9
10
*/

-- 15)
CREATE OR REPLACE FUNCTION emp_sal_avg
(   v_job  IN emp.JOB%TYPE  )
RETURN emp.SAL%TYPE
IS
    v_sal   emp.SAL%TYPE;
BEGIN
  SELECT ROUND(AVG(e.SAL))
    INTO v_sal
    FROM emp e
   WHERE e.JOB = v_job
   GROUP BY e.JOB
  ;
  RETURN v_sal;
END;
/

SELECT e.*
  FROM emp e
;
/*
------------------------------------------------------------
EMPNO,  ENAME, JOB,       MGR, HIREDATE,  SAL,  COMM, DEPTNO
7369	  SMITH	  CLERK	    7902	80/12/17	800		      20
7499	  ALLEN	  SALESMAN	7698	81/02/20	1600	300	  30
7521	  WARD	  SALESMAN	7698	81/02/22	1250	500	  30
7566	  JONES	  MANAGER	  7839	81/04/02	2975		    20
7654	  MARTIN  SALESMAN	7698	81/09/28	1250	1400	30
7698	  BLAKE	  MANAGER	  7839	81/05/01	2850		    30
7782	  CLARK	  MANAGER	  7839	81/06/09	2450		    10
7839	  KING	  PRESIDENT		    81/11/17	5000		    10
7844	  TURNER	SALESMAN	7698	81/09/08	1500	0	    30
7900	  JAMES	  CLERK	    7698	81/12/03	950		      30
7902	  FORD	  ANALYST	  7566	81/12/03	3000		    20
7934	  MILLER	CLERK	    7782	82/01/23	1300		    10
----------------------------------------------------------*/
SELECT e.*
  FROM emp e
 WHERE e.SAL > emp_sal_avg('SALESMAN')
;
/*----------------------------------------------------------
EMPNO,  ENAME,  JOB,      MGR,  HIREDATE, SAL,  COMM, DEPTNO
7499	  ALLEN	  SALESMAN	7698	81/02/20	1600	300	  30
7566	  JONES	  MANAGER	  7839	81/04/02	2975		    20
7698	  BLAKE	  MANAGER	  7839	81/05/01	2850		    30
7782	  CLARK	  MANAGER	  7839	81/06/09	2450		    10
7839	  KING	  PRESIDENT		    81/11/17	5000		    10
7844	  TURNER	SALESMAN	7698	81/09/08	1500	0	    30
7902	  FORD	  ANALYST	  7566	81/12/03	3000		    20
-----------------------------------------------------------*/

-- 16)
SELECT emp_sal_avg('SALESMAN') as "평균 급여"
  FROM dual
;
/*-------
평균 급여
---------
1400
--------*/

-- 17)
SELECT e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.SAL > emp_sal_avg('SALESMAN')
;
/*--------------
ENAME,  SAL
----------------
ALLEN	  1600
JONES	  2975
BLAKE	  2850
CLARK	  2450
KING	  5000
TURNER	1500
FORD	  3000
--------------*/

-- 18)
CREATE OR REPLACE PROCEDURE dept_insert_update
(   v_deptno  IN  dept.DEPTNO%TYPE  
  , v_dname   IN  dept.DNAME%TYPE
  , v_loc     IN  dept.LOC%TYPE
  , v_msg     OUT VARCHAR2  )
IS
  v_exist VARCHAR2(30);
BEGIN
  SELECT d.DEPTNO
    INTO v_exist
    FROM dept d
   WHERE d.DEPTNO = v_deptno
  ;
  
  UPDATE dept d
     SET d.DEPTNO = v_deptno
       , d.DNAME = v_dname
       , d.LOC = v_loc
   WHERE d.DEPTNO = v_deptno
  ;
  v_msg := '부서 레코드 변경';
  
  EXCEPTION
        WHEN NO_DATA_FOUND
        THEN INSERT INTO dept (deptno, dname, loc)
              VALUES (v_deptno, v_dname, v_loc)
             ;
             v_msg := '부서 레코드 추가';
  COMMIT;
  
END dept_insert_update;
/
-- Procedure DEPT_INSERT_UPDATE이(가) 컴파일되었습니다.
VAR v_msg_bind VARCHAR2(40);

EXEC dept_insert_update(50, 'DESIGN', 'SEOUL', :v_msg_bind);
EXEC dept_insert_update(70, 'RESEARCH', 'PUSAN', :v_msg_bind);
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.
PRINT v_msg_bind;
/*
V_MSG_BIND
----------
부서 레코드 변경
-----------------

V_MSG_BIND
----------
부서 레코드 추가
*/
SELECT d.*
  FROM dept d
;
/*--------변경 전----------
10	ACCOUNTING	  NEW YORK
20	RESEARCH	    DALLAS
30	SALES	        CHICAGO
40	OPERATIONS	  BOSTON
50	EX	          SEOUL
60	HUMAN RESOUCE	DAEJEON
--------------------------*/

/*--------변경 후----------
70	Research	    PUSAN
10	ACCOUNTING	  NEW YORK
20	RESEARCH	    DALLAS
30	SALES	        CHICAGO
40	OPERATIONS	  BOSTON
50	DESIGN	      SEOUL
60	HUMAN RESOUCE	DAEJEON
--------------------------*/

-- VIEW
-- 9)
-- 제약조건이 VIP, GOLD, SILVER로 걸려있어서 General 대신 GOLD로 진행
UPDATE customer c
   SET c.GRADE  = 'GOLD'
 WHERE c.USERID = 'C002'
;

CREATE OR REPLACE VIEW v_cust_gold_regdt
AS
SELECT c.USERID
     , c.REGDATE
  FROM customer c
 WHERE c.GRADE = 'GOLD'
  WITH READ ONLY
;
-- View V_CUST_GOLD_REGDT이(가) 생성되었습니다.

-- 10)
SELECT v.*
  FROM v_cust_gold_regdt v
;
/*
C002	18/07/05
*/

-- 11)
DESC USER_VIEWS;
/*--------------------------------------
이름               널        유형             
---------------- -------- -------------- 
VIEW_NAME        NOT NULL VARCHAR2(30)   
TEXT_LENGTH               NUMBER         
TEXT                      LONG           
TYPE_TEXT_LENGTH          NUMBER         
TYPE_TEXT                 VARCHAR2(4000) 
OID_TEXT_LENGTH           NUMBER         
OID_TEXT                  VARCHAR2(4000) 
VIEW_TYPE_OWNER           VARCHAR2(30)   
VIEW_TYPE                 VARCHAR2(30)   
SUPERVIEW_NAME            VARCHAR2(30)   
EDITIONING_VIEW           VARCHAR2(1)    
READ_ONLY                 VARCHAR2(1)
------------------------------------------*/

-- 12)
SELECT u.VIEW_NAME
     , u.TEXT
  FROM user_views u
;
/*----------------------------------------------------
VIEW_NAME,              TEXT
------------------------------------------------------
V_CUST_GOLD_REGDT	      "SELECT c.USERID
                              , c.REGDATE
                           FROM customer c
                          WHERE c.GRADE = 'GOLD'
                           WITH READ ONLY"
-----------------------------------------------------*/

-- 13)
DROP VIEW v_cust_gold_regdt;
-- View V_CUST_GOLD_REGDT이(가) 삭제되었습니다.

-- 14)
SELECT u.VIEW_NAME
     , u.TEXT
  FROM user_views u
;
/*
인출된 모든 행 : 0
*/
