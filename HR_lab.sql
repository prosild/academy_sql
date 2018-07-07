SELECT * FROM employees;
SELECT * FROM jobs;

--1. employees 테이블에서 job_id 를 중복 배제하여 조회 하고
--   job_title 같이 출력
--19건
SELECT DISTINCT e.job_id
              , j.job_title
  FROM employees e JOIN jobs j ON (e.job_id = j.job_id)
;
/*-------------------------------------------
JOB_ID,     JOB_TITLE
---------------------------------------------
AD_ASST	    Administration Assistant
SA_REP	    Sales Representative
IT_PROG	    Programmer
MK_MAN	    Marketing Manager
AC_MGR  	  Accounting Manager
FI_MGR	    Finance Manager
AC_ACCOUNT	Public Accountant
PU_MAN	    Purchasing Manager
SH_CLERK	  Shipping Clerk
FI_ACCOUNT	Accountant
AD_PRES	    President
SA_MAN	    Sales Manager
MK_REP	    Marketing Representative
AD_VP	      Administration Vice President
PU_CLERK	  Purchasing Clerk
ST_MAN	    Stock Manager
ST_CLERK	  Stock Clerk
HR_REP	    Human Resources Representative
PR_REP	    Public Relations Representative
-----------------------------------------------*/

--2. employees 테이블에서 사번, 라스트네임, 급여, 커미션 팩터,
--   급여x커미션팩터(null 처리) 조회
--   커미션 컬럼에 대해 null 값이면 0으로 처리하도록 함
--107건
SELECT e.EMPLOYEE_ID
     , e.LAST_NAME
     , e.SALARY
     , nvl(e.COMMISSION_PCT, 0) as "COMMISSION_PCT"
     , nvl(e.SALARY * e.COMMISSION_PCT, 0) as "급여X커미션"
  FROM employees e
;
/*----------------------------------------------------------------
EMPLOYEE_ID,  LAST_NAME,  SALARY,   COMMISSION_PCT,   급여X커미션
------------------------------------------------------------------
100	          King	      24000	    0	                0
101         	Kochhar	    17000    	0               	0
102	          De Haan	    17000	    0	                0
103	          Hunold	    9000	    0	                0
104	          Ernst	      6000	    0	                0
105	          Austin	    4800	    0	                0
106	          Pataballa 	4800	    0	                0
107	          Lorentz	    4200    	0	                0
108	          Greenberg	  12008	    0	                0
109	          Faviet	    9000	    0	                0
110	          Chen	      8200	    0	                0
111	          Sciarra   	7700	    0	                0
112	          Urman	      7800	    0	                0
113	          Popp	      6900	    0	                0
114	          Raphaely  	11000   	0	                0
115	          Khoo	      3100	    0	                0
116	          Baida	      2900	    0	                0
117	          Tobias	    2800	    0	                0
118	          Himuro    	2600	    0	                0
119	          Colmenares	2500	    0	                0
120	          Weiss     	8000	    0	                0
121	          Fripp	      8200	    0	                0
122	          Kaufling  	7900	    0	                0
123	          Vollman    	6500	    0	                0
124	          Mourgos	    5800	    0	                0
125	          Nayer	      3200	    0	                0
126	          Mikkilineni	2700	    0	                0
127	          Landry	    2400	    0	                0
128	          Markle	    2200	    0	                0
129	          Bissot	    3300	    0	                0
130	          Atkinson	  2800	    0	                0
131	          Marlow	    2500	    0	                0
132	          Olson	      2100	    0	                0
133	          Mallin    	3300	    0	                0
134	          Rogers	    2900	    0	                0
135	          Gee	        2400	    0	                0
136	          Philtanker	2200	    0	                0
137	          Ladwig	    3600	    0	                0
138	          Stiles	    3200	    0	                0
139	          Seo	        2700     	0	                0
140	          Patel	      2500	    0	                0
141	          Rajs	      3500	    0	                0
142	          Davies	    3100	    0	                0
143	          Matos	      2600	    0	                0
144	          Vargas	    2500	    0	                0
145	          Russell	    14000	    0.4	              5600
146	          Partners	  13500	    0.3	              4050
147	          Errazuriz	  12000	    0.3	              3600
148	          Cambrault	  11000	    0.3	              3300
149	          Zlotkey 	  10500	    0.2	              2100
150	          Tucker	    10000	    0.3	              3000
151	          Bernstein 	9500	    0.25            	2375
152	          Hall      	9000	    0.25	            2250
153	          Olsen     	8000	    0.2	              1600
154	          Cambrault 	7500	    0.2	              1500
155	          Tuvault	    7000	    0.15	            1050
156	          King	      10000	    0.35	            3500
157	          Sully	      9500	    0.35	            3325
158	          McEwen    	9000	    0.35	            3150
159	          Smith     	8000	    0.3	              2400
160         	Doran	      7500	    0.3	              2250
161	          Sewall     	7000	    0.25	            1750
162	          Vishney	    10500	    0.25	            2625
163	          Greene	    9500	    0.15	            1425
164	          Marvins	    7200	    0.1	              720
165	          Lee       	6800	    0.1	              680
166	          Ande	      6400	    0.1	              640
167	          Banda	      6200	    0.1	              620
168	          Ozer	      11500	    0.25            	2875
169 	        Bloom	      10000	    0.2	              2000
170         	Fox	        9600	    0.2	              1920
171	          Smith	      7400	    0.15            	1110
172	          Bates	      7300	    0.15            	1095
173	          Kumar	      6100	    0.1	              610
174	          Abel	      11000	    0.3	              3300
175	          Hutton    	8800	    0.25            	2200
176	          Taylor    	8600	    0.2             	1720
177	          Livingston	8400	    0.2             	1680
178	          Grant	      7000	    0.15            	1050
179	          Johnson	    6200	    0.1	              620
180	          Taylor	    3200	    0	                0
181	          Fleaur	    3100	    0	                0
182	          Sullivan	  2500	    0	                0
183	          Geoni	      2800	    0	                0
184	          Sarchand  	4200	    0	                0
185	          Bull	      4100	    0	                0
186	          Dellinger 	3400	    0	                0
187	          Cabrio	    3000	    0	                0
188	          Chung	      3800	    0	                0
189	          Dilly	      3600	    0	                0
190	          Gates	      2900	    0	                0
191	          Perkins	    2500	    0	                0
192	          Bell	      4000	    0	                0
193	          Everett   	3900	    0	                0
194	          McCain    	3200	    0	                0
195	          Jones     	2800	    0	                0
196	          Walsh	      3100	    0	                0
197	          Feeney    	3000	    0	                0
198	          OConnell  	2600	    0	                0
199	          Grant	      2600	    0	                0
200	          Whalen	    4400	    0	                0
201	          Hartstein	  13000	    0	                0
202	          Fay	        6000	    0	                0
203	          Mavris	    6500	    0	                0
204         	Baer	      10000	    0	                0
205	          Higgins	    12008	    0	                0
--------------------------------------------------*/

--3. employees 테이블에서 사번, 라스트네임, 급여, 커미션 팩터(null 값 처리) 조회
--   단, 2007년 이 후 입사자에 대하여 조회, 고용년도 순 오름차순 정렬
--30건
SELECT e.EMPLOYEE_ID
     , e.LAST_NAME
     , e.SALARY
     , nvl(e.COMMISSION_PCT, 0) as "COMMISSION_PCT"
  FROM employees e
 WHERE TO_CHAR(e.HIRE_DATE, 'YYYY') >= 2007
 ORDER BY e.HIRE_DATE
