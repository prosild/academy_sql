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
SELECT e1.EMPNO
     , e1.ENAME
     , e1.MGR
     , e2.EMPNO
     , e2.ENAME
  FROM emp e1
     , emp e2
 WHERE e1.MGR(+) = e2.EMPNO
;
/*----------------------------
7369	SMITH	7902	7902	FORD
7499	ALLEN	7698	7698	BLAKE
7521	WARD	7698	7698	BLAKE
7566	JONES	7839	7839	KING
7654	MARTIN	7698	7698	BLAKE
7698	BLAKE	7839	7839	KING
7782	CLARK	7839	7839	KING
7844	TURNER	7698	7698	BLAKE
7900	JAMES	7698	7698	BLAKE
7902	FORD	7566	7566	JONES
7934	MILLER	7782	7782	CLARK
                        8888	J
                        7844	TURNER
                        7777	J%JONES
                        7521	WARD
                        7654	MARTIN
                        6666	JJ
                        7499	ALLEN
                        7934	MILLER
                        9999	J_JUNE
                        7369	SMITH
                        7900	JAMES
-----------------------------------------*/
-- 5)
SELECT e.ENAME
  FROM emp e
 WHERE e.job = (SELECT e.job
                  FROM emp e
                 WHERE ename = 'JAMES')
;
/*-------
J_JUNE
SMITH
JAMES
MILLER
J
J%JONES
--------*/

-- 6)
SELECT e1.EMPNO as "사번"
     , e1.ENAME as "이름"
     , nvl((SELECT e2.ENAME
              FROM emp e2
             WHERE e1.MGR = e2.EMPNO), '-') as "상사이름"
  FROM emp e1
;
/*----------------------
사번,   이름,     상사이름
------------------------
6666	  JJ	      -
9999	  J_JUNE	  -
7369	  SMITH   	FORD
7499	  ALLEN   	BLAKE
7521	  WARD	    BLAKE
7566	  JONES   	KING
7654	  MARTIN  	BLAKE
7698	  BLAKE   	KING
7782	  CLARK	    KING
7839	  KING	    -
7844	  TURNER   	BLAKE
7900	  JAMES   	BLAKE
7902	  FORD	    JONES
7934	  MILLER  	CLARK
8888	  J	        -
7777	  J%JONES 	-
-----------------------*/

-- 7)
SELECT * FROM dept;
SELECT * FROM emp;

SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , e.SAL
     , (SELECT d.DNAME
          FROM dept d
         WHERE e.DEPTNO = d.DEPTNO) as "DNAME"
     , (SELECT d.LOC
          FROM dept d
         WHERE e.DEPTNO = d.DEPTNO) as "LOC"
  FROM emp e
;

/*----------------------------------------------------------
EMPNO, ENAME, JOB,        SAL,    DNAME,      LOC
------------------------------------------------------------
6666	JJ		              2800		
9999	J_JUNE	CLERK	      500		
7369	SMITH 	CLERK	      800	    RESEARCH	  DALLAS
7499	ALLEN	  SALESMAN	  1600	  SALES	      CHICAGO
7521	WARD	  SALESMAN	  1250	  SALES	      CHICAGO
7566	JONES	  MANAGER	    2975	  RESEARCH	  DALLAS
7654	MARTIN	SALESMAN	  1250	  SALES	      CHICAGO
7698	BLAKE	  MANAGER	    2850	  SALES	      CHICAGO
7782	CLARK	  MANAGER	    2450	  ACCOUNTING	NEW YORK
7839	KING	  PRESIDENT	  5000	  ACCOUNTING	NEW YORK
7844	TURNER	SALESMAN	  1500	  SALES	      CHICAGO
7900	JAMES	  CLERK	      950	    SALES	      CHICAGO
7902	FORD	  ANALYST	    3000	  RESEARCH	  DALLAS
7934	MILLER	CLERK	      1300	  ACCOUNTING	NEW YORK
8888	J	      CLERK	      400		
7777	J%JONES	CLERK	      300		
-----------------------------------------------------------*/

-- DDL
-- 1)
CREATE TABLE customer
(   userid      VARCHAR2(4)     PRIMARY KEY
  , name        VARCHAR2(30)    NOT NULL
  , birthyear   NUMBER(4)
  , regdate     DATE            DEFAULT sysdate
  , address     VARCHAR2(30)
);

/*-----------------------------------
Table CUSTOMER이(가) 생성되었습니다.
------------------------------------*/

-- 2)
DESC customer;
/*-----------------------------
이름        널?       유형           
--------- -------- ------------ 
USERID    NOT NULL VARCHAR2(4)  
NAME      NOT NULL VARCHAR2(30) 
BIRTHYEAR          NUMBER(4)    
REGDATE            DATE         
ADDRESS            VARCHAR2(30)
------------------------------*/

-- 3)
CREATE TABLE new_cust
   AS SELECT *
        FROM customer
       WHERE 1 = 2
;
/*-----------------------------------
Table NEW_CUST이(가) 생성되었습니다.
------------------------------------*/

-- 4)
DESC new_cust;
/*-----------------------------
이름        널        유형           
--------- -------- ------------ 
USERID             VARCHAR2(4)  
NAME      NOT NULL VARCHAR2(30) 
BIRTHYEAR          NUMBER(4)    
REGDATE            DATE         
ADDRESS            VARCHAR2(30)
-------------------------------*/

