-- 실습문제

-- DML
-- 1)
SELECT c.*
  FROM customer c;

INSERT INTO customer (USERID, NAME, BIRTHYEAR, REGDATE, ADDRESS)
VALUES ('C001', '김수현', 1988, sysdate, '경기');

INSERT INTO customer (USERID, NAME, BIRTHYEAR, REGDATE, ADDRESS)
VALUES ('C002', '이효리', 1979, sysdate, '제주');

INSERT INTO customer (USERID, NAME, BIRTHYEAR, REGDATE, ADDRESS)
VALUES ('C003', '원빈', 1977, sysdate, '강원');

/*
1 행 이(가) 삽입되었습니다.


1 행 이(가) 삽입되었습니다.


1 행 이(가) 삽입되었습니다.
*/
SELECT c.*
  FROM customer c
;
/*------------------------------------------
C001	김수현	1988	18/07/02	경기
C002	이효리	1979	18/07/02	제주
C003	원빈	1977	18/07/02	강원
-------------------------------------------*/

-- 2)
UPDATE customer c
   SET c.NAME = '차태현'
     , c.BIRTHYEAR = 1976
 WHERE c.USERID = 'C001'
;
/*---------------------------------------
C001	차태현	1976	18/07/02	경기
C002	이효리	1979	18/07/02	제주
C003	원빈	1977	18/07/02	강원
----------------------------------------*/

-- 3)
UPDATE customer c
   SET c.ADDRESS = '서울'
;
/*---------------------------------------
C001	차태현	1976	18/07/02	서울
C002	이효리	1979	18/07/02	서울
C003	원빈	1977	18/07/02	서울
----------------------------------------*/
COMMIT;

-- 4)
DELETE FROM customer c
 WHERE c.USERID = 'C003'
;
/*---------------------------------------
C001	차태현	1976	18/07/02	서울
C002	이효리	1979	18/07/02	서울
----------------------------------------*/

-- 5)
DELETE FROM customer c;
/*----------------------------------
인출된 모든 행 : 0
-----------------------------------*/

-- 6)
ROLLBACK;
SELECT c.*
  FROM customer c;
/*-----------------------------------------
C001	차태현	1976	18/07/02	서울
C002	이효리	1979	18/07/02	서울
C003	원빈	1977	18/07/02	서울
-----------------------------------------*/
TRUNCATE TABLE customer;

SELECT c.*
  FROM customer c;
/*--------------------------------------
인출된 모든 행 : 0
---------------------------------------*/

-- SEQUENCE
-- 1)
CREATE SEQUENCE seq_cust_userid
START WITH 1
MAXVALUE 99
NOCYCLE
;
-- Sequence SEQ_CUST_USERID이(가) 생성되었습니다.

-- 2)
SELECT s.SEQUENCE_NAME
     , s.MIN_VALUE
     , s.MAX_VALUE
     , s.CYCLE_FLAG
     , s.INCREMENT_BY
  FROM user_sequences s
 WHERE s.SEQUENCE_NAME = 'SEQ_CUST_USERID'
;
/*---------------------------------------------------------------
SEQUENCE_NAME,  MIN_VALUE,  MAX_VALUE,  CYCLE_FLAG, INCREMENT_BY
-----------------------------------------------------------------
SEQ_CUST_USERID	1	          99	        N	          1
----------------------------------------------------------------*/

-- 3)
DROP TABLE new_customer;

CREATE TABLE new_customer
AS
SELECT c.*
  FROM customer c
 WHERE 1 = 2
;

CREATE INDEX idx_cust_userid
ON customer (userid)
;