;
/*---------------------------------------------
EMPLOYEE_ID, LAST_NAME, SALARY, COMMISSION_PCT
-----------------------------------------------
127          Landry	    2400	0
107        	 Lorentz	  4200	0
187	       	 Cabrio	    3000	0
171	       	 Smith	    7400	0.15
195	       	 Jones	    2800	0
163	       	 Greene	    9500	0.15
172	       	 Bates	    7300	0.15
132	       	 Olson	    2100	0
104	       	 Ernst	    6000	0
178	       	 Grant	    7000	0.15
198	       	 OConnell	  2600	0
182	       	 Sullivan	  2500	0
119	       	 Colmenares	2500	0
148	       	 Cambrault	11000	0.3
124	       	 Mourgos	  5800	0
155	       	 Tuvault	  7000	0.15
113	       	 Popp	      6900	0
135	       	 Gee	      2400	0
191	       	 Perkins	  2500	0
179	       	 Johnson	  6200	0.1
199	       	 Grant	    2600	0
164	       	 Marvins  	7200	0.1
149	       	 Zlotkey  	10500	0.2
183	       	 Geoni	    2800	0
136	       	 Philtanker	2200	0
165	       	 Lee	      6800	0.1
128	       	 Markle	    2200	0
166	       	 Ande     	6400	0.1
167	       	 Banda	    6200	0.1
173        	 Kumar	    6100	0.1
---------------------------------------*/

--4. Finance 부서에 소속된 직원의 목록 조회
--조인으로 해결
SELECT e.EMPLOYEE_ID
     , e.FIRST_NAME
     , e.LAST_NAME
     , d.DEPARTMENT_NAME
  FROM employees e JOIN departments d ON (e.DEPARTMENT_ID = d.DEPARTMENT_ID)
 WHERE d.DEPARTMENT_NAME = 'Finance'
;
/*--------------------------------------------------
EMPLOYEE_ID, FIRST_NAME,  LAST_NAME,    DEPARTMENT_NAME
----------------------------------------------------
108   	     Nancy	      Greenberg	    Finance
109	         Daniel	      Faviet	      Finance
110	         John	        Chen	        Finance
111	         Ismael	      Sciarra	      Finance
112	         Jose Manuel	Urman	        Finance
113	         Luis	        Popp	        Finance
---------------------------------------------------*/

--서브쿼리로 해결
-- a) 부서이름 Finance인 부서번호
SELECT d.DEPARTMENT_ID
  FROM departments d
 WHERE d.DEPARTMENT_NAME = 'Finance'
;

-- b)
SELECT e.EMPLOYEE_ID
     , e.FIRST_NAME
     , e.LAST_NAME
  FROM employees e
 WHERE e.DEPARTMENT_ID = (SELECT d.DEPARTMENT_ID
                            FROM departments d
                           WHERE d.DEPARTMENT_NAME = 'Finance')
;
/*---------------------------------------
EMPLOYEE_ID, FIRST_NAME,  LAST_NAME
-----------------------------------------
108          Nancy	      Greenberg
109	         Daniel	      Faviet
110	         John	        Chen
111	         Ismael       Sciarra
112	         Jose Manuel	Urman
113	         Luis	        Popp
----------------------------------------*/
--6건
 
--5. Steven King 의 직속 부하직원의 모든 정보를 조회
--14건
-- 조인 이용
SELECT e1.EMPLOYEE_ID
     , e1.FIRST_NAME
     , e1.EMAIL
     , e1.PHONE_NUMBER
     , e1.HIRE_DATE
     , e1.JOB_ID
     , e1.SALARY
     , e1.COMMISSION_PCT
     , e1.MANAGER_ID
     , e1.DEPARTMENT_ID
  FROM employees e1 JOIN employees e2 ON (e1.MANAGER_ID = e2.EMPLOYEE_ID)
 WHERE e2.FIRST_NAME = 'Steven'
   AND e2.LAST_NAME = 'King'
;
/*------------------------------------------------------------------------------------------------------------------
EMPLOYEE_ID, FIRST_NAME, EMAIL,   PHONE_NUMBER,       HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
--------------------------------------------------------------------------------------------------------------------
101	         Neena	     NKOCHHAR	515.123.4568	      05/09/21	  AD_VP	  17000		               100	        90
102	         Lex	       LDEHAAN	515.123.4569	      01/01/13	  AD_VP	  17000		               100	        90
114	         Den	       DRAPHEAL	515.127.4561	      02/12/07	  PU_MAN	11000		               100	        30
120	         Matthew	   MWEISS	  650.123.1234	      04/07/18	  ST_MAN	8000		               100	        50
121	         Adam	       AFRIPP	  650.123.2234	      05/04/10	  ST_MAN	8200		               100	        50
122	         Payam       PKAUFLIN	650.123.3234	      03/05/01	  ST_MAN	7900		               100	        50
123	         Shanta	     SVOLLMAN	650.123.4234	      05/10/10	  ST_MAN	6500		               100	        50
124	         Kevin	     KMOURGOS	650.123.5234	      07/11/16	  ST_MAN	5800		               100	        50
145	         John	       JRUSSEL	011.44.1344.429268	04/10/01	  SA_MAN	14000 	0.4	           100	        80
146	         Karen	     KPARTNER	011.44.1344.467268	05/01/05	  SA_MAN	13500	  0.3	           100	        80
147	         Alberto	   AERRAZUR	011.44.1344.429278	05/03/10	  SA_MAN	12000	  0.3	           100	        80
148	         Gerald	     GCAMBRAU	011.44.1344.619268	07/10/15	  SA_MAN	11000	  0.3	           100	        80
149	         Eleni	     EZLOTKEY	011.44.1344.429018	08/01/29	  SA_MAN	10500	  0.2	           100	        80
201	         Michael	   MHARTSTE	515.123.5555	      04/02/17	  MK_MAN	13000		               100	        20
-------------------------------------------------------------------------------------------------------------------*/
-- 서브쿼리 이용
SELECT *
  FROM employees e1
 WHERE e1.MANAGER_ID = (SELECT e2.EMPLOYEE_ID
                          FROM employees e2
                         WHERE e2.FIRST_NAME = 'Steven'
                           AND e2.LAST_NAME = 'King')
;
/*------------------------------------------------------------------------------------------------------------------
EMPLOYEE_ID, FIRST_NAME, EMAIL,   PHONE_NUMBER,       HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID
--------------------------------------------------------------------------------------------------------------------
101	         Neena	     NKOCHHAR	515.123.4568	      05/09/21	  AD_VP	  17000		               100	        90
102	         Lex	       LDEHAAN	515.123.4569	      01/01/13	  AD_VP	  17000		               100	        90
114	         Den	       DRAPHEAL	515.127.4561	      02/12/07	  PU_MAN	11000		               100	        30
120	         Matthew	   MWEISS	  650.123.1234	      04/07/18	  ST_MAN	8000		               100	        50
121	         Adam	       AFRIPP	  650.123.2234	      05/04/10	  ST_MAN	8200		               100	        50
122	         Payam       PKAUFLIN	650.123.3234	      03/05/01	  ST_MAN	7900		               100	        50
123	         Shanta	     SVOLLMAN	650.123.4234	      05/10/10	  ST_MAN	6500		               100	        50
124	         Kevin	     KMOURGOS	650.123.5234	      07/11/16	  ST_MAN	5800		               100	        50
145	         John	       JRUSSEL	011.44.1344.429268	04/10/01	  SA_MAN	14000 	0.4	           100	        80
146	         Karen	     KPARTNER	011.44.1344.467268	05/01/05	  SA_MAN	13500	  0.3	           100	        80
147	         Alberto	   AERRAZUR	011.44.1344.429278	05/03/10	  SA_MAN	12000	  0.3	           100	        80
148	         Gerald	     GCAMBRAU	011.44.1344.619268	07/10/15	  SA_MAN	11000	  0.3	           100	        80
149	         Eleni	     EZLOTKEY	011.44.1344.429018	08/01/29	  SA_MAN	10500	  0.2	           100	        80
201	         Michael	   MHARTSTE	515.123.5555	      04/02/17	  MK_MAN	13000		               100	        20
-------------------------------------------------------------------------------------------------------------------*/
 
