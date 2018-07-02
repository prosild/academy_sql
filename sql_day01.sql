-- SQL Day01

-- 1. SCOTT 계정 활성화
@C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\scott.sql;

-- 2. 접속 유저 확인 명령
SHOW USER

-- 3. HR 계정 활성화 : sys 계정으로 접속하여 다른 사용자 확장 후 HR 계정의 계정잠김, 비밀번호 만료 상태 해제
------------------------------------------------------------------------------------------------------------

-- SCOTT 계정의 데이터 구조
-- (1) EMP 테이블 내용 조회
SELECT *
  FROM emp
;

/*--------------------------------------------------------------------
7369	SMITH	CLERK	    7902	80/12/17	800		        20
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	    30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	    30
7566	JONES	MANAGER	    7839	81/04/02	2975		    20
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7698	BLAKE	MANAGER	    7839	81/05/01	2850		    30
7782	CLARK	MANAGER	    7839	81/06/09	2450		    10
7839	KING	PRESIDENT		    81/11/17	5000		    10
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	    30
7900	JAMES	CLERK	    7698	81/12/03	950		        30
7902	FORD	ANALYST	    7566	81/12/03	3000		    20
7934	MILLER	CLERK	    7782	82/01/23	1300		    10
----------------------------------------------------------------------*/

-- (2) DEPT 테이블 내용 조회
SELECT *
  FROM dept
;

/* ----------------------
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
-------------------------*/

-- (3) SALGRADE 테이블 내용 조회
SELECT *
  FROM salgrade
;

/* ------------------
1	700	    1200
2	1201	1400
3	1401	2000
4	2001	3000
5	3001	9999
--------------------*/

-- 01. DQL
-- (1) SELECT 구문
--   1) emp 테이블에서 사번, 이름, 직무를 조회
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
  FROM emp e -- 소문자 e는 alias(별칭)
;

--   2) emp 테이블에서 직무만 조회
SELECT e.JOB
  FROM emp e
;

/*--------
CLERK
SALESMAN
SALESMAN
MANAGER
SALESMAN
MANAGER
MANAGER
PRESIDENT
SALESMAN
CLERK
ANALYST
CLERK
--------*/

-- (2) DISTINCT문 : SELECT문 사용시 중복을 배제하여 조회
--   3) emp 테이블에서 job 컬럼의 중복을 배제하여 조회
SELECT DISTINCT e.JOB
  FROM emp e
;

/*--------
CLERK
SALESMAN
PRESIDENT
MANAGER
ANALYST
---------*/

-- * SQL SELECT 구문의 작동 원리 : 테이블의 한 행을 기본 단위로 실행함. 테이블 행의 개수만큼 반복 실행.
SELECT 'Hello, SQL~'
  FROM emp e
;

/*----------
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
Hello, SQL~
-----------*/

--   4) emp 테이블에서 job, deptno에 대해 중복을 제거하여 조회
SELECT DISTINCT
       e.JOB
     , e.DEPTNO 
  FROM emp e
;

/*-------------
MANAGER	    20
PRESIDENT	10
CLERK	    10
SALESMAN	30
ANALYST	    20
MANAGER 	30
MANAGER 	10
CLERK	    30
CLERK	    20
--------------*/

-- (3) ORDER BY 절 : 정렬
--   5) emp 테이블에서 job을 중복배제하여 조회하고 결과는 오름차순으로 정렬
SELECT DISTINCT
       e.JOB
  FROM emp e
 ORDER BY e.JOB ASC
;

/*--------
ANALYST
CLERK
MANAGER
PRESIDENT
SALESMAN
---------*/

--   6) emp 테이블에서 job을 중복배제하여 조회하고 내림차순으로 정렬
SELECT DISTINCT
       e.JOB
  FROM emp e
 ORDER BY e.JOB DESC
;

/*--------
SALESMAN
PRESIDENT
MANAGER
CLERK
ANALYST
--------*/

--   7) emp 테이블에서 comm을 가장 많이 받는 순서대로 출력(사번, 이름, 직무, 입사일, 커미션 순으로 조회)
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.HIREDATE
     , e.COMM
  FROM emp e
 ORDER BY e.COMM DESC
;

--   8) emp 테이블에서 comm이 적은 순서대로, 직무별 오름차순, 이름별 오름차순으로 정렬(사번, 이름, 직무, 입사일, 커미션을 조회)
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.HIREDATE
     , e.COMM
  FROM emp e
 ORDER BY e.COMM, e.JOB, e.ENAME
;

