-- 실습문제
-- 단일행 함수

-- 16)
-- CLERK    SALESMAN    MANAGER     ANALYST     PRESIDENT
-- 300      450         600         800         1000
SELECT e.EMPNO   as "사원번호"
     , e.ENAME   as "이름"
     , e.SAL     as "급여"
     , TO_CHAR(CASE e.JOB WHEN 'CLERK'     THEN 300
                          WHEN 'SALESMAN'  THEN 450
                          WHEN 'MANAGER'   THEN 600
                          WHEN 'ANALYST'   THEN 800
                          WHEN 'PRESIDENT' THEN 1000
                END, '$9,999') as "자기 계발비"
  FROM emp e
;
/*--------------------------------
사원번호, 이름, 급여,   자기 계발비
----------------------------------
6666	JJ	    2800	
9999	J_JUNE	500	       $300
7369	SMITH	800	       $300
7499	ALLEN	1600	   $450
7521	WARD	1250	   $450
7566	JONES	2975	   $600
7654	MARTIN	1250	   $450
7698	BLAKE	2850	   $600
7782	CLARK	2450	   $600
7839	KING	5000	 $1,000
7844	TURNER	1500	   $450
7900	JAMES	950	       $300
7902	FORD	3000	   $800
7934	MILLER	1300	   $300
8888	J	    400	       $300
7777	J%JONES	300	       $300
---------------------------------*/

-- 17)
SELECT e.EMPNO   as "사원번호"
     , e.ENAME   as "이름"
     , e.SAL     as "급여"
     , TO_CHAR(CASE WHEN e.JOB = 'CLERK'     THEN 300
                    WHEN e.JOB = 'SALESMAN'  THEN 450
                    WHEN e.JOB = 'MANAGER'   THEN 600
                    WHEN e.JOB = 'ANALYST'   THEN 800
                    WHEN e.JOB = 'PRESIDENT' THEN 1000
                END, '$9,999') as "자기 계발비"
  FROM emp e
;
/*-------------------------------
6666	JJ	    2800	
9999	J_JUNE	500	       $300
7369	SMITH	800	       $300
7499	ALLEN	1600	   $450
7521	WARD	1250	   $450
7566	JONES	2975	   $600
7654	MARTIN	1250	   $450
7698	BLAKE	2850	   $600
7782	CLARK	2450	   $600
7839	KING	5000	 $1,000
7844	TURNER	1500	   $450
7900	JAMES	950	       $300
7902	FORD	3000	   $800
7934	MILLER	1300	   $300
8888	J	    400	       $300
7777	J%JONES	300	       $300
--------------------------------*/

-- 18)
SELECT COUNT(*)
  FROM emp e
;
/*---------
16
-----------*/

-- 19)
SELECT COUNT(DISTINCT e.JOB)
  FROM emp e
;
/*------------
5
------------*/

-- 20)
SELECT COUNT(e.COMM) as "커미션을 받는 사원"
  FROM emp e
;
/*----------------
커미션을 받는 사원
------------------
4
------------------*/

-- 21)
SELECT SUM(e.SAL) as "전 직원의 급여 총합"
  FROM emp e
;
/*-------------------
전 직원의 급여 총합
---------------------
28925
--------------------*/

-- 22)
SELECT AVG(e.SAL) as "전 직원의 급여 평균"
  FROM emp e
;

/*------------------
전 직원의 급여 평균
--------------------
1807.8125
-------------------*/

-- 23)
SELECT SUM(e.SAL) as "급여 총합"
     , TO_CHAR(AVG(e.SAL), '9,999.00') as "급여 평균"
     , MAX(e.SAL) as "최대 급여"
     , MIN(e.SAL) as "최소 급여"
  FROM emp e
 WHERE e.DEPTNO = 20
;
/*------------------------------------------
급여 총합, 급여 평균, 최대 급여, 최소 급여
--------------------------------------------
6775	   2,258.33	    3000	    800
-------------------------------------------*/

-- 24)
SELECT STDDEV(e.SAL) as "급여 표준편차"
  FROM emp e
;
/*----------------------------------------
1269.964525423184146877743892556640279933
-----------------------------------------*/

-- 25)
SELECT VARIANCE(e.SAL) as "급여 분산"
  FROM emp e
;
/*----------------------------------------
1612809.89583333333333333333333333333333
-----------------------------------------*/

-- 26)
-- CLERK    SALESMAN    MANAGER    ANALYST    PRESIDENT
-- 300      450         600        800        1000
SELECT 
  FROM emp e
;