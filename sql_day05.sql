-- day05 : SQL
-----------------------------------------------------------------
-- ORACLE의 특별한 컬럼

-- 1. ROWID : 물리적으로 디스크에 저장된 위치를 가리키는 값
--            물리적으로 저장된 위치이므로 한 행당 반드시 유일할 수 밖에 없음
--            ORDER BY절에 의해서 변경되지 않는 값
--  예) emp 테이블에서 'SIMTH'인 사람의 정보를 조회
SELECT e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME = 'SMITH'
;

-- rowid를 같이 조회
SELECT e.ROWID
     , e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME = 'SMITH'
;

-- rowid는 ORDER BY에 의해 변경되지 않는다.
SELECT e.ROWID
     , e.EMPNO
     , e.ENAME
  FROM emp e
-- ORDER BY e.ENAME
 ORDER BY e.EMPNO
;

-- 2. ROWNUM : 조회된 결과의 첫번 째 행부터 1로 출력
SELECT ROWNUM
     , e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME LIKE 'J%'
;
/*---------------------------
ROWNUM, EMPNO,  ENAME
-----------------------------
1	    6666	JJ
2	    9999	J_JUNE
3	    7566	JONES
4	    7900	JAMES
5	    8888	J
6	    7777	J%JONES
---------------------------*/

SELECT ROWNUM
     , e.EMPNO
     , e.ENAME
  FROM emp e
 WHERE e.ENAME LIKE 'J%'
 ORDER BY e.ENAME
;
/*--------------------------
ROWNUM, EMPNO,  ENAME
----------------------------
5	    8888	J
6	    7777	J%JONES
4	    7900	JAMES
1	    6666	JJ
3	    7566	JONES
2	    9999	J_JUNE
---------------------------*/
-- 위의 두 결과를 비교하면 rownum도 ORDER BY에 영향을
-- 받지 않는 것 처럼 보일 수 있으나
-- SUB-QUERY로 사용할 때 영향을 받음

SELECT rownum
     , a.EMPNO
     , a.ENAME
     , a."numrow"
  FROM (SELECT ROWNUM
             , e.EMPNO
             , e.ENAME
             , rownum as "numrow"
         FROM emp e
        WHERE e.ENAME LIKE 'J%'
        ORDER BY e.ENAME) a
;
/*-------------------------------
ROWNUM, EMPNO, ENAME,   numrow
---------------------------------
1	    8888	J	    5
2	    7777	J%JONES	6
3	    7900	JAMES	4
4	    6666	JJ	    1
5	    7566	JONES	3
6	    9999	J_JUNE	2
------------------------------*/

---------------------------------------------
-- DML : 데이터 조작어
---------------------------------------------
-- 1) INSERT : 테이블에 데이터 행(row)을 추가하는 명령
DROP TABLE member; -- Table MEMBER이(가) 삭제되었습니다.
CREATE TABLE member
(  member_id    VARCHAR2(3)     
 , member_name  VARCHAR2(15)    NOT NULL
 , phone        VARCHAR2(4)     -- NULL 허용시 제약조건 비우면 됨
 , reg_date     DATE            DEFAULT sysdate
 , address      VARCHAR2(30)
 , birth_month  NUMBER(2)
 , gender       VARCHAR2(1)     
 , CONSTRAINT pk_member        PRIMARY KEY (member_id)
 , CONSTRAINT ck_member_gender CHECK (gender IN ('M', 'F'))
 , CONSTRAINT ck_member_birth  CHECK (birth_month > 0 AND birth_month <= 12)
);

-- 테이블 구조 확인
DESC member;

--- 1. INTO 구무에 컬럼 이름 생략 시 데이터 추가
INSERT INTO member
VALUES ('M01', '전현찬', '5250', sysdate, '덕명동', 11, 'M');

INSERT INTO member
VALUES ('M02', '조성철', '9034', sysdate, '오정동', 8, 'M');

INSERT INTO member
VALUES ('M03', '김승유', '5219', sysdate, '오정동', 1, 'M');

-- 몇 컬럼에 NULL 데이터 추가
INSERT INTO member
VALUES ('M04', '박길수', '4003', sysdate, NULL, NULL, 'M');

INSERT INTO member
VALUES ('M05', '강현', NULL, NULL, '홍도동', 6, 'M');

INSERT INTO member
VALUES ('M06', '김소민', NULL, sysdate, '월평동', NULL, NULL);