-- 5)
CREATE TABLE salesman
    AS SELECT *
         FROM emp e
        WHERE e.JOB = 'SALESMAN'
;
/*----------------------------------
Table SALESMAN이(가) 생성되었습니다.
-----------------------------------*/

-- 6)
SELECT *
  FROM salesman
;
/*------------------------------------------------------------
EMPNO, ENAME, JOB,      MGR,  HIREDATE, SAL,  COMM, DEPTNO
--------------------------------------------------------------
7499	 ALLEN	SALESMAN	7698	81/02/20	1600	300	  30
7521	 WARD	  SALESMAN	7698	81/02/22	1250	500	  30
7654	 MARTIN	SALESMAN	7698	81/09/28	1250	1400	30
7844	 TURNER	SALESMAN	7698	81/09/08	1500	0	    30
------------------------------------------------------------*/

--7)
ALTER TABLE customer ADD
(  phone VARCHAR2(11)
 , grade VARCHAR2(30)
 , CONSTRAINT ck_customer_grade CHECK (grade IN ('VIP', 'GOLD', 'SILVER'))
);
/*------------------------------------
Table CUSTOMER이(가) 변경되었습니다.
-------------------------------------*/
DESC customer;
/*-----------------------------
이름        널        유형           
--------- -------- ------------ 
USERID    NOT NULL VARCHAR2(4)  
NAME      NOT NULL VARCHAR2(30) 
BIRTHYEAR          NUMBER(4)    
REGDATE            DATE         
ADDRESS            VARCHAR2(30) 
PHONE              VARCHAR2(11) 
GRADE              VARCHAR2(30)
-------------------------------*/

-- 8)
ALTER TABLE customer DROP COLUMN grade;
/*------------------------------------
Table CUSTOMER이(가) 변경되었습니다.
-------------------------------------*/
DESC customer;
/*-----------------------------
이름        널        유형           
--------- -------- ------------ 
USERID    NOT NULL VARCHAR2(4)  
NAME      NOT NULL VARCHAR2(30) 
BIRTHYEAR          NUMBER(4)    
REGDATE            DATE         
ADDRESS            VARCHAR2(30) 
PHONE              VARCHAR2(11)
--------------------------------*/
ALTER TABLE customer ADD
(  grade VARCHAR2(30)
 , CONSTRAINT ck_customer_grade CHECK (grade IN ('VIP', 'GOLD', 'SILVER'))
);
/*----------------------------------
Table CUSTOMER이(가) 변경되었습니다.
------------------------------------*/
DESC customer;
/*-----------------------------
이름        널        유형           
--------- -------- ------------ 
USERID    NOT NULL VARCHAR2(4)  
NAME      NOT NULL VARCHAR2(30) 
BIRTHYEAR          NUMBER(4)    
REGDATE            DATE         
ADDRESS            VARCHAR2(30) 
PHONE              VARCHAR2(11) 
GRADE              VARCHAR2(30)
------------------------------*/

-- 9)
ALTER TABLE customer MODIFY phone VARCHAR2(4);
-- Table CUSTOMER이(가) 변경되었습니다.
DESC customer;
/*-----------------------------
이름        널        유형           
--------- -------- ------------ 
USERID    NOT NULL VARCHAR2(4)  
NAME      NOT NULL VARCHAR2(30) 
BIRTHYEAR          NUMBER(4)    
REGDATE            DATE         
ADDRESS            VARCHAR2(30) 
PHONE              VARCHAR2(4)  
GRADE              VARCHAR2(30)
-------------------------------*/
ALTER TABLE customer MODIFY userid VARCHAR2(30);
-- Table CUSTOMER이(가) 변경되었습니다.
DESC customer;
/*-----------------------------
이름        널        유형           
--------- -------- ------------ 
USERID    NOT NULL VARCHAR2(30) 
NAME      NOT NULL VARCHAR2(30) 
BIRTHYEAR          NUMBER(4)    
REGDATE            DATE         
ADDRESS            VARCHAR2(30) 
PHONE              VARCHAR2(4)  
GRADE              VARCHAR2(30)
-------------------------------*/
ALTER TABLE customer MODIFY userid NUMBER(4);
-- Table CUSTOMER이(가) 변경되었습니다.
DESC customer;
/*-----------------------------
이름        널        유형           
--------- -------- ------------ 
USERID    NOT NULL NUMBER(4)    
NAME      NOT NULL VARCHAR2(30) 
BIRTHYEAR          NUMBER(4)    
REGDATE            DATE         
ADDRESS            VARCHAR2(30) 
PHONE              VARCHAR2(4)  
GRADE              VARCHAR2(30)
------------------------------*/
ALTER TABLE customer MODIFY userid VARCHAR2(30);
-- Table CUSTOMER이(가) 변경되었습니다.
DESC customer;
/*-----------------------------
이름        널        유형           
--------- -------- ------------ 
USERID    NOT NULL VARCHAR2(30) 
NAME      NOT NULL VARCHAR2(30) 
BIRTHYEAR          NUMBER(4)    
REGDATE            DATE         
ADDRESS            VARCHAR2(30) 
PHONE              VARCHAR2(4)  
GRADE              VARCHAR2(30) 
-------------------------------*/