--6. Steven King의 직속 부하직원 중에서 Commission_pct 값이 null이 아닌 직원 목록
--5건
SELECT e1.EMPLOYEE_ID
     , e1.FIRST_NAME
     , e1.LAST_NAME
  FROM employees e1
 WHERE e1.MANAGER_ID = (SELECT e2.EMPLOYEE_ID
                          FROM employees e2
                         WHERE e2.FIRST_NAME = 'Steven'
                           AND e2.LAST_NAME = 'King')
   AND e1.COMMISSION_PCT IS NOT NULL
;
/*-----------------------------------
EMPLOYEE_ID, FIRST_NAME, LAST_NAME
145       	 John	       Russell	  
146	       	 Karen	     Partners	  
147	      	 Alberto	   Errazuriz	
148	      	 Gerald    	 Cambrault	
149	      	 Eleni	     Zlotkey	  
-------------------------------------*/

--7. 각 job 별 최대급여를 구하여 출력 job_id, job_title, job별 최대급여 조회
--19건
SELECT e.JOB_ID
     , j.JOB_TITLE
     , MAX(e.SALARY) as "최대 급여"
  FROM employees e JOIN jobs j ON (e.JOB_ID = j.JOB_ID)
 GROUP BY e.JOB_ID
        , j.JOB_TITLE
;
/*-----------------------------------------------------
JOB_ID,     JOB_TITLE,                      최대 급여
-------------------------------------------------------
AD_ASST	    Administration Assistant	      4400
IT_PROG	    Programmer	                    9000
MK_MAN	    Marketing Manager	              13000
SA_REP	    Sales Representative        	  11500
AC_MGR	    Accounting Manager	            12008
AC_ACCOUNT	Public Accountant	              8300
FI_MGR	    Finance Manager             	  12008
PU_MAN	    Purchasing Manager      	      11000
SH_CLERK	  Shipping Clerk	                4200
FI_ACCOUNT	Accountant	                    9000
AD_PRES	    President	                      24000
MK_REP	    Marketing Representative	      6000
SA_MAN	    Sales Manager	                  14000
AD_VP	      Administration Vice President	  17000
PU_CLERK	  Purchasing Clerk	              3100
ST_CLERK	  Stock Clerk	                    3600
ST_MAN	    Stock Manager           	      8200
HR_REP	    Human Resources Representative	6500
PR_REP	    Public Relations Representative	10000
------------------------------------------------------*/
SELECT j.JOB_ID
     , j.JOB_TITLE
     , j.MAX_SALARY
  FROM jobs j
;
/*-----------------------------------------------------------
JOB_ID,           JOB_TITLE,                      MAX_SALARY
AD_PRES	          President	                      40000
AD_VP	            Administration Vice President	  30000
AD_ASST	          Administration Assistant	      6000
FI_MGR	          Finance Manager	                16000
FI_ACCOUNT	      Accountant	                    9000
AC_MGR	          Accounting Manager	            16000
AC_ACCOUNT	      Public Accountant	              9000
SA_MAN	          Sales Manager	                  20080
SA_REP	          Sales Representative	          12008
PU_MAN	          Purchasing Manager	            15000
PU_CLERK	        Purchasing Clerk	              5500
ST_MAN	          Stock Manager	                  8500
ST_CLERK	        Stock Clerk	                    5000
SH_CLERK	        Shipping Clerk	                5500
IT_PROG	          Programmer	                    10000
MK_MAN	          Marketing Manager	              15000
MK_REP	          Marketing Representative	      9000
HR_REP	          Human Resources Representative	9000
PR_REP	          Public Relations Representative	10500
--------------------------------------------------------------*/
 
--8. 각 Job 별 최대급여를 받는 사람의 정보를 출력,
--  급여가 높은 순서로 출력
----서브쿼리 이용
-- a)
SELECT e.JOB_ID
     , MAX(e.SALARY)
  FROM employees e
 GROUP BY e.JOB_ID
;

-- b)
SELECT e.JOB_ID
     , e.FIRST_NAME
     , e.LAST_NAME
     , e.SALARY
  FROM employees e
 WHERE (e.JOB_ID, e.SALARY) IN (SELECT e.JOB_ID
                                     , MAX(e.SALARY)
                                  FROM employees e
                                 GROUP BY e.JOB_ID)
 ORDER BY e.SALARY DESC                                 
;

----join 이용
SELECT e1.JOB_ID
     , e1.FIRST_NAME
     , e1.LAST_NAME
     , e1.SALARY
  FROM employees e1 JOIN (SELECT e.JOB_ID
                                     , MAX(e.SALARY) as "최대 급여"
                                  FROM employees e
                                 GROUP BY e.JOB_ID) e2
                      ON e1.JOB_ID = e2.JOB_ID
 WHERE e1.SALARY = e2."최대 급여"
 ORDER BY e1.SALARY DESC                      
;

--20건
/*-------------------------------------------
JOB_ID,     FIRST_NAME,   LAST_NAME,  SALARY
---------------------------------------------
AD_PRES	    Steven	      King	      24000
AD_VP	      Neena	        Kochhar	    17000
AD_VP	      Lex	          De Haan	    17000
SA_MAN	    John	        Russell	    14000
MK_MAN	    Michael	      Hartstein	  13000
FI_MGR	    Nancy	        Greenberg	  12008
AC_MGR	    Shelley	      Higgins	    12008
SA_REP	    Lisa	        Ozer	      11500
PU_MAN	    Den	          Raphaely	  11000
PR_REP	    Hermann	      Baer	      10000
IT_PROG	    Alexander 	  Hunold	    9000
FI_ACCOUNT	Daniel	      Faviet	    9000
AC_ACCOUNT	William	      Gietz	      8300
ST_MAN	    Adam	        Fripp	      8200
HR_REP	    Susan	        Mavris	    6500
MK_REP	    Pat	          Fay	        6000
AD_ASST	    Jennifer	    Whalen	    4400
SH_CLERK	  Nandita	      Sarchand	  4200
ST_CLERK	  Renske	      Ladwig	    3600
PU_CLERK	  Alexander	    Khoo	      3100
-------------------------------------------*/

--9. 7번 출력시 job_id 대신 Job_name, manager_id 대신 Manager의 last_name, department_id 대신 department_name 으로 출력
--20건
-- 직무별 최대급여를 받는 사람의 직무, 이름, 상사이름, 부서이름, 급여 
SELECT j.JOB_TITLE        as "직무"
     , e.FIRST_NAME       as "이름"
     , e1.FIRST_NAME      as "상사이름"
     , d.DEPARTMENT_NAME  as "부서이름"
     , e.SALARY           as "급여"
  FROM employees e JOIN jobs j ON (e.JOB_ID = j.JOB_ID)
                   LEFT OUTER JOIN employees e1 ON (e.MANAGER_ID = e1.EMPLOYEE_ID)
                   JOIN DEPARTMENTS d ON (e.DEPARTMENT_ID = d.DEPARTMENT_ID)
 WHERE (e.JOB_ID, e.SALARY) IN (SELECT e.JOB_ID
                                     , MAX(e.SALARY)
                                  FROM employees e
                                 GROUP BY e.JOB_ID)