--  9) emp 테이블에서 comm이 적은 순서대로, 직무별 오름차순, 이름별 내림차순으로 정렬(사번, 이름, 직무, 입사일, 커미션을 조회)
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.HIREDATE
     , e.COMM
  FROM emp e
 ORDER BY e.COMM, e.JOB , e.ENAME DESC
;

-- (4) Alias : 별칭
--  (10) emp 테이블에서
--       empno --> Employee No.
--       ename --> Employee Name
--       job   --> Job Name
SELECT e.EMPNO as "Employee No."
     , e.ENAME as "Employee Name"
     , e.JOB   as "Job Name"
  FROM emp e
;

/*------------------------
Employee No. Employee Name Job Name
---------------------------------------
7369	    SMITH	        CLERK
7499	    ALLEN	        SALESMAN
7521	    WARD	        SALESMAN
7566	    JONES	        MANAGER
7654	    MARTIN       	SALESMAN
7698	    BLAKE	        MANAGER
7782	    CLARK       	MANAGER
7839	    KING        	PRESIDENT
7844	    TURNER	        SALESMAN
7900	    JAMES	        CLERK
7902    	FORD        	ANALYST
7934	    MILLER	        CLERK
------------------------*/

--  11) 10번과 동일 as 키워드 생략하여 조회
--       empno --> 사번
--       ename --> 사원 이름
--       job   --> 직무
SELECT e.EMPNO "사번"
     , e.ENAME "사원 이름"
     , e.JOB   "직무"
  FROM emp e
;

/*------------------------
사번   사원 이름   직무
--------------------------
7369	SMITH	CLERK
7499	ALLEN	SALESMAN
7521	WARD	SALESMAN
7566	JONES	MANAGER
7654	MARTIN	SALESMAN
7698	BLAKE	MANAGER
7782	CLARK	MANAGER
7839	KING	PRESIDENT
7844	TURNER	SALESMAN
7900	JAMES	CLERK
7902	FORD	ANALYST
7934	MILLER	CLERK
------------------------*/

--  12) 테이블에 붙이는 별칭을 주지 않았을 때
SELECT empno
  FROM emp
;

SELECT emp.empno
  FROM emp
;

SELECT e.empno --FROM 절에서 설정된 테이블 별칭은 SELECT절에서 사용됨
  FROM emp e -- 소문자 e가 emp 테이블의 별칭이며 테이블 별칭은 FROM절에 사용함
;

SELECT d.DEPTNO
  FROM dept d
;

--  13) 영문별칭 사용시 특수기호 _ 사용하는 경우
SELECT e.EMPNO Employee_No
     , e.ENAME "Employee Name"
  FROM emp e
;

/*-------------------------
EMPLOYEE_NO, Employee Name
---------------------------
7369	SMITH
7499	ALLEN
7521	WARD
7566	JONES
7654	MARTIN
7698	BLAKE
7782	CLARK
7839	KING
7844	TURNER
7900	JAMES
7902	FORD
7934	MILLER
--------------------------*/

--  14) 별칭과 정렬의 조합 : SELECT절에 별칭을 준 경우 ORDER BY절에서 사용가능
--      emp 테이블에서 사번, 이름, 직무, 입사일, 커미션을 조회할 때
--      각 컬럼에 대해서 한글별칭을 주어 조회
--      정렬은 커미션, 직무, 이름을 오름차순 정렬
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.JOB   as "직무"
     , e.HIREDATE as "입사일"
     , e.COMM  as "커미션"
  FROM emp e
 ORDER BY 커미션, 직무, 이름
;

/*-------------------------------------------
사번,    이름,    직무,     입사일,    커미션
---------------------------------------------
7844	TURNER	SALESMAN	81/09/08	0
7499	ALLEN	SALESMAN	81/02/20	300
7521	WARD	SALESMAN	81/02/22	500
7654	MARTIN	SALESMAN	81/09/28	1400
7902	FORD	ANALYST	    81/12/03	
7900	JAMES	CLERK	    81/12/03	
7934	MILLER	CLERK	    82/01/23	
7369	SMITH	CLERK	    80/12/17	
7698	BLAKE	MANAGER 	81/05/01	
7782	CLARK	MANAGER	    81/06/09	
7566	JONES	MANAGER	    81/04/02	
7839	KING	PRESIDENT	81/11/17	
---------------------------------------------*/

--  15) DISTINCT, 별칭, 정렬의 조합
--      job의 중복을 제거하여 직무라는 별칭을 조회하고
--      내림차순으로 정렬
SELECT DISTINCT
       e.JOB as "직무"
  FROM emp e
 ORDER BY 직무 DESC
;

/*--------
직무
----------
SALESMAN
PRESIDENT
MANAGER
CLERK
ANALYST
---------*/