-- 입력데이터 조회
SELECT m.*
  FROM member m
;
/*--------------------------------------------------------------------------
MEMBER_ID,  MEMBER_NAME, PHONE, REG_DATE,   ADDRESS,    BIRTH_MONTH, GENDER
----------------------------------------------------------------------------
M01	        전현찬	     5250	18/07/02	덕명동	    11	         M
M02	        조성철	     9034	18/07/02	오정동	    8	         M
M03	        김승유	     5219	18/07/02	오정동	    1	         M
M04	        박길수	     4003	18/07/02			                 M
M05	        강현			                홍도동	    6	         M
M06	        김소민		        18/07/02	월평동		
---------------------------------------------------------------------------*/

-- CHECK 옵션에 위배되는 데이터 추가 시도
INSERT INTO member
VALUES ('M07', '강병우', 2260, sysdate, '사정동', 2, 'N'); -- gender 위반
/*
오류 보고 -
ORA-02290: check constraint (SCOTT.CK_MEMBER_GENDER) violated
*/
-- 수정
INSERT INTO member
VALUES ('M07', '강병우', 2260, sysdate, '사정동', 2, 'M');
--------------------------------------------------------------------------------
INSERT INTO member
VALUES ('M08', '정준호', NULL, sysdate, '나성동', 0, NULL); -- birth_month 위반
/*
오류 보고 -
ORA-02290: check constraint (SCOTT.CK_MEMBER_BIRTH) violated
*/
-- 수정
INSERT INTO member
VALUES ('M08', '정준호', NULL, sysdate, '나성동', 1, NULL);

--- 2. INTO 구문에 컬럼 이름 명시하여 데이터 추가
--     : VALUES절에 INTO의 순서대로
--       값의 타입, 개수를 맞춰서 작성
INSERT INTO member (member_id, member_name, gender)
VALUES ('M09', '윤홍식', 'M');
-- reg_date 컬럼 : DEFAULT 설정이 작동하여 시스템 날짜가 자동 입력
-- phone, address 컬럼 : NULL 값으로 입력되는 것 확인

-- INTO 절에 컬럼 나열 시 테이블 정의 순서와 별개로 나열 가능
INSERT INTO member (member_name, address, member_id)
VALUES ('이주영', '용전동', 'M10');

-- PK 값이 중복되는 입력시도
INSERT INTO member (member_name, member_id)
VALUES ('남정규', 'M10');
/*
오류 보고 -
ORA-00001: unique constraint (SCOTT.PK_MEMBER) violated
*/
-- 수정 : 이름 컬럼에 주소가 들어가는 데이터
--        이름, 주소 모두 문자 데이터이기 때문에 타입이 맞아서
--        논리오류 발생
INSERT INTO member (member_name, member_id)
VALUES ('목동', 'M11');

-- 필수 입력 컬럼인 member_name 누락
INSERT INTO member (member_id)
VALUES ('M12');
/*
ORA-01400: cannot insert NULL into ("SCOTT"."MEMBER"."MEMBER_NAME")
*/
-- 수정
INSERT INTO member (member_id, member_name)
VALUES ('M12', '이동희');

-- INTO절에 나열 된 컬럼과 VALUES절의 값의 갯수 불일치
INSERT INTO member (member_id, member_name, gender)
VALUES ('M13', '유재성');
/*
SQL 오류: ORA-00947: not enough values
*/

-- INTO절에 나열 된 컬럼과 VALUES절의 데이터 타입이 불일치
INSERT INTO member (member_id, member_name, birth_month)
VALUES ('M13', '유재성', 'M');
-- 숫자가 들어가는 컬럼에 문자 입력 : ORA-01722: invalid number

-- 수정
INSERT INTO member (member_id, member_name, birth_month)
VALUES ('M13', '유재성', 3);

------------------------------------------------------------------
-- 다중 행 입력 : SUB-QUERY를 사용하여 가능

-- 구문구조
INSERT INTO 테이블이름
SELECT 문장; -- 서브쿼리

-- CREATE AS SELECT는 데이터를 복사하며 테이블 생성
-- VS.
-- INSERT INTO ~ SELECT는 이미 만들어진 테이블에
--    데이터만 복사 추가

-- member 테이블의 내용을 조회해서 new_member로 insert
INSERT INTO new_member
SELECT m.*
  FROM member m
 WHERE m.PHONE IS NOT NULL