;
/*----------------------------------------------------------------------------------
직무,                           이름,         상사이름,     부서이름,         급여
------------------------------------------------------------------------------------
Programmer	                    Alexander	    Lex	          IT	              9000
Accounting Manager	            Shelley	      Neena	        Accounting	      12008
Public Accountant	              William	      Shelley	      Accounting	      8300
Stock Manager	                  Adam	        Steven	      Shipping	        8200
Purchasing Manager	            Den	          Steven	      Purchasing	      11000
Administration Assistant	      Jennifer	    Neena	        Administration	  4400
Administration Vice President	  Neena	        Steven	      Executive	        17000
Administration Vice President	  Lex	          Steven	      Executive	        17000
Shipping Clerk	                Nandita	      Adam	        Shipping	        4200
Accountant	                    Daniel	      Nancy	        Finance         	9000
Finance Manager	                Nancy	        Neena	        Finance	          12008
Purchasing Clerk	              Alexander	    Den	          Purchasing	      3100
Sales Manager	                  John	        Steven	      Sales	            14000
Marketing Manager	              Michael	      Steven	      Marketing	        13000
Public Relations Representative	Hermann	      Neena	        Public Relations	10000
President	                      Steven		                  Executive	        24000
Sales Representative	          Lisa	        Gerald	      Sales	            11500
Marketing Representative	      Pat	          Michael     	Marketing	        6000
Stock Clerk	                    Renske	      Shanta	      Shipping	        3600
Human Resources Representative	Susan	        Neena	        Human Resources	  6500
------------------------------------------------------------------------------------*/

--10. 전체 직원의 급여 평균을 구하여 출력
SELECT AVG(e.SALARY) as "급여 평균"
  FROM employees e
;
/*----------------------------------------
6461.831775700934579439252336448598130841
----------------------------------------*/

--11. 전체 직원의 급여 평균보다 높은 급여를 받는 사람의 목록 출력. 급여 오름차순 정렬
--51건
SELECT e.EMPLOYEE_ID
     , e.FIRST_NAME
     , e.LAST_NAME
     , e.SALARY     as "급여"
  FROM employees e
 WHERE e.SALARY > (SELECT AVG(e.SALARY)
                     FROM employees e)
 ORDER BY "급여"
;
/*------------------------------------------------
EMPLOYEE_ID, FIRST_NAME,  LAST_NAME,      급여
203	         Susan	      Mavris	        6500
123	         Shanta	       Vollman	      6500
165	         David	      Lee	            6800
113	         Luis	        Popp	          6900
155	         Oliver	      Tuvault	        7000
161	         Sarath	      Sewall	        7000
178	         Kimberely	  Grant	          7000
164	         Mattea	      Marvins	        7200
172	         Elizabeth	  Bates	          7300
171	         William	    Smith	          7400
154	         Nanette	    Cambrault	      7500
160	         Louise	      Doran	          7500
111	         Ismael	      Sciarra	        7700
112	         Jose         Manuel	Urman	  7800
122	         Payam	      Kaufling	      7900
120	         Matthew	    Weiss	          8000
159	         Lindsey	    Smith	          8000
153	         Christopher	Olsen	          8000
121	         Adam	        Fripp	          8200
110	         John	        Chen	          8200
206	         William	    Gietz	          8300
177	         Jack	        Livingston	    8400
176	         Jonathon	    Taylor	        8600
175	         Alyssa	      Hutton	        8800
158	         Allan	      McEwen	        9000
152	         Peter	      Hall	          9000
109	         Daniel	      Faviet	        9000
103	         Alexander	  Hunold	        9000
157	         Patrick	    Sully	          9500
151	         David	      Bernstein	      9500
163	         Danielle	    Greene	        9500
170	         Tayler	      Fox	            9600
156	         Janette	    King	          10000
150	         Peter	      Tucker	        10000
204	         Hermann	    Baer	          10000
169	         Harrison	    Bloom	          10000
149	         Eleni	      Zlotkey	        10500
162	         Clara	      Vishney	        10500
174	         Ellen	      Abel	          11000
148	         Gerald	      Cambrault	      11000
114	         Den	        Raphaely	      11000
168	         Lisa	        Ozer	          11500
147	         Alberto	    Errazuriz	      12000
108	         Nancy	      Greenberg	      12008
205	         Shelley	    Higgins	        12008
201	         Michael	    Hartstein	      13000
146	         Karen	      Partners	      13500
145	         John	        Russell	        14000
102	         Lex	        De Haan	        17000
101	         Neena	      Kochhar	        17000
100	         Steven	      King	          24000
----------------------------------------------*/

--12. 각 부서별 평균 급여를 구하여 출력
--12건
SELECT e.DEPARTMENT_ID
     , AVG(e.SALARY)    as "평균 급여"
  FROM employees e
 GROUP BY e.DEPARTMENT_ID
;
/*-------------------------------------------------
DEPARTMENT_ID,  평균 급여
100	            8601.333333333333333333333333333333333333
30	            4150
                7000
90	            19333.3333333333333333333333333333333333
20	            9500
70	            10000
110	            10154
50	            3475.555555555555555555555555555555555556
80	            8955.882352941176470588235294117647058824
40	            6500
60	            5760
10	            4400
-------------------------------------------------*/

--13. 12번의 결과에 department_name 같이 출력
--12건
SELECT e.DEPARTMENT_ID
     , d.DEPARTMENT_NAME
     , AVG(e.SALARY)    as "평균 급여"
  FROM employees e LEFT OUTER JOIN departments d ON (e.DEPARTMENT_ID = d.DEPARTMENT_ID)
 GROUP BY e.DEPARTMENT_ID
        , d.DEPARTMENT_NAME
;
/*------------------------------------------------------------------------
DEPARTMENT_ID, DEPARTMENT_NAME, 평균 급여
100	           Finance	        8601.333333333333333333333333333333333333
                                7000
50	           Shipping	        3475.555555555555555555555555555555555556
70	           Public Relations	10000
30	           Purchasing	      4150
90	           Executive	      19333.3333333333333333333333333333333333
10	           Administration 	4400
110	           Accounting	      10154
40	           Human Resources	6500
20	           Marketing	      9500
60	           IT	              5760
80	           Sales	          8955.882352941176470588235294117647058824
-------------------------------------------------------------------------*/

--14. employees 테이블이 각 job_id 별 인원수와 job_title을 같이 출력하고 job_id 오름차순 정렬
-- 19건
SELECT e.JOB_ID
     , j.JOB_TITLE
     , COUNT(*)   as "인원 수"
  FROM employees e RIGHT JOIN JOBS j ON (e.JOB_ID = j.JOB_ID)
 GROUP BY e.JOB_ID
        , j.JOB_TITLE
 ORDER BY e.JOB_ID