-- (5) WHERE 조건절
--  (16) emp테이블에서 empno가 7900인 사원의
--       사번, 이름, 직무, 입사일, 급여, 부서번호 조회
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.HIREDATE
     , e.SAL
     , e.DEPTNO
  FROM emp e
 WHERE e.EMPNO = 7900
;

/*----------------------------------------------
7900	JAMES	CLERK	81/12/03	950	    30
-----------------------------------------------*/

--  (17) emp테이블에서 empno는 7900이거나 deptno가 20인 직원의 정보를 조회(사번, 이름, 직무, 입사일, 급여, 부서번호)
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.HIREDATE
     , e.SAL
     , e.DEPTNO
  FROM emp e
 WHERE e.EMPNO = 7900
    OR e.DEPTNO = 20
;

/*----------------------------------------------
SMITH	CLERK	80/12/17	7369	800	    20
JONES	MANAGER	81/04/02	7566	2975	20
JAMES	CLERK	81/12/03	7900	950	    30
FORD	ANALYST	81/12/03	7902	3000	20
----------------------------------------------*/

--  18) 17번의 조회조건을 AND 조건으로 조합
--      empno가 7900이고 deptno가 20인 직원의 정보를 조회(사번, 이름, 직무, 입사일, 급여, 부서번호)
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.HIREDATE
     , e.SAL
     , e.DEPTNO
  FROM emp e
 WHERE e.EMPNO = 7900
   AND e.DEPTNO = 20
;
-- 인출 된 모든 행 : 0
/*---------------------------------------------

----------------------------------------------*/

--  19) job이 'CLERK' 이면서 deptno가 10인 직원 조회(사번, 이름, 직무, 부서번호)
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.DEPTNO
  FROM emp e
 WHERE e.JOB = 'CLERK' -- 문자값 비교시 '' 사용, 문자값은 대소문자 구분
   AND e.DEPTNO = 10   -- 숫자값 비교시 따옴표 사용안함
;

/*-------------------------
7934	MILLER	CLERK	10
--------------------------*/

--  20) 19번에서 직무 비교 값을 소문자 clerk과 비교하여 결과를 확인
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.DEPTNO
  FROM emp e
 WHERE e.JOB = 'CLERK' -- 문자값 비교시 '' 사용, 문자값은 대소문자 구분
   AND e.DEPTNO = 10   -- 숫자값 비교시 따옴표 사용안함
;

-- 소문자 clerk로 저장된 직무는 존재하지 않으므로
-- 인출 된 모든 행 : 0 결과가 발생함
/*--------------------------------

---------------------------------*/

-- (6) 연산자 1. 산술연산자
--  21) 사번, 이름, 급여를 조회하고, 급여의 3.3%에 해당하는 원청징수 세금을 계산하여 조회
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.SAL   as "급여"
     , e.SAL * 0.033 as "원천징수세금"
  FROM emp e
;

/*------------------------------
7369	SMITH	800	    26.4
7499	ALLEN	1600	52.8
7521	WARD	1250	41.25
7566	JONES	2975	98.175
7654	MARTIN	1250	41.25
7698	BLAKE	2850	94.05
7782	CLARK	2450	80.85
7839	KING	5000	165
7844	TURNER	1500	49.5
7900	JAMES	950	    31.35
7902	FORD	3000	99
7934	MILLER	1300	42.9
------------------------------*/

-- 실수령액에 해당하는 96.7%의 급여도 계산하여 조회
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.SAL   as "급여"
     , e.SAL * 0.033 as "원천징수세금"
     , e.SAL * 0.967 as "실수령액"
  FROM emp e
;

-- 동일결과를 내는 다른 계산1
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.SAL   as "급여"
     , e.SAL * 0.033 as "원천징수세금"
     , e.SAL - (e.SAL * 0.033) as "실수령액"
  FROM emp e
;

-- 동일결과를 내는 다른 계산2
SELECT e.EMPNO as "사번"
     , e.ENAME as "이름"
     , e.SAL   as "급여"
     , e.SAL * 0.033 as "원천징수세금"
     , e.SAL * (1 - 0.033) as "실수령액"
  FROM emp e
;

-- (6) 연산자 2. 비교연산자
--     비교연산자는 SELECT절에 사용할 수 없음
--     WHERE, HAVING 절에만 사용함

--  (22) 급여가 2000이 넘는 사원 조회(사번, 이름, 급여)
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.SAL > 2000
;

/*-------------------
7566	JONES	2975
7698	BLAKE	2850
7782	CLARK	2450
7839	KING	5000
7902	FORD	3000
--------------------*/