;
-- 5개 행 이(가) 삽입되었습니다.

INSERT INTO new_member
SELECT m.*
  FROM member m
 WHERE m.MEMBER_ID > 'M09'
;
-- 4개 행 이(가) 삽입되었습니다.
-- NEW_MEMBER 테이블 데이터 삭제 X 버튼 클릭 후 -> 데이터 반영

-- 성이 '김'인 멤버 데이터 복사 입력
INSERT INTO new_member
SELECT m.*
  FROM member m
 WHERE m.MEMBER_NAME LIKE '김%'
;

-- 짝수 달에 태어난 멤버 데이터를 복사 입력
INSERT INTO new_member
SELECT m.*
  FROM member m
 WHERE MOD(m.BIRTH_MONTH, 2) = 0
;

---------------------------------------------------------------------
-- 2) UPDATE : 테이블의 행을 수정
--             WHERE 조건절의 조합에 따라 1행 혹은 다행 수정이 가능

-- member 테이블에서 이름이 잘못 들어간 'M11' 멤버 정보를 수정

-- 데이터 수정 전에 영구반영을 실행
COMMIT; -- 커밋 완료

UPDATE member m
   SET m.MEMBER_NAME = '남정규'
 WHERE m.MEMBER_ID = 'M11'
;
-- 1 행 이(가) 업데이트되었습니다.

-- 'M05' 회원의 전화번호 필드를 업데이트
UPDATE member m
   SET m.PHONE = '1743'
-- WHERE m.MEMBER_ID = 'M05'
;
-- 13개 행 이(가) 업데이트되었습니다.
-- WHERE 조건절의 실수로 DML 작업 실수가 발생
-- 데이터 상태 되돌리기
ROLLBACK; -- 롤백 완료. / 마지막 커밋 상태까지 되돌림

UPDATE member m
   SET m.PHONE = '1743'
 WHERE m.MEMBER_ID = 'M05'
;
-- 1 행 이(가) 업데이트되었습니다.

-- 2개 이상의 컬럼을 한번에 업데이트 SET절에 나열
UPDATE member m
   SET m.PHONE = '1743'
     , m.REG_DATE = sysdate
 WHERE m.MEMBER_ID = 'M05'
;
COMMIT;

-- '월평동' 사는 '김소민' 멤버의 NULL 업데이트
UPDATE member m
   SET m.PHONE = '4724'
     , m.BIRTH_MONTH = 1
     , m.GENDER = 'F'
 WHERE m.ADDRESS = '월평동'
;
-- 위의 실행 결과는 의도대로 반영되는 것처럼 보이나
-- 월평동에 사는 사람이 많다면
-- 월평동의 모든 사람 정보가 수정됨
-- 따라서 UPDATE 구문작성시 WHERE 조건은
-- 주의를 기울여서 작성해야 함

-- 수정
UPDATE member m
   SET m.PHONE = '4724'
     , m.BIRTH_MONTH = 1
     , m.GENDER = 'F'
 WHERE m.MEMBER_ID = 'M06'
;

/* DML : UPDATE, DELETE 작업시 주의할 점

    딱 하나의 데이터를 수정/삭제 하려면
    WHERE절의 비교 조건에 반드시 PK로 설정한
    컬럼의 값을 비교하도록 권장
    
    PK는 전체 행에서 유일하고, NOT NULL임이 보장되기 때문
    
    UPDATE, DELETE는 구문에 물리적 오류가 없으면
    WHERE 조건에 맞는 전체 행 대상으로 작업하는 것이
    기본이므로 항상 주의!!!
*/

-- UPDATE 구문에 SELECT 서브쿼리 사용
-- 'M08' 아이디의 phone, gender 수정

-- 권장되는 PK로 걸어서 수정하는 구문
UPDATE member m
   SET m.PHONE = '3318'
     , m.GENDER = 'M'
 WHERE m.MEMBER_ID = 'M08'
;

-- 서브쿼리 적용
UPDATE member m
   SET m.PHONE = '3318'
     , m.GENDER = 'M'
 WHERE m.ADDRESS = (SELECT m.ADDRESS
                      FROM member m
                     WHERE m.MEMBER_ID = 'M08')
;
-- 1 행 이(가) 업데이트되었습니다.

-- 'M13' 유재성 멤버의 성별 업데이트
UPDATE member m
   SET m.GENDER = (SELECT substr('MATH', 1, 1)
                     FROM dual)
 WHERE m.MEMBER_ID = 'M13'