;
/*---------------------------------------------------
JOB_ID,     JOB_TITLE,                      인원 수
-----------------------------------------------------------
AC_ACCOUNT	Public Accountant	              1
AC_MGR	    Accounting Manager	            1
AD_ASST	    Administration Assistant	      1
AD_PRES	    President	                      1
AD_VP	      Administration Vice President	  2
FI_ACCOUNT	Accountant	                    5
FI_MGR	    Finance Manager	                1
HR_REP    	Human Resources Representative	1
IT_PROG	    Programmer	                    5
MK_MAN	    Marketing Manager	              1
MK_REP	    Marketing Representative	      1
PR_REP	    Public Relations Representative	1
PU_CLERK	  Purchasing Clerk	              5
PU_MAN	    Purchasing Manager	            1
SA_MAN	    Sales Manager 	                5
SA_REP	    Sales Representative	          30
SH_CLERK	  Shipping Clerk	                20
ST_CLERK	  Stock Clerk	                    20
ST_MAN	    Stock Manager	                  5
-----------------------------------------------------*/

--15. employees 테이블의 job_id별 최저급여,
--   최대급여를 job_title과 함께 출력 job_id 알파벳순 오름차순 정렬
-- 19건
SELECT e.JOB_ID
     , j.JOB_TITLE
     , MAX(e.SALARY) as "최대 급여"
     , MIN(e.SALARY) as "최저 급여"
  FROM employees e JOIN jobs j ON (e.JOB_ID = j.JOB_ID)
 GROUP BY e.JOB_ID
        , j.JOB_TITLE
;
/*-----------------------------------------------------------------
JOB_ID,     JOB_TITLE,                      최대 급여,  최저 급여
AD_ASST	    Administration Assistant	      4400	      4400
IT_PROG	    Programmer	                    9000	      4200
MK_MAN	    Marketing Manager	              13000	      13000
SA_REP	    Sales Representative	          11500     	6100
AC_MGR	    Accounting Manager	            12008	      12008
AC_ACCOUNT	Public Accountant	              8300	      8300
FI_MGR	    Finance Manager	                12008	      12008
PU_MAN	    Purchasing Manager	            11000	      11000
SH_CLERK	  Shipping Clerk	                4200	      2500
FI_ACCOUNT	Accountant	                    9000	      6900
AD_PRES	    President	                      24000	      24000
MK_REP	    Marketing Representative	      6000	      6000
SA_MAN	    Sales Manager	                  14000	      10500
AD_VP	      Administration Vice President	  17000	      17000
PU_CLERK	  Purchasing Clerk	              3100	      2500
ST_CLERK	  Stock Clerk	                    3600	      2100
ST_MAN	    Stock Manager   	              8200	      5800
HR_REP	    Human Resources Representative	6500	      6500
PR_REP	    Public Relations Representative	10000	      10000
------------------------------------------------------------------*/
 
--16. Employees 테이블에서 인원수가 가장 많은 job_id를 구하고
--   해당 job_id 의 job_title 과 그 때 직원의 인원수를 같이 출력
-- a)
SELECT e.JOB_ID
     , COUNT(e.JOB_ID) as "인원 수"
  FROM employees e
 GROUP BY e.JOB_ID
 ORDER BY "인원 수" DESC
;

--b)
SELECT e.JOB_ID
     , j.JOB_TITLE
     , e."인원 수"
  FROM (SELECT e.JOB_ID
       , COUNT(e.JOB_ID) as "인원 수"
          FROM employees e
         GROUP BY e.JOB_ID
         ORDER BY "인원 수" DESC) e JOIN jobs j ON e.JOB_ID = j.JOB_ID
 WHERE ROWNUM = 1
;
/*-------------------------------------
JOB_ID, JOB_TITLE,            인원 수
---------------------------------------
SA_REP	Sales Representative	30
--------------------------------------*/

--17.사번,last_name, 급여, 직책이름(job_title), 부서명(department_name), 부서매니저이름
--  부서 위치 도시(city), 나라(country_name), 지역(region_name) 을 출력
----------- 부서가 배정되지 않은 인원 고려 ------
-- 107건
SELECT e.EMPLOYEE_ID      as "사번"
     , e.LAST_NAME        as "last_name"
     , e.SALARY           as "급여"
     , j.JOB_TITLE        as "직책이름"
     , d.DEPARTMENT_NAME  as "부서명"
     , e1.FIRST_NAME      as "부서 매니저이름"
     , l.CITY             as "부서 위치 도시"
     , c.COUNTRY_NAME     as "나라"
     , r.REGION_NAME      as "지역"
  FROM employees e LEFT OUTER JOIN jobs j        ON (e.JOB_ID = j.JOB_ID)
                   LEFT OUTER JOIN departments d ON (e.DEPARTMENT_ID = d.DEPARTMENT_ID)
                   LEFT OUTER JOIN locations l   ON (d.LOCATION_ID = l.LOCATION_ID)
                   LEFT OUTER JOIN countries c   ON (l.COUNTRY_ID = c.COUNTRY_ID)
                   LEFT OUTER JOIN regions r     ON (c.REGION_ID = r.REGION_ID)
                   LEFT OUTER JOIN employees e1  ON (e.MANAGER_ID = e1.EMPLOYEE_ID)
