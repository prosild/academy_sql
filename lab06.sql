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
CREATE OR REPLACE PROCEDURE sp_get_tribute_fee
(   v_empno         IN  emp.EMPNO%TYPE
  , v_tribute_fee   OUT emp.SAL%TYPE    )
IS
    -- 1. 사번인 직원의 직무를 저장할 지역변수
    v_job   emp.JOB%TYPE;
    -- 2. 사번인 직원의 급여를 저장할 지역 변수
    v_sal   emp.SAL%TYPE;
    
BEGIN
    -- 2. 입력 된 사번 직원의 직무를 조회하여 v_job, v_sal에 저장
    SELECT e.JOB, e.SAL
      INTO v_job, v_sal
      FROM emp e
     WHERE e.EMPNO = v_empno
    ;
    
    /*
    CLERK       : 5%
    SALESMAN    : 4%
    MANAGER     : 3.7%
    ANALYST     : 3%
    PRESIDENT   : 1.5%
    */
    
    -- 2. 일정 비율로 v_tribute_fee를 계산
    IF      v_job = 'CLERK'     THEN v_tribute_fee := v_sal * 0.05;
    ELSIF   v_job = 'SALESMAN'  THEN v_tribute_fee := v_sal * 0.04;
    ELSIF   v_job = 'MANAGER'   THEN v_tribute_fee := v_sal * 0.037;
    ELSIF   v_job = 'ANALYST'   THEN v_tribute_fee := v_sal * 0.03;
    ELSIF   v_job = 'PRESIDENT' THEN v_tribute_fee := v_sal * 0.015;
    END IF;
    
END sp_get_tribute_fee;
/