;
-- 1 행 이(가) 업데이트되었습니다.

-- 'M12' 데이터 gender 컬럼 수정 시 제약조건 위반
UPDATE member m
   SET m.GENDER = 'N'
 WHERE m.MEMBER_ID = 'M12'
;
/*
오류 보고 -
ORA-02290: check constraint (SCOTT.CK_MEMBER_GENDER) violated
*/

-- address가 null인 사람들의 주소를 일괄 '대전'으로 수정
UPDATE member m
   SET m.ADDRESS = '대전'
 WHERE m.ADDRESS IS NULL
;

COMMIT;

SELECT m.*
  FROM member m
;


---------------------------------------------------------------------------------
-- 3) DELETE : 테이블에서 행 단위로 데이터 삭제

--- 1. WHERE 조건이 있는 DELETE 구문
-- 삭제 전 커밋
COMMIT;
-- gender가 'F'인 데이터를 삭제
DELETE FROM member m
 WHERE m.GENDER = 'R'
;
-- 0개 행 이(가) 삭제되었습니다.
-- 이 결과는 gender에 R 값이 없으므로
-- 삭제 된 행이 없는 결과를 얻은 것 뿐
-- 구문 오류는 아님, 논리적으로 잘못된 결과인 것

DELETE FROM member m
 WHERE m.GENDER ='F'
;
-- 데이터 되돌림
ROLLBACK;

DELETE FROM member m
 WHERE m.MEMBER_ID = 'M99'
;
-- 1 행 이(가) 삭제되었습니다.
COMMIT;
-- 커밋 완료.

--- 2. WHERE 조건이 없는 DELETE 구문
-- WHERE 조건을 아예 누락(생략)한 경우전체 행 삭제
DELETE FROM member;
-- 13개 행 이(가) 삭제되었습니다.
ROLLBACK;
-- 롤백 완료.

--- 3. DELETE의 WHERE에 서브쿼리 조합
-- 주소가 대저인 사람을 모두 삭제
--- (1) 주소가 대전인 사람을 조회
SELECT m.*
  FROM member m
 WHERE m.ADDRESS = '대전'
;

--- (2) 살제하는 메인 쿼리 작성
DELETE FROM member m
 WHERE m.MEMBER_ID IN (SELECT m.MEMBER_ID
                         FROM member m
                        WHERE m.ADDRESS = '대전')
;
-- 5개 행 이(가) 삭제되었습니다.
ROLLBACK;

-- 위와 동일한 작업을 일반 WHERE로 삭제
DELETE FROM member m
 WHERE m.ADDRESS = '대전'
;
-- 5개 행 이(가) 삭제되었습니다.
ROLLBACK;

-----------------------------------------------------------
-- DELETE VS. TRUNCATE
/*
    1. TRUNCATE는 DDL에 속하는 명령어
       ROLLBACK 지점을 생성하지 않음
       따라서 한 번 실행 된 DDL을 되돌릴 수 없음
       
    2. TRUNCATE는 WHERE절 조합이 안되므로
       특정 데이터 선별하여 삭제하는 것이 불가능
       
       사용시 주의!
*/

-- new_member 테이블을 TRUNCATE로 날려보자

-- 실행 전 되돌아갈 커밋 지점 생성
COMMIT;

-- new_member 내용 확인
SELECT n.*
  FROM new_member n
;

-- TRUNCATE로 new_member 테이블 잘라내기
TRUNCATE TABLE new_member;

-- 되돌리기 시도
ROLLBACK;

-- new_member 내용 확인
SELECT n.*
  FROM new_member n
;

-- DDL 종류의 구문은 생성 즉시 바로 커밋이 이루어짐
-- 롤백의 시점이 이미 DDL 실행 다음 시점으로 잡힘

------------------------------------------------------------
-- TCL : Transaction Control Language
-- 1) COMMIT
-- 2) ROLLBACK

-- 3) SAVEPOINT
--- 1. new_member 테이블에 1행 추가
COMMIT;
INSERT INTO new_member(MEMBER_ID, MEMBER_NAME)
VALUES ('M01', '홍길동')
;
-- 1 행 이(가) 삽입되었습니다.

-- 1행 추가 상태까지 중간 저장
SAVEPOINT do_insert; -- Savepoint이(가) 생성되었습니다.