;
/*----------------------------------------------------------------------------------------------------------------------------------------------------------------
last_name,  급여,   직책이름,                             부서명,                       부서 매니저이름,    부서 위치 도시,     나라,                     지역
Ozer	      11500	  Sales Representative	                Sales	                        Gerald	            Oxford	            United Kingdom	          Europe
Bloom	      10000	  Sales Representative	                Sales	                        Gerald	            Oxford	            United Kingdom	          Europe
Fox	        9600	  Sales Representative	                Sales	                        Gerald	            Oxford	            United Kingdom	          Europe
Smith	      7400	  Sales Representative	                Sales	                        Gerald	            Oxford	            United Kingdom	          Europe
Bates	      7300	  Sales Representative	                Sales	                        Gerald	            Oxford	            United Kingdom	          Europe
Kumar	      6100	  Sales Representative	                Sales	                        Gerald	            Oxford	            United Kingdom	          Europe
Hunold	    9000	  Programmer	                          IT	                          Lex	                Southlake	          United States of America	Americas
Vishney	    10500	  Sales Representative	                Sales	                        Alberto	            Oxford	            United Kingdom	          Europe
Greene	    9500	  Sales Representative	                Sales	                        Alberto	            Oxford	            United Kingdom	          Europe
Marvins	    7200	  Sales Representative	                Sales	                        Alberto	            Oxford	            United Kingdom	          Europe
Lee	        6800	  Sales Representative	                Sales	                        Alberto	            Oxford	            United Kingdom	          Europe
Ande	      6400	  Sales Representative	                Sales	                        Alberto	            Oxford	            United Kingdom	          Europe
Banda	      6200	  Sales Representative	                Sales	                        Alberto	            Oxford	            United Kingdom	          Europe
Sarchand	  4200	  Shipping Clerk	                      Shipping	                    Adam	              South San Francisco	United States of America	Americas
Bull	      4100	  Shipping Clerk	                      Shipping	                    Adam	              South San Francisco	United States of America	Americas
Dellinger	  3400	  Shipping Clerk	                      Shipping	                    Adam	              South San Francisco	United States of America	Americas
Cabrio	    3000	  Shipping Clerk	                      Shipping	                    Adam	              South San Francisco	United States of America	Americas
Bissot	    3300	  Stock Clerk	                          Shipping	                    Adam	              South San Francisco	United States of America	Americas
Atkinson	  2800	  Stock Clerk	                          Shipping	                    Adam	              South San Francisco	United States of America	Americas
Marlow	    2500	  Stock Clerk     	                    Shipping	                    Adam	              South San Francisco	United States of America	Americas
Olson	      2100	  Stock Clerk	                          Shipping	                    Adam	              South San Francisco	United States of America	Americas
Faviet	    9000	  Accountant	                          Finance	                      Nancy	              Seattle	            United States of America	Americas
Chen	      8200	  Accountant	                          Finance 	                    Nancy     	        Seattle	            United States of America	Americas
Sciarra	    7700	  Accountant	                          Finance	                      Nancy	              Seattle	            United States of America	Americas
Urman	      7800	  Accountant	                          Finance	                      Nancy	              Seattle	            United States of America	Americas
Popp	      6900	  Accountant	                          Finance	                      Nancy	              Seattle	            United States of America	Americas
Fay	        6000	  Marketing Representative	            Marketing	                    Michael	            Toronto	            Canada	                  Americas
Gietz	      8300	  Public Accountant	                    Accounting	                  Shelley	            Seattle	            United States of America	Americas
Ernst	      6000	  Programmer	                          IT	                          Alexander	          Southlake	          United States of America	Americas
Austin	    4800	  Programmer	                          IT	                          Alexander	          Southlake	          United States of America	Americas
Pataballa	  4800	  Programmer	                          IT	                          Alexander	          Southlake	          United States of America	Americas
Lorentz	    4200	  Programmer	                          IT	                          Alexander	          Southlake	          United States of America	Americas
Chung	      3800	  Shipping Clerk	                      Shipping	                    Payam	              South San Francisco	United States of America	Americas
Dilly	      3600	  Shipping Clerk	                      Shipping	                    Payam	              South San Francisco	United States of America	Americas
Gates	      2900	  Shipping Clerk	                      Shipping	                    Payam	              South San Francisco	United States of America	Americas
Perkins	    2500	  Shipping Clerk	                      Shipping	                    Payam	              South San Francisco	United States of America	Americas
Mallin	    3300	  Stock Clerk	                          Shipping	                    Payam	              South San Francisco	United States of America	Americas
Rogers	    2900	  Stock Clerk	                          Shipping	                    Payam	              South San Francisco	United States of America	Americas
Gee	        2400	  Stock Clerk	                          Shipping	                    Payam	              South San Francisco	United States of America	Americas
Philtanker	2200	  Stock Clerk	                          Shipping	                    Payam	              South San Francisco	United States of America	Americas
Hartstein	  13000	  Marketing Manager	                    Marketing	                    Steven	            Toronto	            Canada	                  Americas
Weiss	      8000	  Stock Manager	                        Shipping	                    Steven	            South San Francisco	United States of America	Americas
Fripp	      8200	  Stock Manager	                        Shipping	                    Steven	            South San Francisco	United States of America	Americas
Kaufling	  7900	  Stock Manager	                        Shipping	                    Steven	            South San Francisco	United States of America	Americas
Vollman	    6500	  Stock Manager	                        Shipping	                    Steven	            South San Francisco	United States of America	Americas
Mourgos	    5800	  Stock Manager	                        Shipping	                    Steven	            South San Francisco	United States of America	Americas
Raphaely	  11000	  Purchasing Manager	                  Purchasing	                  Steven	            Seattle	            United States of America	Americas
Russell	    14000	  Sales Manager	                        Sales	                        Steven	            Oxford	            United Kingdom	          Europe
Partners	  13500	  Sales Manager	                        Sales	                        Steven	            Oxford	            United Kingdom	          Europe
Errazuriz	  12000	  Sales Manager	                        Sales	                        Steven	            Oxford	            United Kingdom	          Europe
Cambrault	  11000	  Sales Manager	                        Sales	                        Steven	            Oxford	            United Kingdom	          Europe
Zlotkey	    10500	  Sales Manager	                        Sales	                        Steven	            Oxford	            United Kingdom	          Europe
Kochhar	    17000	  Administration Vice President	        Executive	                    Steven	            Seattle	            United States of America	Americas
De Haan	    17000	  Administration Vice President	        Executive	                    Steven	            Seattle	            United States of America	Americas
Baer	      10000	  Public Relations Representative	      Public Relations	            Neena	              Munich	            Germany	                  Europe
Mavris	    6500	  Human Resources Representative	      Human Resources	              Neena	              London	            United Kingdom	          Europe
Higgins	    12008	  Accounting Manager	                  Accounting	                  Neena	              Seattle	            United States of America	Americas
Greenberg	  12008	  Finance Manager	                      Finance	                      Neena	              Seattle	            United States of America	Americas
Whalen	    4400	  Administration                        Assistant	Administration	    Neena	              Seattle	            United States of America	Americas
Walsh	      3100	  Shipping Clerk	                      Shipping	                    Kevin	              South San Francisco	United States of America	Americas
Feeney	    3000	  Shipping Clerk	                      Shipping	                    Kevin	              South San Francisco	United States of America	Americas
OConnell	  2600	  Shipping Clerk	                      Shipping	                    Kevin	              South San Francisco	United States of America	Americas
Grant	      2600	  Shipping Clerk	                      Shipping	                    Kevin	              South San Francisco	United States of America	Americas
Rajs	      3500	  Stock Clerk	                          Shipping	                    Kevin	              South San Francisco	United States of America	Americas
Davies	    3100	  Stock Clerk         	                Shipping	                    Kevin	              South San Francisco	United States of America	Americas
Matos	      2600	  Stock Clerk	                          Shipping	                    Kevin	              South San Francisco	United States of America	Americas
Vargas	    2500	  Stock Clerk         	                Shipping	                    Kevin	              South San Francisco	United States of America	Americas
King	      10000	  Sales Representative	                Sales	                        Karen	              Oxford	            United Kingdom	          Europe
Sully	      9500	  Sales Representative	                Sales	                        Karen	              Oxford	            United Kingdom	          Europe
McEwen	    9000	  Sales Representative	                Sales	                        Karen	              Oxford	            United Kingdom	          Europe
Smith	      8000	  Sales Representative	                Sales	                        Karen	              Oxford	            United Kingdom	          Europe
Doran	      7500	  Sales Representative	                Sales	                        Karen	              Oxford	            United Kingdom	          Europe
Sewall	    7000	  Sales Representative	                Sales	                        Karen	              Oxford	            United Kingdom	          Europe
Khoo	      3100	  Purchasing Clerk	                    Purchasing	                  Den	                Seattle	            United States of America	Americas
Baida	      2900	  Purchasing Clerk	                    Purchasing	                  Den	                Seattle	            United States of America	Americas
Tobias	    2800	  Purchasing Clerk	                    Purchasing	                  Den	                Seattle	            United States of America	Americas
Himuro	    2600	  Purchasing Clerk	                    Purchasing	                  Den	                Seattle	            United States of America	Americas
Colmenares	2500	  Purchasing Clerk	                    Purchasing	                  Den	                Seattle	            United States of America	Americas
Tucker	    10000	  Sales Representative	                Sales	John	                                      Oxford	            United Kingdom	          Europe
Bernstein	  9500	  Sales Representative	                Sales	John	                                      Oxford	            United Kingdom	          Europe
Hall	      9000	  Sales Representative	                Sales	John	                                      Oxford	            United Kingdom	          Europe
Olsen	      8000	  Sales Representative	                Sales	John	                                      Oxford	            United Kingdom	          Europe
Cambrault	  7500	  Sales Representative	                Sales	John	                                      Oxford	            United Kingdom	          Europe
Tuvault	    7000	  Sales Representative	                Sales	John	                                      Oxford	            United Kingdom	          Europe
Bell	      4000	  Shipping Clerk	                      Shipping	                    Shanta	            South San Francisco	United States of America	Americas
Everett	    3900	  Shipping Clerk	                      Shipping	                    Shanta	            South San Francisco	United States of America	Americas
McCain	    3200	  Shipping Clerk	                      Shipping	                    Shanta	            South San Francisco	United States of America	Americas
Jones	      2800	  Shipping Clerk	                      Shipping	                    Shanta	            South San Francisco	United States of America	Americas
Ladwig	    3600	  Stock Clerk	                          Shipping	                    Shanta	            South San Francisco	United States of America	Americas
Stiles	    3200	  Stock Clerk	                          Shipping	                    Shanta	            South San Francisco	United States of America	Americas
Seo	        2700	  Stock Clerk	                          Shipping	                    Shanta	            South San Francisco	United States of America	Americas
Patel	      2500	  Stock Clerk	                          Shipping	                    Shanta	            South San Francisco	United States of America	Americas
Taylor	    3200	  Shipping Clerk	                      Shipping	                    Matthew	            South San Francisco	United States of America	Americas
Fleaur	    3100	  Shipping Clerk	                      Shipping	                    Matthew	            South San Francisco	United States of America	Americas
Sullivan	  2500	  Shipping Clerk	                      Shipping	                    Matthew	            South San Francisco	United States of America	Americas
Geoni	      2800	  Shipping Clerk	                      Shipping	                    Matthew	            South San Francisco	United States of America	Americas
Nayer	      3200	  Stock Clerk 	                        Shipping	                    Matthew	            South San Francisco	United States of America	Americas
Mikkilineni	2700	  Stock Clerk	                          Shipping	                    Matthew	            South San Francisco	United States of America	Americas
Landry	    2400	  Stock Clerk	                          Shipping	                    Matthew	            South San Francisco	United States of America	Americas
Markle	    2200	  Stock Clerk	                          Shipping	                    Matthew	            South San Francisco	United States of America	Americas
Abel	      11000	  Sales Representative	                Sales	                        Eleni	              Oxford	            United Kingdom	          Europe
Hutton	    8800	  Sales Representative	                Sales	                        Eleni	              Oxford	            United Kingdom	          Europe
Taylor	    8600	  Sales Representative	                Sales	                        Eleni	              Oxford	            United Kingdom	          Europe
Livingston	8400	  Sales Representative	                Sales	                        Eleni	              Oxford	            United Kingdom	          Europe
Grant	      7000	  Sales Representative		                                            Eleni			
Johnson	    6200	  Sales Representative	                Sales	                        Eleni	              Oxford	            United Kingdom	          Europe
King	      24000	  President	                            Executive		                                      Seattle	            United States of America	Americas
-----------------------------------------------------------------------------------------------------------------------------------------------------------------*/

