-- SQL Day02

-- IS NULL, IS NOT NULL 연산자
/*
IS NULL : 비교하려는 컬럼의 값이 NULL이면 true, NULL이 아니면 false
IS NOT NULL : 비교하려는 컬럼의 값이 NULL이 아니면 true, NULL이면 false

NULL값은 컬럼은 비교연산자와 연산이 불가능 하므로
NULL값 비교 연산자가 따로 존재함

col1 = null  ==> NULL 값에 대해서는 = 비교 연산자 사용 불가능
col1 != null ==> NULL 값에 대해서는 !=, <> 비교 연산자 사용 불가능
*/

--  27) 어떤 직원의 mgr가 지정되지 않은 직원 정보 조회
SELECT e.EMPNO
     , e.ENAME
     , e.MGR
  FROM emp e
 WHERE e.MGR IS NULL
;

/*-----------------------
EMPNO,  ENAME,      MGR
-------------------------
9999	J_JUNE	
7839	KING	
8888	J	
7777	J%JONES	
------------------------*/

--  mgr이 배정된 직원 정보 조회
SELECT e.EMPNO
     , e.ENAME
     , e.MGR
  FROM emp e
 WHERE e.MGR IS NOT NULL
;

/*--------------------
EMPNO,  ENAME,   MGR
----------------------
7369	SMITH	7902
7499	ALLEN	7698
7521	WARD	7698
7566	JONES	7839
7654	MARTIN	7698
7698	BLAKE	7839
7782	CLARK	7839
7844	TURNER	7698
7900	JAMES	7698
7902	FORD	7566
7934	MILLER	7782
---------------------*/

--  IS NOT NULL 대신 <>, != 연산자를 사용한 경우의 조회 결과 비교
SELECT e.EMPNO
     , e.ENAME
     , e.MGR
  FROM emp e
 WHERE e.MGR <> NULL
;

/*-------------------------------------
인출된 모든 행 : 0
-------------------------------------*/
--> 이런 경우는 오류 찾기가 어렵기 때문에 NULL 데이터를 다룰때는 항상 주의

--  BETWEEN a AND b : 범위 비교 연산자(범위 포함)
--  a <= sal <= b   : 이러한 범위 연산과 동일

--  28) 급여가 500 ~ 1200 사이인 직원 정보 조회
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.SAL BETWEEN 500 AND 1200
;

/*------------------
9999	J_JUNE	500
7369	SMITH	800
7900	JAMES	950
-------------------*/

--  BETWEEN 500 AND 1200과 같은 결과를 내는 비교연산자
SELECT e.EMPNO
     , e.ENAME
     , e.SAL
  FROM emp e
 WHERE e.SAL >= 500
   AND e.SAL <= 1200
;

--  EXISTS 연산자 : 조회한 결과가 1행 이상 있다.
--                  어떤 SELECT 구문을 실행했을 때 조회 결과가 1행 이상 있으면
--                  이 연산자의 결과가 true
--                  조회 결과 : <인출된 모든 행 : 0> 인 경우 false
--                  따라서 서브쿼리와 함께 사용됨

--  29) 급여가 10000이 넘는 사람이 있는가?
--   (1) 급겨아 10000이 넘는 사람을 찾는 구문을 작성
SELECT e.ENAME
  FROM emp e
 WHERE e.SAL > 10000
;

/*
위의 쿼리 실행 결과가 1행이라도 존재하면 화면에
"급여가 3000이 넘는 직원이 존재함" 이라고 출력
*/

SELECT '급여가 10000이 넘는 직원이 존재함' as "시스템 메시지"
  FROM dual
 WHERE EXISTS (SELECT e.ENAME
                 FROM emp e
                WHERE e.SAL > 3000)
;

/*
위의 쿼리 실행 결과가 1행이라도 존재하면 화면에
"급여가 10000이 넘는 직원이 존재하지 않음" 이라고 출력
*/

SELECT '급여가 10000이 넘는 직원이 존재하지 않음' as "시스템 메시지"
  FROM dual
 WHERE NOT EXISTS (SELECT e.ENAME
                     FROM emp e
                    WHERE e.SAL > 10000)
;

-- (6) 연산자 : 결합연산자 (||)
--  오라클에만 존재, 문자열 결합(접합)
--  다른 자바 등의 프로그래밍 언어에서는 OR 논리 연산자로 사용되므로
--  혼동에 주의

--  오늘의 날짜를 화면에 조회
SELECT sysdate
  FROM dual
;

--  오늘의 날짜를 알려주는 문장을 만들려면
SELECT '오늘의 날짜는 ' || sysdate || '입니다.' as "오늘의 날짜"
  FROM dual
;

/*----------------------------
오늘의 날짜는 18/06/27입니다.
-----------------------------*/

--  직원의 사번을 알려주는 구문을 || 연산자를 사용하여 작성
SELECT '안녕하세요. ' || e.ENAME || '씨, 당신의 사번은 ' || e.EMPNO || '입니다.' as "사번 알림"
  FROM emp e
;

/*---------------------------------------------------
안녕하세요. J_JUNE씨, 당신의 사번은 9999입니다.
안녕하세요. SMITH씨, 당신의 사번은 7369입니다.
안녕하세요. ALLEN씨, 당신의 사번은 7499입니다.
안녕하세요. WARD씨, 당신의 사번은 7521입니다.
안녕하세요. JONES씨, 당신의 사번은 7566입니다.
안녕하세요. MARTIN씨, 당신의 사번은 7654입니다.
안녕하세요. BLAKE씨, 당신의 사번은 7698입니다.
안녕하세요. CLARK씨, 당신의 사번은 7782입니다.
안녕하세요. KING씨, 당신의 사번은 7839입니다.
안녕하세요. TURNER씨, 당신의 사번은 7844입니다.
안녕하세요. JAMES씨, 당신의 사번은 7900입니다.
안녕하세요. FORD씨, 당신의 사번은 7902입니다.
안녕하세요. MILLER씨, 당신의 사번은 7934입니다.
안녕하세요. J씨, 당신의 사번은 8888입니다.
안녕하세요. J%JONES씨, 당신의 사번은 7777입니다.
---------------------------------------------------*/