--- 2. '홍길동' 데이터의 주소를 수정
UPDATE new_member m
   SET m.ADDRESS = '율도국'
 WHERE m.MEMBER_ID = 'M01'
;
-- 1 행 이(가) 업데이트되었습니다.

-- 수정 상태까지 중간 저장
SAVEPOINT do_update_addr; -- Savepoint이(가) 생성되었습니다.

--- 3. '홍길동' 데이터의 전화번호를 수정
UPDATE new_member m
   SET m.PHONE = '0001'
 WHERE m.MEMBER_ID = 'M01'
;
-- 1 행 이(가) 업데이트되었습니다.

-- 전화번호 수정 상태까지 중간 저장
SAVEPOINT do_update_phone; -- Savepoint이(가) 생성되었습니다.

--- 4. '홍길동' 데이터의 성별을 수정
UPDATE new_member m
   SET m.GENDER = 'K'
 WHERE m.MEMBER_ID = 'M01'
;
-- 1 행 이(가) 업데이트되었습니다.

SAVEPOINT do_update_gender; -- Savepoint이(가) 생성되었습니다.

-----------------------------------------------------------------
-- 홍길동 데이터의 ROLLBACK 시나리오

-- 1. 주소 수정까지는 맞는데, 전화번호, 성별 수정은 잘못됨
--    : 되돌아가야 할 SAVEPOINT = do_update_addr
ROLLBACK TO do_update_addr;
SELECT * FROM new_member;

-- 2. 주소, 전화번호까지 수정이 맞고, 성별 수정이 잘못됨
ROLLBACK TO do_update_phone;
/*
    ORA-01086: savepoint 'DO_UPDATE_PHONE' never established in this session or is invalid
    SAVEPOINT의 순서가 do_update_addr이 앞서기 때문에 여기까지 한번 rollback이
    일어나면 그 후에 생성된 SAVEPOINT는 삭제됨
    
    앞의 수정구문 재 실행 후 다시 전화번호 수정까지 돌아감
*/
ROLLBACK TO do_update_phone;


-- 3. 2번 수행 후 어디까지 롤백이 가능한가
ROLLBACK TO do_update_addr;
ROLLBACK TO do_insert;
ROLLBACK;
-- SAVEPOINT로 한번 되돌아가면 되돌아간 시점 이후
-- 생성된 SAVEPOINT는 무효화 됨

-----------------------------------------------------------------------------------------------------

-- 1. 시작번호 : 1, 최대 : 30, 사이클이 없는 시퀀스 생성
CREATE SEQUENCE seq_member_id
START WITH 1
MAXVALUE 30
NOCYCLE
;

-- Sequence SEQ_MEMBER_ID이(가) 생성되었습니다.

-- 시퀀스가 생성되면 유저 딕셔너리에 정보가 저장됨
-- : user_sequences

SELECT s.SEQUENCE_NAME
     , s.MIN_VALUE
     , s.MAX_VALUE
     , s.CYCLE_FLAG
     , s.INCREMENT_BY
  FROM user_sequences s
 WHERE s.SEQUENCE_NAME = 'SEQ_MEMBER_ID'
;
/*--------------------------------------------------------------
SEQUENCE_NAME,  MIN_VALUE,  MAX_VALUE,  CYCLE_FLAG, INCREMENT_BY
----------------------------------------------------------------
SEQ_MEMBER_ID	1	        30	        N	        1
---------------------------------------------------------------*/

-- 사용자의 객체가 저장되는 딕셔너리 테이블
-- : user_objects
SELECT o.OBJECT_NAME
     , o.OBJECT_TYPE
     , o.OBJECT_ID
  FROM user_objects o
;

/*  ------------------------------------
    메타 데이터를 저장하는 유저 딕셔너리
    ------------------------------------
    무결성 제약조건 : user_constraints
    시퀀스 생성정보 : user_sequences
    테이블 생성정보 : user_tables
    인덱스 생성정보 : user_indexs
    객체들 생성정보 : user_objets
    ------------------------------------*/
    
-- 2. 생선된 시퀀스 사용
--- (1) NEXTVAL : 시퀀스의 다음 번호를 생성
--                CREATE되고 나서 반드시 
--                최초에 한번은 NEXTVAL 호출되어야 생성 시작됨

--      사용법 : 시퀀스이름.NEXTVAL
SELECT SEQ_MEMBER_ID.NEXTVAL
  FROM dual