--18.부서 아이디, 부서명, 부서에 속한 인원숫자를 출력
-- 27건
SELECT d.DEPARTMENT_ID
     , d.DEPARTMENT_NAME
     , (SELECT COUNT(*)
          FROM employees e
         WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
         GROUP BY e.DEPARTMENT_ID) as "인원 수"
  FROM departments d
;
/*----------------------------------------
DEPARTMENT_ID,  DEPARTMENT_NAME,  인원 수
------------------------------------------
10	            Administration	  1
20	            Marketing	        2
30	            Purchasing	      6
40	            Human Resources	  1
50	            Shipping	        45
60	            IT	              5
70	            Public Relations	1
80	            Sales	            34
90	            Executive	        3
100	            Finance	          6
110	            Accounting	      2
120	            Treasury	
130	            Corporate Tax	
140	            Control And Credit	
150	            Shareholder Services	
160	            Benefits	
170	            Manufacturing	
180	            Construction	
190	            Contracting	
200	            Operations	
210	            IT Support	
220	            NOC	
230	            IT Helpdesk	
240	            Government Sales	
250	            Retail Sales	
260	            Recruiting	
270	            Payroll	
--------------------------------------*/

--19.인원이 가장 많은 상위 다섯 부서아이디, 부서명, 인원수 목록 출력
-- 5건
-- a)
SELECT d.DEPARTMENT_ID
     , d.DEPARTMENT_NAME
     , (SELECT COUNT(*)
          FROM employees e
         WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
         GROUP BY e.DEPARTMENT_ID) as "인원 수"
  FROM departments d 
 ORDER BY "인원 수" DESC
;
-- b)
SELECT a.*
  FROM (SELECT d.DEPARTMENT_ID
             , d.DEPARTMENT_NAME
             , (SELECT COUNT(*)
                  FROM employees e
                 WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
                 GROUP BY e.DEPARTMENT_ID) as "인원 수"
          FROM departments d 
         ORDER BY "인원 수" DESC) a
 WHERE a."인원 수" IS NOT NULL
   AND ROWNUM <= 5
;
/*--------------------------------------
DEPARTMENT_ID, DEPARTMENT_NAME, 인원 수
----------------------------------------
50	           Shipping	        45
80	           Sales	          34
30	           Purchasing	      6
100	           Finance	        6
60	           IT	              5
--------------------------------------*/
 
--20. 부서별, 직책별 평균 급여를 구하여라.
--   부서이름, 직책이름, 평균급여 소수점 둘째자리에서 반올림으로 구하여라.
-- 19건

SELECT d.DEPARTMENT_NAME as "부서이름"
     , j.JOB_TITLE       as "직책이름"
     , TO_CHAR(AVG(e.SALARY), '$9,999,999.00') as "평균급여"
  FROM employees e JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
                   JOIN jobs j ON e.JOB_ID = j.JOB_ID
 GROUP BY d.DEPARTMENT_NAME
        , j.JOB_TITLE
;
/*------------------------------------------------------------------------------
부서이름,                   직책이름,                       평균급여
Administration	            Administration Assistant	      $4,400.00
Shipping	                  Stock Manager	                  $7,280.00
Accounting	                Public Accountant	              $8,300.00
Marketing	                  Marketing Manager	              $13,000.00
Finance                    	Finance Manager	                $12,008.00
Marketing                 	Marketing Representative	      $6,000.00
Human Resources           	Human Resources Representative	$6,500.00
Sales	                      Sales Manager	                  $12,200.00
Executive	Administration    Vice President	                $17,000.00
Shipping	                  Shipping Clerk	                $3,215.00
Public Relations	          Public Relations Representative	$10,000.00
Sales	                      Sales Representative	          $8,396.55
Executive	                  President	                      $24,000.00
Shipping	                  Stock Clerk	                    $2,785.00
Purchasing	                Purchasing Manager	            $11,000.00
Purchasing	                Purchasing Clerk	              $2,780.00
IT	                        Programmer	                    $5,760.00
Finance	                    Accountant	                    $7,920.00
Accounting	                Accounting Manager	            $12,008.00
-------------------------------------------------------------------------------*/
--21.각 부서의 정보를 부서매니저 이름과 함께 출력(부서는 모두 출력되어야 함)
-- 27건
SELECT d.*
     , e.FIRST_NAME as "매니저이름"
  FROM departments d LEFT OUTER JOIN employees e ON d.MANAGER_ID = e.EMPLOYEE_ID
