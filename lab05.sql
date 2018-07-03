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
ON new_customer (userid)
;
-- Index IDX_CUST_USERID이(가) 생성되었습니다.

-- 4)
DESC USER_INDEXES
DESC USER_IND_COLUMNS
/*
이름                      널?       유형             
----------------------- -------- -------------- 
INDEX_NAME              NOT NULL VARCHAR2(30)   
INDEX_TYPE                       VARCHAR2(27)   
TABLE_OWNER             NOT NULL VARCHAR2(30)   
TABLE_NAME              NOT NULL VARCHAR2(30)   
TABLE_TYPE                       VARCHAR2(11)   
UNIQUENESS                       VARCHAR2(9)    
COMPRESSION                      VARCHAR2(8)    
PREFIX_LENGTH                    NUMBER         
TABLESPACE_NAME                  VARCHAR2(30)   
INI_TRANS                        NUMBER         
MAX_TRANS                        NUMBER         
INITIAL_EXTENT                   NUMBER         
NEXT_EXTENT                      NUMBER         
MIN_EXTENTS                      NUMBER         
MAX_EXTENTS                      NUMBER         
PCT_INCREASE                     NUMBER         
PCT_THRESHOLD                    NUMBER         
INCLUDE_COLUMN                   NUMBER         
FREELISTS                        NUMBER         
FREELIST_GROUPS                  NUMBER         
PCT_FREE                         NUMBER         
LOGGING                          VARCHAR2(3)    
BLEVEL                           NUMBER         
LEAF_BLOCKS                      NUMBER         
DISTINCT_KEYS                    NUMBER         
AVG_LEAF_BLOCKS_PER_KEY          NUMBER         
AVG_DATA_BLOCKS_PER_KEY          NUMBER         
CLUSTERING_FACTOR                NUMBER         
STATUS                           VARCHAR2(8)    
NUM_ROWS                         NUMBER         
SAMPLE_SIZE                      NUMBER         
LAST_ANALYZED                    DATE           
DEGREE                           VARCHAR2(40)   
INSTANCES                        VARCHAR2(40)   
PARTITIONED                      VARCHAR2(3)    
TEMPORARY                        VARCHAR2(1)    
GENERATED                        VARCHAR2(1)    
SECONDARY                        VARCHAR2(1)    
BUFFER_POOL                      VARCHAR2(7)    
FLASH_CACHE                      VARCHAR2(7)    
CELL_FLASH_CACHE                 VARCHAR2(7)    
USER_STATS                       VARCHAR2(3)    
DURATION                         VARCHAR2(15)   
PCT_DIRECT_ACCESS                NUMBER         
ITYP_OWNER                       VARCHAR2(30)   
ITYP_NAME                        VARCHAR2(30)   
PARAMETERS                       VARCHAR2(1000) 
GLOBAL_STATS                     VARCHAR2(3)    
DOMIDX_STATUS                    VARCHAR2(12)   
DOMIDX_OPSTATUS                  VARCHAR2(6)    
FUNCIDX_STATUS                   VARCHAR2(8)    
JOIN_INDEX                       VARCHAR2(3)    
IOT_REDUNDANT_PKEY_ELIM          VARCHAR2(3)    
DROPPED                          VARCHAR2(3)    
VISIBILITY                       VARCHAR2(9)    
DOMIDX_MANAGEMENT                VARCHAR2(14)   
SEGMENT_CREATED                  VARCHAR2(3)    

이름              널? 유형             
--------------- -- -------------- 
INDEX_NAME         VARCHAR2(30)   
TABLE_NAME         VARCHAR2(30)   
COLUMN_NAME        VARCHAR2(4000) 
COLUMN_POSITION    NUMBER         
COLUMN_LENGTH      NUMBER         
CHAR_LENGTH        NUMBER         
DESCEND            VARCHAR2(4)    

*/

-- 5)
SELECT i.INDEX_NAME
     , i.INDEX_TYPE
     , i.TABLE_NAME
     , i.TABLE_OWNER
     , i.INCLUDE_COLUMN
  FROM user_indexes i
;
-- IDX_CUST_USERID	NORMAL	NEW_CUSTOMER	HR	

-- 6)
SELECT i.*
  FROM user_ind_columns i
 WHERE i.INDEX_NAME = 'IDX_CUST_USERID'
;
/*----------------------------------------------------------------------------------------------------------
INDEX_NAME,         TABLE_NAME,     COLUMN_NAME,    COLUMN_POSITION,    COLUMN_LENGTH, CHAR_LENGTH  DESCEND
------------------------------------------------------------------------------------------------------------
IDX_CUST_USERID	    NEW_CUSTOMER	USERID	        1	                30	            30          ASC
-----------------------------------------------------------------------------------------------------------*/

-- 7)