;
-- MAXVALUE 이상 생성하면
-- ORA-08004: sequence SEQ_MEMBER_ID.NEXTVAL exceeds MAXVALUE and cannot be instantiated
--- (2) CURRVAL : 시퀀스에서 현재 생성된 번호 확인
--                시퀀스 생성 후 NEXTVAL이 한번도 호출 된 적 없으면 비활성화 상태

--      사용법 : 시퀀스이름.CURRVAL
SELECT SEQ_MEMBER_ID.CURRVAL
  FROM dual
;

/* NEXTVAL 최초 한번 실행 전 CURRVAL을 실행하면 아래와 같은 오류
ORA-08002: sequence SEQ_TEST.CURRVAL is not yet defined in this session
*/

-- 3. 시퀀스 수정 : ALTER SEQUENCE
--                  생성한 시퀀스 seq_member_id의 MAXVALUE 옵션을 NOMAXVALUE로
ALTER SEQUENCE seq_member_id
NOMAXVALUE
;
-- Sequence SEQ_MEMBER_ID이(가) 변경되었습니다.

-- 4. 시퀀스 삭제 : DROP SEQUENCE
--                  생성한 시퀀스 seq_member_id 삭제
DROP SEQUENCE seq_member_id
;
-- Sequence SEQ_MEMBER_ID이(가) 삭제되었습니다.

-- 존재하지 않는 시퀀스에서 CURRVAL 시도
SELECT seq_member_id.CURRVAL
  FROM dual
;
-- ORA-02289: sequence does not exist

-- 멤버 아이디에 조합할 시퀀스 신규 생성
CREATE SEQUENCE seq_member_id
START WITH 1
NOMAXVALUE
NOCYCLE
;

-- 일괄적으로 증가하는 값을 멤버 아이디로 자동생성
-- 'M01', 'M02', ... 'M0X' 이런 형태의 값을 조합
SELECT 'M' || LPAD(seq_member_id.NEXTVAL, 2, 0) as "MEMBER_ID"
  FROM dual
;

-------------------------------------------------------------------

-- INDEX : 데이터의 검색(조회)시 일정한 검색 속도를 보장하기 위하여
--         DBMS가 관리하는 객체

-- 1. user_indexes 딕셔너리에서 검색
SELECT i.INDEX_NAME
     , i.INDEX_TYPE
     , i.TABLE_NAME
     , i.TABLE_OWNER
     , i.INCLUDE_COLUMN
  FROM user_indexes i
;

-- 2. 테이블의 주키(PK) 컬럼에 대해서는 이미 DBMS가 자동으로
--    인덱스 생성함.
--    따라서 또 생성 시도시 생성 불가능

--  예) member 테이블의 member_id 컬럼에 인덱스 생성 시도
CREATE INDEX idx_member_id
ON member (member_id)
;
-- ORA-01408: such column list already indexed
-- 테이블의 주키 컬럼에는 이미 있으므로 오류 발생
-- 생성하는 인덱스 이름이 달라도 생성할 수 없음

-- 3. 복사한 테이블인 new_member에는 PK가 없으므로 인덱스도 없는 상태
--    new_member 테이블에 index 생성 시도
CREATE INDEX idx_new_member_id
ON new_member(member_id)
;
-- Index IDX_NEW_MEMBER_ID이(가) 생성되었습니다.

-- user indexes 딕셔너리에서 검색
SELECT i.INDEX_NAME
     , i.INDEX_TYPE
     , i.TABLE_NAME
     , i.TABLE_OWNER
     , i.INCLUDE_COLUMN
  FROM user_indexes i
;
-- IDX_NEW_MEMBER_ID	NORMAL	NEW_MEMBER	SCOTT	

--- (2) 대상 컬럼이 중복 값이 없는 컬럼임이 확실하다면
--      UNIQUE 인덱스 생성이 가능
DROP INDEX idx_new_member_id;

CREATE UNIQUE INDEX idx_new_member_id
ON new_member(member_id)
;

SELECT i.INDEX_NAME
     , i.INDEX_TYPE
     , i.TABLE_NAME
     , i.TABLE_OWNER
     , i.INCLUDE_COLUMN
  FROM user_indexes i
;
-- IDX_NEW_MEMBER_ID	NORMAL	NEW_MEMBER	SCOTT

-- INDEX가 명시적으로 사용되는 경우

-- 오라클에 빠른 검색을 위해 HINT절을 SELECT에 사용하는 경우가 존재