;
/*--------------------------------------------------------------------
DEPARTMENT_ID,  DEPARTMENT_NAME,  MANAGER_ID, LOCATION_ID,  매니저이름
----------------------------------------------------------------------
70	            Public Relations	204	        2700	        Hermann
50	            Shipping	        121	        1500	        Adam
100	            Finance	          108       	1700	        Nancy
20	            Marketing	        201	        1800	        Michael
110	            Accounting	      205	        1700	        Shelley
60	            IT	              103	        1400	        Alexander
90	            Executive	        100	        1700	        Steven
40	            Human Resources	  203	        2400	        Susan
30	            Purchasing	      114	        1700	        Den
80	            Sales	            145	        2500	        John
10	            Administration	  200	        1700	        Jennifer
270	            Payroll		                    1700	
260	            Recruiting		                1700	
250	            Retail Sales		              1700	
240	            Government Sales		          1700	
230	            IT Helpdesk		                1700	
220	            NOC		                        1700	
210	            IT Support		                1700	
200	            Operations		                1700	
190	            Contracting		                1700	
180	            Construction		              1700	
170	            Manufacturing		              1700	
160	            Benefits		                  1700	
150	            Shareholder Services	        1700	
140	            Control And Credit		        1700	
130	            Corporate Tax		              1700	
120	            Treasury		                  1700	
----------------------------------------------------------------------*/
 
--22. 부서가 가장 많은 도시이름을 출력
-- a)
SELECT d.LOCATION_ID
     , COUNT(*)   "도시 수"
  FROM departments d
 GROUP BY d.LOCATION_ID
 ORDER BY "도시 수" DESC
;

-- b)
SELECT l.CITY
  FROM (SELECT d.LOCATION_ID
             , COUNT(*)   "부서 수"
          FROM departments d
         GROUP BY d.LOCATION_ID
         ORDER BY "부서 수" DESC) d JOIN locations l ON (d.LOCATION_ID = l.LOCATION_ID)
 WHERE ROWNUM = 1
;
/*------
Seattle
-------*/

--23. 부서가 없는 도시 목록 출력
-- 16건
--조인사용
SELECT l.CITY
     , d.DEPARTMENT_NAME
  FROM locations l LEFT OUTER JOIN departments d ON l.LOCATION_ID = d.LOCATION_ID
 WHERE d.DEPARTMENT_ID IS NULL
;
--집합연산 사용
SELECT l.CITY
     , d.DEPARTMENT_NAME
  FROM locations l LEFT OUTER JOIN departments d ON l.LOCATION_ID = d.LOCATION_ID
 MINUS
SELECT l.CITY
     , d.DEPARTMENT_NAME
  FROM locations l JOIN departments d ON l.LOCATION_ID = d.LOCATION_ID
;

--서브쿼리 사용
SELECT l.CITY
  FROM locations l
 WHERE NOT l.LOCATION_ID IN (SELECT d.LOCATION_ID
                          FROM departments d
                         GROUP BY d.LOCATION_ID)
;

/*---------------------------------
CITY,               DEPARTMENT_NAME
-----------------------------------
Beijing	
Bern	
Tokyo	
Sydney	
Utrecht	
South Brunswick	
Bombay	
Geneva	
Sao Paulo	
Venice	
Whitehorse	
Singapore	
Hiroshima	
Stretford	
Roma	
Mexico City	
----------------------------------*/
  
--24.평균 급여가 가장 높은 부서명을 출력
SELECT d.*
  FROM (SELECT d.DEPARTMENT_NAME                     AS "부서명"
             , TO_CHAR(AVG(e.SALARY), '$999,999.00') AS "평균 급여"
          FROM employees e JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
         GROUP BY d.DEPARTMENT_NAME
         ORDER BY "평균 급여" DESC) d
 WHERE ROWNUM = 1
;
/*---------------------
Executive	  $19,333.33
----------------------*/

--25. Finance 부서의 평균 급여보다 높은 급여를 받는 직원의 목록 출력
-- 28건
-- a)
SELECT AVG(e.SALARY)
  FROM employees e JOIN departments d ON (e.DEPARTMENT_ID = d.DEPARTMENT_ID)
 WHERE d.DEPARTMENT_NAME = 'Finance'
 GROUP BY d.DEPARTMENT_ID
;

--b)
SELECT e.LAST_NAME 
  FROM employees e
 WHERE e.SALARY > (SELECT AVG(e.SALARY)
                     FROM employees e JOIN departments d ON (e.DEPARTMENT_ID = d.DEPARTMENT_ID)
                    WHERE d.DEPARTMENT_NAME = 'Finance'
                    GROUP BY d.DEPARTMENT_ID)
;
/*--------
King
Kochhar
De Haan
Hunold
Greenberg
Faviet
Raphaely
Russell
Partners
Errazuriz
Cambrault
Zlotkey
Tucker
Bernstein
Hall
King
Sully
McEwen
Vishney
Greene
Ozer
Bloom
Fox
Abel
Hutton
Hartstein
Baer
Higgins
---------*/

-- 26. 각 부서별 인원수를 출력하되, 인원이 없는 부서는 0으로 나와야 하며
--     부서는 정식 명칭으로 출력하고 인원이 많은 순서로 정렬.
-- 27건
SELECT d.DEPARTMENT_NAME      as "부서명"
     , COUNT(e.DEPARTMENT_ID) as "인원 수"
  FROM employees e RIGHT OUTER JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
 GROUP BY d.DEPARTMENT_NAME
 ORDER BY "인원 수" DESC
;
/*--------------------------------
부서 명,                  인원 수
----------------------------------
Shipping	                45
Sales	                    34
Finance	                  6
Purchasing	              6
IT	                      5
Executive	                3
Marketing	                2
Accounting	              2
Public Relations	        1
Administration	          1
Human Resources	          1
Control And Credit	      0
Shareholder Services	    0
IT Helpdesk	              0
Operations	              0
Payroll	                  0
Recruiting	              0
Retail Sales	            0
NOC	                      0
Contracting	              0
Corporate Tax	            0
Benefits	                0
Government Sales	        0
Construction	            0
Manufacturing	            0 
IT Support	              0
Treasury	                0
----------------------------------*/

--27. 지역별 등록된 나라의 갯수 출력(지역이름, 등록된 나라의 갯수)
-- 4건
SELECT r.REGION_NAME        as "지역 이름"
     , COUNT(c.COUNTRY_ID)  as "등록된 나라의 개수"
  FROM regions r JOIN countries c ON (r.REGION_ID = c.REGION_ID)
 GROUP BY r.REGION_NAME
;
/*-----------------------------------------
지역 이름,              등록된 나라의 개수
-------------------------------------------
Middle East and Africa	6
Europe	                8
Asia	                  6
Americas	              5
------------------------------------------*/


--28. 가장 많은 나라가 등록된 지역명 출력
-- 1건
-- a)
SELECT r.REGION_NAME        as "지역 이름"
     , COUNT(c.COUNTRY_ID)  as "등록된 나라의 개수"
  FROM regions r JOIN countries c ON (r.REGION_ID = c.REGION_ID)
 GROUP BY r.REGION_NAME
 ORDER BY "등록된 나라의 개수" DESC
;

-- b)
SELECT "지역 이름"
  FROM (SELECT r.REGION_NAME        as "지역 이름"
             , COUNT(c.COUNTRY_ID)  as "등록된 나라의 개수"
          FROM regions r JOIN countries c ON (r.REGION_ID = c.REGION_ID)
         GROUP BY r.REGION_NAME
         ORDER BY "등록된 나라의 개수" DESC)
 WHERE ROWNUM = 1
;
/*---------------------
Europe
---------------------*/
