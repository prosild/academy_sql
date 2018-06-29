-- 실습문제
-- 조인

-- 3)
SELECT e.EMPNO
     , e.ENAME
     , e.MGR
  FROM emp e
 WHERE e.MGR IS NULL
;
/*-----------------------
EMPNO,  ENAME,  MGR
-------------------------
6666	JJ	
9999	J_JUNE	
7839	KING	
8888	J	
7777	J%JONES	
-----------------------*/

-- 4)
