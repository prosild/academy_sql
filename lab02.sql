-- 실습문제)
-- 23)
SELECT *
  FROM emp e
 WHERE e.SAL BETWEEN 2500 AND 3000
;

/*---------------------------------------------------------
7566	JONES	MANAGER	7839	81/04/02	2975		20
7698	BLAKE	MANAGER	7839	81/05/01	2850		30
7902	FORD	ANALYST	7566	81/12/03	3000		20
----------------------------------------------------------*/

-- 24)
SELECT *
  FROM emp e
 WHERE e.COMM IS NULL
;

/*--------------------------------------------------------------
9999	J_JUNE	CLERK		500		
7369	SMITH	CLERK	    7902	80/12/17	800		    20
7566	JONES	MANAGER	    7839	81/04/02	2975		20
7698	BLAKE	MANAGER	    7839	81/05/01	2850		30
7782	CLARK	MANAGER	    7839	81/06/09	2450		10
7839	KING	PRESIDENT	    	81/11/17	5000		10
7900	JAMES	CLERK	    7698	81/12/03	950		    30
7902	FORD	ANALYST	    7566	81/12/03	3000		20
7934	MILLER	CLERK	    7782	82/01/23	1300		10
8888	J	    CLERK		        18/06/27	400		
7777	J%JONES	CLERK		        18/06/27	300		
---------------------------------------------------------------*/

-- 25)
SELECT *
  FROM emp e
 WHERE e.COMM IS NOT NULL
;

/*--------------------------------------------------------------------
7499	ALLEN	SALESMAN	7698	81/02/20	1600	300	    30
7521	WARD	SALESMAN	7698	81/02/22	1250	500	    30
7654	MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7844	TURNER	SALESMAN	7698	81/09/08	1500	0	    30
--------------------------------------------------------------------*/

-- 26)
SELECT e.EMPNO as "사번"
     , e.ENAME || '의 월급은 $' || e.SAL || '입니다' as "월급여"
  FROM emp e
;

/*-----------------------------------
사번,   월급여
-------------------------------------
9999	J_JUNE의 월급은 $500입니다
7369	SMITH의 월급은 $800입니다
7499	ALLEN의 월급은 $1600입니다
7521	WARD의 월급은 $1250입니다
7566	JONES의 월급은 $2975입니다
7654	MARTIN의 월급은 $1250입니다
7698	BLAKE의 월급은 $2850입니다
7782	CLARK의 월급은 $2450입니다
7839	KING의 월급은 $5000입니다
7844	TURNER의 월급은 $1500입니다
7900	JAMES의 월급은 $950입니다
7902	FORD의 월급은 $3000입니다
7934	MILLER의 월급은 $1300입니다
8888	J의 월급은 $400입니다
7777	J%JONES의 월급은 $300입니다
------------------------------------*/

-- 함수 시작
-- 1)
SELECT initcap(e.ENAME) as "이름"
  FROM emp e
;

/*--------
J_June
Smith
Allen
Ward
Jones
Martin
Blake
Clark
King
Turner
James
Ford
Miller
J
J%Jones
--------*/

-- 2)
SELECT lower(e.ENAME) as "이름"
  FROM emp e
;

/*-------
j_june
smith
allen
ward
jones
martin
blake
clark
king
turner
james
ford
miller
j
j%jones
-------*/

-- 3)
SELECT upper(e.ENAME) as "이름"
  FROM emp e
;

/*------
J_JUNE
SMITH
ALLEN
WARD
JONES
MARTIN
BLAKE
CLARK
KING
TURNER
JAMES
FORD
MILLER
J
J%JONES
-------*/

-- 4)
SELECT length('korea')
  FROM dual
;

/*-------
5
--------*/

SELECT lengthb('korea')
  FROM dual
;

/*-----
5
-------*/

-- 5)
SELECT length('박길수')
  FROM dual
;

/*------
3
-------*/

SELECT lengthb('박길수')
  FROM dual
;
/*------
9
-------*/

-- 6)
SELECT concat('SQL', '배우기')
  FROM dual
;

/*-----------
SQL배우기
------------*/

-- 7)
SELECT substr('SQL 배우기', 5, 2)
  FROM dual
;

/*--------
배우
--------*/

-- 8)
SELECT lpad('SQL', 7, '$')
  FROM dual
;

/*------
$$$$SQL
-------*/

-- 9)
SELECT rpad('SQL', 7, '$')
  FROM dual
;

/*------
SQL$$$$
------*/

-- 10)
SELECT ltrim('     sql 배우기      ')
  FROM dual
;

/*--------------
sql 배우기       
----------------*/

-- 11)
SELECT rtrim('     sql 배우기      ')
  FROM dual
;

/*--------------
     sql 배우기
---------------*/

-- 12)
SELECT trim('     sql 배우기      ')
  FROM dual
;

/*--------
sql 배우기
---------*/

-- 13)
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
     , nvl(e.COMM, 0)
  FROM emp e
;

/*----------------------------
9999	J_JUNE	500 	0
7369	SMITH	800	    0
7499	ALLEN	1600	300
7521	WARD	1250	500
7566	JONES	2975	0
7654	MARTIN	1250	1400
7698	BLAKE	2850	0
7782	CLARK	2450	0
7839	KING	5000	0
7844	TURNER	1500	0
7900	JAMES	950 	0
7902	FORD	3000	0
7934	MILLER	1300	0
8888	J   	400	    0
7777	J%JONES	300	    0
----------------------------*/

-- 14)
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
     , nvl2(e.COMM, e.SAL + e.COMM, 0)
  FROM emp e
;

/*---------------------------
9999	J_JUNE	500	    0
7369	SMITH	800	    0
7499	ALLEN	1600	1900
7521	WARD	1250	1750
7566	JONES	2975	0
7654	MARTIN	1250	2650
7698	BLAKE	2850	0
7782	CLARK	2450	0
7839	KING	5000	0
7844	TURNER	1500	1500
7900	JAMES	950	    0
7902	FORD	3000	0
7934	MILLER	1300	0
8888	J	    400 	0
7777	J%JONES	300	    0
------------------------------*/

-- 15)
-- CLERK    SALESMAN    MANAGER     ANALYST     PRESIDENT
-- 300      450         600         800         1000
SELECT e.EMPNO as "사원번호"
     , e.ENAME as "이름"
     , e.SAL as "급여"
     , to_char(DECODE(e.JOB
                    , 'CLERK', 300
                    , 'SALESMAN', 450
                    , 'MANAGER', 600
                    , 'ANALYST', 800
                    , 'PRESIDENT', 1000), '$9999') as "자기 계발비"
  FROM emp e
;

/*--------------------------------
사원번호, 이름, 급여,   자기 계발비
----------------------------------
9999	J_JUNE	500	      $300
7369	SMITH	800	      $300
7499	ALLEN	1600	  $450
7521	WARD	1250	  $450
7566	JONES	2975	  $600
7654	MARTIN	1250	  $450
7698	BLAKE	2850	  $600
7782	CLARK	2450	  $600
7839	KING	5000	  $1000
7844	TURNER	1500	  $450
7900	JAMES	950	      $300
7902	FORD	3000	  $800
7934	MILLER	1300	  $300
8888	J	    400	      $300
7777	J%JONES	300	      $300
--------------------------------*/
