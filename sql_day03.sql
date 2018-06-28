-- (3) 단일행 함수
--  6) CASE
--  job별로 경조사비를 급여대비 일정 비율로 지급하고 있다.
--  각 직원들의 경조사비 지원금을 구하자
/*
    CLERK     : 5%
    SALESMAN  : 4%
    MANAGER   : 3.7%
    ANALYST   : 3%
    PRESIDENT : 1.5%
*/

--   1. Simple CASE 구문으로 구해보자 : DECODE와 거의 유사, 동일비교만 가능
--                                      괄호가 없고, 콤마 대신 키워드 WHEN, THEN, ELSE 등을 사용
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , case e.JOB when 'CLERK'     then e.SAL * 0.05
                  when 'SALSEMAN'  then e.SAL * 0.04
                  when 'MANAGER'   then e.SAL * 0.037
                  when 'ANALYST'   then e.SAL * 0.03
                  when 'PRESIDENT' then e.SAL * 0.015
        end as "경조사 지원금"
  FROM emp e
;

--   2. Searched CASE 구문으로 구해보자
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , CASE WHEN e.JOB = 'CLERK'     THEN e.SAL * 0.05
            WHEN e.JOB = 'SALESMAN'  THEN e.SAL * 0.04
            WHEN e.JOB = 'MANAGER'   THEN e.SAL * 0.037
            WHEN e.JOB = 'ANALYST'   THEN e.SAL * 0.03
            WHEN e.JOB = 'PRESIDENT' THEN e.SAL * 0.015
            ELSE 10
        END as "경조사 지원금"
  FROM emp e
;

--  CASE 결과에 숫자 통화 패턴 씌우기 : $기호
SELECT e.EMPNO
     , e.ENAME
     , e.JOB
     , CASE WHEN e.JOB = 'CLERK'     THEN e.SAL * 0.05
            WHEN e.JOB = 'SALESMAN'  THEN e.SAL * 0.04
            WHEN e.JOB = 'MANAGER'   THEN e.SAL * 0.037
            WHEN e.JOB = 'ANALYST'   THEN e.SAL * 0.03
            WHEN e.JOB = 'PRESIDENT' THEN e.SAL * 0.015
            ELSE 10
        END as "경조사 지원금"
  FROM emp e
;