---     급여가 1000 이상인 사원 조회(사번, 이름, 급여)
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.SAL >= 1000
;


---     급여가 1000 이상이며 2000미만인 사원 조회(사번, 이름, 급여)
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.SAL >= 1000
   AND e.SAL < 2000
;

---     comm 값이 0보다 큰 사원 조회(사번, 이름, 급여)
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.COMM > 0
;

/*
 위의 실행 결과에서 comm이 (null)인 사람들의 행은
 처음부터 비교대상에 들지 않음에 주의해야 한다.
 (null)값은 비교연산자로 비교할 수 없는 값이다.
*/

--  23) 영업사원(SALESMAN) 직무를 가진 사람들은 급여와 수당을 함께 받으므로
--      영업사원의 실제 수령금을 계산해보자
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.SAL + e.COMM as "급여 + 수당"
  FROM emp e
;

/*----------------------------------
7369	SMITH	CLERK	
7499	ALLEN	SALESMAN	1900
7521	WARD	SALESMAN	1750
7566	JONES	MANAGER	
7654	MARTIN	SALESMAN	2650
7698	BLAKE	MANAGER	
7782	CLARK	MANAGER	
7839	KING	PRESIDENT	
7844	TURNER	SALESMAN	1500
7900	JAMES	CLERK	
7902	FORD	ANALYST	
7934	MILLER	CLERK	
==> 숫자결과 (null)값의 산술 연산 결과는 결국 (null)임을 주의하자
-----------------------------------*/

-- (6) 연산자 : 3. 논리연산자
--  NOT 연산자

--  24) 급여가 2000보다 적지 않은 직원 조회(사번, 이름, 급여)
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE NOT e.SAL < 2000
;

--  동일 결과를 내는 다른 쿼리 NOT 사용하지 않음
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.SAL >= 2000
;

/*--------------------
7566	JONES	2975
7698	BLAKE	2850
7782	CLARK	2450
7839	KING	5000
7902	FORD	3000
--------------------*/

-- (6) 연산자 : 4. SQL 연산자
--  IN 연산자 : 비교하고자 하는 기준 값이 제시된 항목 목록에 존재하면 참으로 판단

--  (25) 급여가 800, 3000, 5000중에 하나인 직원 조회(사번, 이름, 급여)
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.SAL = 800
    OR e.SAL = 3000
    OR e.SAL = 5000
;

--  IN 연산자를 사용하여 해결
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.SAL IN (800, 3000, 5000)
;

/*-------------------
7369	SMITH	800
7839	KING	5000
7902	FORD	3000
--------------------*/

--  LIKE 연산자 : 유사 값을 검색하는데 사용
/*  LIKE 연산자는 유사 값 검색을 위해 함께 사용하는 패턴 인식 문자가 있다.
    % : 0자릿수 이상의 모든 문자 패턴이 올 수 있음
    _ : 1자리의 모든 문자 패턴이 올 수 있음
*/

--  26) 이름이 J로 시작하는 직원 조회(사번, 이름)
SELECT e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME LIKE 'J%'
;

-- 이름이 M으로 시작하는 직원 조회(사번, 이름)
SELECT
  FROM emp e
 WHERE e.ENAME LIKE 'M%'
;

-- 이름에 M이 들어가는 직원 조회(사번, 이름)
SELECT e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME LIKE '%M%'
;

-- 이름의 두번째 자리에 M이 들어가는 직원 조회(사번, 이름)
SELECT e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME LIKE '_M%' -- 유사 패턴 인식 문자를 _를 사용하여 한글자로 제한
;

-- 이름의 세번째 자리에 M이 들어가는 직원 조회(사번, 이름)
SELECT e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME LIKE '__M%' -- 유사 패턴 인식 문자를 _를 두번 사용하여 앞자리 2글자로 제한
;

-- 이름의 둘째자리부터 LA가 들어가는 이름을 가진 직원 조회(사번, 이름)
SELECT e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME LIKE '_LA%'
;

/*-------------
7698	BLAKE
7782	CLARK
-------------*/

-- 이름이 J_로 시작하는 직원 조회(사번, 이름)
-- : 조회 값에 패턴인식 문자가 들어있는 데이터의 경우 어떻게 조회할 것인가?
SELECT e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME LIKE 'J\_%' ESCAPE '\'
;
-- 조회하려는 값에 들어있는 패턴인식 문자를 무효화 하려면 ESCAPE 절과 조합한다.

-- 이름이 J%로 시작하는 직원의 사번, 이름 조회
SELECT e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME LIKE 'J\%%' ESCAPE'\'
;