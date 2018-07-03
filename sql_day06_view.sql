------------------------------------------------------------
-- VIEW : 논리적으로만 존재하는 가상 테이블
------------------------------------------------------------

-- 1. SCOTT 계정에 VIEW 생성 권한 설정
CONN sys as sysdba;

GRANT CREATE VIEW TO SCOTT;
CONN SCOTT/TIGER;

-- 2. emp, dept 복사
DROP TABLE new_emp;
DROP TABLE new_dept;

CREATE TABLE new_emp
AS
SELECT e.*
  FROM emp e
 WHERE 1 = 1
;

CREATE TABLE new_dept
AS
SELECT d.*
  FROM dept d
 WHERE 1 = 1
;

-- 3. 복사 테이블에 누락 된 PK 설정 ALTER
-- new_dept에 PK 설정
ALTER TABLE new_dept ADD
(   CONSTRAINT pk_new_dept PRIMARY KEY(deptno)
);

-- new_emp에 PK 설정
ALTER TABLE new_emp ADD
(   CONSTRAINT pk_new_emp       PRIMARY KEY (empno)
  , CONSTRAINT fk_new_deptno    FOREIGN KEY (deptno) REFERENCES new_dept(deptno)
  , CONSTRAINT fk_new_emp_mgr   FOREIGN KEY (mgr)    REFERENCES new_emp(empno)
);

-- 4. 복사 테이블에서 view 생성
--    : 상사이름, 부서명, 부서위치까지 조회 할 수 있는 뷰
CREATE OR REPLACE VIEW v_emp_dept
AS
SELECT e1.EMPNO
     , e1.ENAME
     , e2.ENAME as "MGR_NAME"
     , e1.DEPTNO
     , d.DNAME
     , d.LOC
  FROM new_emp e1 LEFT OUTER JOIN new_emp e2 ON e1.MGR = e2.EMPNO
                  LEFT OUTER JOIN dept d     ON e1.DEPTNO = d.DEPTNO
  WITH READ ONLY
;

-- View V_EMP_DEPT이(가) 생성되었습니다.

-- 5. 생성된 뷰의 구조 확인
DESC v_emp_dept;

-- 6. 뷰 정보는 딕셔너리에 저장됨. 딕셔너리 확인
DESC user_views
;
/*
이름       널?       유형           
-------- -------- ------------ 
EMPNO    NOT NULL NUMBER(4)    
ENAME             VARCHAR2(10) 
MGR_NAME          VARCHAR2(10) 
DEPTNO            NUMBER(2)    
DNAME             VARCHAR2(14) 
LOC               VARCHAR2(13) 
*/

SELECT u.VIEW_NAME
     , u.TEXT
     , u.READ_ONLY
  FROM user_views u
;

-- 7. 생성된 뷰에서 데이터 확인
---- 1) 전체 조회
SELECT v.*
  FROM v_emp_dept v
;

---- 2) SALES 이름 부서의 소속 직원 조회
SELECT v.EMPNO
     , v.ENAME
     , v.DNAME
  FROM v_emp_dept v
 WHERE v.DNAME = 'SALES'
;
/*-------------------
EMPNO,  ENAME,  DNAME
---------------------
7499	ALLEN	SALES
7521	WARD	SALES
7654	MARTIN	SALES
7698	BLAKE	SALES
7844	TURNER	SALES
7900	JAMES	SALES
--------------------*/
