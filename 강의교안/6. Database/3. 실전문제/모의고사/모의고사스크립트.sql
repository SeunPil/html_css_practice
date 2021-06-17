--SQL 기본 및 활용

--문제3
DROP TABLE TB_PLAYER_3;
CREATE TABLE TB_PLAYER_3
(
  PLAYER_ID CHAR(6)
, PLAYER_NM VARCHAR2(50)
, BIRTH_DE CHAR(8)
)
;

INSERT INTO TB_PLAYER_3 VALUES ('100001', '박찬호', '19730629');
INSERT INTO TB_PLAYER_3 VALUES ('100002', '박찬호', '19950605');
INSERT INTO TB_PLAYER_3 VALUES ('100003', '박지성', '19810225');
INSERT INTO TB_PLAYER_3 VALUES ('100004', '이승우', '19980106');
COMMIT;


SELECT * FROM TB_PLAYER_3;

--PLAYER_ID PLAYER_NM   BIRTH_DE
----------- ----------- --------
--100001    박찬호      19730629
--100002    박찬호      19950605
--100003    박지성      19810225
--100004    이승우      19980106


--<SQL1>
SELECT          PLAYER_NM FROM TB_PLAYER_3; --4건

--<SQL2>
SELECT ALL      PLAYER_NM FROM TB_PLAYER_3; --4건(Default가 ALL)

--<SQL3>
SELECT DISTINCT PLAYER_NM FROM TB_PLAYER_3; --3건(박찬호 중복)
			
-----------------------------------------------------------------------------------------------------------------------------------------------------
			
--문제5 

DROP TABLE TB_EMP_5;                                                                                                                                  
CREATE TABLE TB_EMP_5                                                         
(                                                                             
  EMP_NO CHAR(6)                                                              
, EMP_NM VARCHAR2(50)                                                         
, MAJOR VARCHAR2(150)                                                         
, DEPT_CD CHAR(3)                                                             
);
 
INSERT INTO TB_EMP_5 VALUES ('100001', '이경오', '컴퓨터소프트웨어학', '101');
INSERT INTO TB_EMP_5 VALUES ('100002', '이수지', '데이터사이언스학'  , '101');
INSERT INTO TB_EMP_5 VALUES ('100003', '이지수', '컴퓨터공학'        , '101');
INSERT INTO TB_EMP_5 VALUES ('100004', '김성민', '컴퓨터공학'        , '102');
INSERT INTO TB_EMP_5 VALUES ('100005', '김민선', '데이터사이언스학'  , '102');
INSERT INTO TB_EMP_5 VALUES ('100006', '김선미', '컴퓨터소프트웨어학', '102');                                                                           
COMMIT;                                                                       


SELECT * FROM TB_EMP_5;


--EMP_NO EMP_NM  MAJOR               DEPT_CD
-------- ------- ------------------- -------
--100001 이경오  컴퓨터소프트웨어학  101
--100002 이수지  데이터사이언스학    101
--100003 이지수  컴퓨터공학          101
--100004 김성민  컴퓨터공학          102
--100005 김민선  데이터사이언스학    102
--100006 김선미  컴퓨터소프트웨어학  102

--①
SELECT A.*
 FROM TB_EMP_5 A
WHERE
      (     A.MAJOR = '데이터사이언스학'
        AND A.DEPT_CD = '101'
      )
   OR
      (     A.MAJOR = '컴퓨터공학'
        AND A.DEPT_CD = '102'
      )
;


--② 정답 (전공이 데이터사이언스학 혹은 컴퓨터공학이면서 부서코드가 '101' 혹은 '102'이면 모두 출력된다.)
SELECT A.*
 FROM TB_EMP_5 A
WHERE A.MAJOR IN ('데이터사이언스학', '컴퓨터공학')
  AND A.DEPT_CD IN ('101', '102')
;


--③
SELECT A.*
 FROM TB_EMP_5 A
WHERE (A.MAJOR, A.DEPT_CD) IN (('데이터사이언스학', '101'), ('컴퓨터공학', '102'));
;

--④ 정답 (전공이 컴퓨터소프트웨어학이면서 부서코드가 '101' 혹은 '102'인 직원은 집합에서 제외된다.)
SELECT A.*
 FROM TB_EMP_5 A
WHERE (A.MAJOR, A.DEPT_CD) NOT IN (('컴퓨터소프트웨어학', '101'), ('컴퓨터소프트웨어학', '102'));
;

-----------------------------------------------------------------------------------------------------------------------------------------------------

--문제6
DROP TABLE TB_CHAR_VARCHAR_6;

CREATE TABLE TB_CHAR_VARCHAR_6
(
  CHAR_VAL CHAR(10)
, VARCHAR_VAL VARCHAR2(10)
)
;

INSERT INTO TB_CHAR_VARCHAR_6 VALUES ( 'ABC'       , 'ABC'       ); --공백없음
INSERT INTO TB_CHAR_VARCHAR_6 VALUES ( 'ABCDE'     , 'ABCDE'     ); --공백없음
INSERT INTO TB_CHAR_VARCHAR_6 VALUES ( 'ABCDEFGHIJ', 'ABCDEFGHIJ'); --공백없음
INSERT INTO TB_CHAR_VARCHAR_6 VALUES ( 'ABC  '     , 'ABC  '     ); --공백이 2칸씩
INSERT INTO TB_CHAR_VARCHAR_6 VALUES ( 'ABCDE     ', 'ABCDE     '); --공백이 5칸씩

COMMIT;

--<SQL문>
SELECT COUNT(*) CNT
FROM TB_CHAR_VARCHAR_6 A
WHERE A.CHAR_VAL = A.VARCHAR_VAL
;

--<확인>
--CHAR와 VARCHAR 비교시 길이다 다르면 다른값으로 판단한다. 즉 두 문자열의 길이가 동일하고 문자열도 같아야 같다고 판단한다.
SELECT *
FROM TB_CHAR_VARCHAR_6 A
WHERE A.CHAR_VAL = A.VARCHAR_VAL
;

--CHAR_VAL   VARCHAR_VAL 
------------ ----------- 
--ABCDEFGHIJ ABCDEFGHIJ  --공백없음
--ABCDE      ABCDE       --공백이 5칸씩


-----------------------------------------------------------------------------------------------------------------------------------------------------
			
--문제7

--<SQL문>
SELECT ABS(CEIL(3.14) + FLOOR(3.14) * SIGN(-3.14)) AS RESULT_VAL
   FROM DUAL
;

	
--<테스트>
 SELECT ABS(CEIL(3.14) + FLOOR(3.14) * SIGN(-3.14)) AS RESULT_VAL
      , CEIL(3.14) --4가 나옴(천장)
      , FLOOR(3.14) --3이 나옴(바닥)
      , SIGN(-3.14) -- -1이 나옴(음수)
   FROM DUAL
;
   
--RESULT_VAL CEIL(3.14) FLOOR(3.14) SIGN(-3.14) 
------------ ---------- ----------- ----------- 
--         1          4           3          -1
         
-----------------------------------------------------------------------------------------------------------------------------------------------------

--문제8

SELECT DUMMY FROM DUAL;

--DUMMY
-------
--X

--<SQL문>
SELECT NVL(MAX(DUMMY), 'DUMMY') AS RESULT_VAL --MAX를 쓰면 공집합이 널이 나옴, NVL함수로인해 'DUMMY'가 나옴
  FROM DUAL
  WHERE 1=0 --공집합 조건
;

--RESULT_VAL 
------------ 
--DUMMY   

-----------------------------------------------------------------------------------------------------------------------------------------------------    
			
--문제9

DROP TABLE TB_EMP_9;

CREATE TABLE TB_EMP_9
(
  EMP_NO CHAR(6)
, EMP_NM VARCHAR2(50) NOT NULL
, DEPT_CD CHAR(3) NULL
, CONSTRAINT TB_EMP_9_PK PRIMARY KEY(EMP_NO)
)
;

INSERT INTO TB_EMP_9 VALUES ('100001', '이경오', '101');
INSERT INTO TB_EMP_9 VALUES ('100002', '김태호', '101');
INSERT INTO TB_EMP_9 VALUES ('100003', '박태훈', '102');
INSERT INTO TB_EMP_9 VALUES ('100004', '김수지', '102');
INSERT INTO TB_EMP_9 VALUES ('100005', '황정식', '103');
INSERT INTO TB_EMP_9 VALUES ('100006', '황태섭', '103');
INSERT INTO TB_EMP_9 VALUES ('100007', '김미선', '104');
INSERT INTO TB_EMP_9 VALUES ('100008', '박수경', '104');
INSERT INTO TB_EMP_9 VALUES ('100009', '최태경',  NULL);
INSERT INTO TB_EMP_9 VALUES ('100010', '김승리',  NULL);

COMMIT;

--<SQL문>
SELECT COUNT(DEPT_CD) --8건
     , COUNT(*) --10건 (널 2건 포함)
     , COUNT(DISTINCT DEPT_CD) --4건(부서코드의 종류가 4개임)
  FROM TB_EMP_9
;

-----------------------------------------------------------------------------------------------------------------------------------------------------
			
--문제10

DROP TABLE TB_PLAYER_10; 
CREATE TABLE TB_PLAYER_10
(
  PLAYER_ID CHAR(6)
, PLAYER_NM VARCHAR2(50) NOT NULL
, POS_NM VARCHAR2(5)
, BIRTH_DE CHAR(8) NOT NULL
, HEIGHT NUMBER(10, 2) NOT NULL
, WEIGHT NUMBER(10, 2) NOT NULL
, CONSTRAINT TB_PLAYER_10_PK PRIMARY KEY (PLAYER_ID)
)
;

INSERT INTO TB_PLAYER_10 VALUES ('100001', '황선홍', 'FW' ,  '19680714', '183.4', '81.2');
INSERT INTO TB_PLAYER_10 VALUES ('100002', '안정환', 'FW' ,  '19760127', '178.1', '68.3');
INSERT INTO TB_PLAYER_10 VALUES ('100003', '박지성', 'MF' ,  '19810330', '175.2', '71.2');
INSERT INTO TB_PLAYER_10 VALUES ('100004', '유상철', 'MF' ,  '19711018', '184.1', '77.8');
INSERT INTO TB_PLAYER_10 VALUES ('100005', '이천수', 'MF' ,  '19810709', '172.1', '63.1');
INSERT INTO TB_PLAYER_10 VALUES ('100006', '설기현', 'MF' ,  '19790204', '187.1', '77.2');
INSERT INTO TB_PLAYER_10 VALUES ('100007', '차두리', 'DF' ,  '19800725', '181.1', '75.8');
INSERT INTO TB_PLAYER_10 VALUES ('100008', '이영표', 'DF' ,  '19770423', '177.4', '70.2');
INSERT INTO TB_PLAYER_10 VALUES ('100009', '홍명보', 'DF' ,  '19690212', '181.1', '72.4');
INSERT INTO TB_PLAYER_10 VALUES ('100010', '최진철', 'DF' ,  '19710326', '187.8', '86.1');
INSERT INTO TB_PLAYER_10 VALUES ('100011', '이운재', 'GK' ,  '19730426', '182.1', '88.1');

COMMIT;

--① 정상임 평균신장으로 역순 정렬
SELECT A.POS_NM, AVG(HEIGHT) HEIGHT_AVG
  FROM TB_PLAYER_10 A
 GROUP BY A.POS_NM
 HAVING AVG(A.HEIGHT) >= 180
 ORDER BY AVG(A.HEIGHT) DESC
 ;

--② 정상임 평균신장으로 역순 정렬, HAVING이 GROUP BY보다 먼저나와도됨
SELECT A.POS_NM, AVG(HEIGHT) HEIGHT_AVG
  FROM TB_PLAYER_10 A
 HAVING AVG(A.HEIGHT) >= 180
 GROUP BY A.POS_NM
 ORDER BY AVG(A.HEIGHT) DESC
 ;

--③  정상임 평균신장으로 역순 정렬, HAVING이 GROUP BY보다 먼저나와도됨
SELECT A.POS_NM, A.HEIGHT_AVG
FROM
  (
    SELECT A.POS_NM, AVG(HEIGHT) HEIGHT_AVG
      FROM TB_PLAYER_10 A
     GROUP BY A.POS_NM
     ORDER BY AVG(A.HEIGHT)
  ) A
WHERE A.HEIGHT_AVG >= 180
ORDER BY 2 DESC
;

--④ 정답임 인라인뷰내에서는 평균신장으로 역순정렬했으나 메인 SQL단에서 포지션명으로 순차정렬하고있음
SELECT A.POS_NM, A.HEIGHT_AVG
FROM
  (
    SELECT A.POS_NM, AVG(HEIGHT) HEIGHT_AVG
     FROM TB_PLAYER_10 A
 GROUP BY A.POS_NM
 ORDER BY AVG(A.HEIGHT) DESC
  ) A
WHERE A.HEIGHT_AVG >= 180
ORDER BY 1 DESC
		  ;

-----------------------------------------------------------------------------------------------------------------------------------------------------
		
--문제11

DROP TABLE TB_PLAYER_11; 

CREATE TABLE TB_PLAYER_11
(
  PLAYER_ID CHAR(6)
, PLAYER_NM VARCHAR2(50) NOT NULL
, POS_NM VARCHAR2(5)
, BIRTH_DE CHAR(8) NOT NULL
, HEIGHT NUMBER(10, 2) NOT NULL
, WEIGHT NUMBER(10, 2) NOT NULL
, CONSTRAINT TB_PLAYER_11_PK PRIMARY KEY (PLAYER_ID)
)
;

INSERT INTO TB_PLAYER_11 VALUES ('100001', '황선홍', 'FW' ,  '19680714', '183.4', '81.2');
INSERT INTO TB_PLAYER_11 VALUES ('100002', '안정환', 'FW' ,  '19760127', '178.1', '68.3');
INSERT INTO TB_PLAYER_11 VALUES ('100003', '박지성', 'MF',  '19810330', '175.2', '71.2');
INSERT INTO TB_PLAYER_11 VALUES ('100004', '유상철', 'MF' ,  '19711018', '184.1', '77.8');
INSERT INTO TB_PLAYER_11 VALUES ('100005', '이천수', 'MF' ,  '19810709', '172.1', '63.1');
INSERT INTO TB_PLAYER_11 VALUES ('100006', '설기현', 'MF' ,  '19790204', '187.1', '77.2');
INSERT INTO TB_PLAYER_11 VALUES ('100007', '차두리', 'DF' ,  '19800725', '181.1', '75.8');
INSERT INTO TB_PLAYER_11 VALUES ('100008', '이영표', 'DF' ,  '19770423', '177.4', '70.2');
INSERT INTO TB_PLAYER_11 VALUES ('100009', '홍명보', 'DF' ,  '19690212', '181.1', '72.4');
INSERT INTO TB_PLAYER_11 VALUES ('100010', '최진철', 'DF' ,  '19710326', '187.8', '86.1');
INSERT INTO TB_PLAYER_11 VALUES ('100011', '이운재', 'GK' ,  '19730426', '182.1', '88.1');

COMMIT;


--<SQL문> --정답은 MAX임 최고신장이 185가 넘는 선수가 존재하는 포지션의 평균키를 구하고 있음
SELECT A.POS_NM AS 포지션
     , AVG(HEIGHT) AS 평균키
  FROM TB_PLAYER_11 A
GROUP BY A.POS_NM
HAVING MAX(A.HEIGHT) >= 185
;

-----------------------------------------------------------------------------------------------------------------------------------------------------

--문제12
											  		  
DROP TABLE TB_EMP_SAL_12; 

CREATE TABLE TB_EMP_SAL_12
(
  EMP_NO CHAR(6)
, STD_YYYY CHAR(4)
, SAL NUMBER(15) NULL
, CONSTRAINT TB_EMP_SAL_12_PK PRIMARY KEY(EMP_NO, STD_YYYY)
)
;

INSERT INTO TB_EMP_SAL_12 VALUES ('100001', '2020', '70000000');
INSERT INTO TB_EMP_SAL_12 VALUES ('100001', '2019', '65000000');
INSERT INTO TB_EMP_SAL_12 VALUES ('100001', '2018', '60000000');

INSERT INTO TB_EMP_SAL_12 VALUES ('100002', '2020', '60000000');
INSERT INTO TB_EMP_SAL_12 VALUES ('100002', '2019', '55000000');
INSERT INTO TB_EMP_SAL_12 VALUES ('100002', '2018', '50000000');


INSERT INTO TB_EMP_SAL_12 VALUES ('100003', '2020', '50000000');
INSERT INTO TB_EMP_SAL_12 VALUES ('100003', '2019', '45000000');
INSERT INTO TB_EMP_SAL_12 VALUES ('100003', '2018', '40000000');

INSERT INTO TB_EMP_SAL_12 VALUES ('100004', '2020', '40000000');
INSERT INTO TB_EMP_SAL_12 VALUES ('100004', '2019', '35000000');
INSERT INTO TB_EMP_SAL_12 VALUES ('100004', '2018', '30000000');

INSERT INTO TB_EMP_SAL_12 VALUES ('100005', '2020',  NULL     );
INSERT INTO TB_EMP_SAL_12 VALUES ('100005', '2019',  NULL     );
INSERT INTO TB_EMP_SAL_12 VALUES ('100005', '2018',  NULL     );

COMMIT;

--① 널이 맨 위로 올라옴
SELECT *
 FROM TB_EMP_SAL_12 A
WHERE A.STD_YYYY = '2019'
ORDER BY A.SAL DESC
;

--② 널이 맨 위로 올라옴
SELECT *
  FROM TB_EMP_SAL_12 A
 WHERE A.STD_YYYY = '2019'
 ORDER BY A.STD_YYYY, A.SAL DESC
 ;

--③ 정답임 널을 0으로 처리하고 역순정렬함
SELECT *
  FROM TB_EMP_SAL_12 A
 WHERE A.STD_YYYY = '2019'
 ORDER BY NVL(A.SAL, 0) DESC
;

--④ 널을 0으로 처리하고 순차정렬하여 널이 맨위로 올라옴
SELECT *
  FROM TB_EMP_SAL_12 A
 WHERE A.STD_YYYY = '2019'
 ORDER BY NVL(A.SAL, 0) ASC
;

-----------------------------------------------------------------------------------------------------------------------------------------------------
		
--문제13

DROP TABLE TB_EMP_SAL_13; 
CREATE TABLE TB_EMP_SAL_13
(
  EMP_NO CHAR(6)
, STD_YYYY CHAR(4)
, SAL NUMBER(15) NULL
, CONSTRAINT TB_EMP_SAL_13_PK PRIMARY KEY(EMP_NO, STD_YYYY)
)
;

INSERT INTO TB_EMP_SAL_13 VALUES ('100001', '2020', '70000000');
INSERT INTO TB_EMP_SAL_13 VALUES ('100001', '2019', '65000000');
INSERT INTO TB_EMP_SAL_13 VALUES ('100001', '2018', '60000000');

INSERT INTO TB_EMP_SAL_13 VALUES ('100002', '2020', '60000000');
INSERT INTO TB_EMP_SAL_13 VALUES ('100002', '2019', '55000000');
INSERT INTO TB_EMP_SAL_13 VALUES ('100002', '2018', '50000000');


INSERT INTO TB_EMP_SAL_13 VALUES ('100003', '2020', '50000000');
INSERT INTO TB_EMP_SAL_13 VALUES ('100003', '2019', '45000000');
INSERT INTO TB_EMP_SAL_13 VALUES ('100003', '2018', '40000000');

INSERT INTO TB_EMP_SAL_13 VALUES ('100004', '2020', '40000000');
INSERT INTO TB_EMP_SAL_13 VALUES ('100004', '2019', '35000000');
INSERT INTO TB_EMP_SAL_13 VALUES ('100004', '2018', '30000000');

INSERT INTO TB_EMP_SAL_13 VALUES ('100005', '2020',  NULL     );
INSERT INTO TB_EMP_SAL_13 VALUES ('100005', '2019',  NULL     );
INSERT INTO TB_EMP_SAL_13 VALUES ('100005', '2018',  NULL     );

COMMIT;


--① SAL이 널인건 제외됨
SELECT STD_YYYY, SAL
  FROM TB_EMP_SAL_13
 GROUP BY STD_YYYY, SAL
 HAVING SAL IS NOT NULL
 ORDER BY STD_YYYY, SAL
;



--② COUNT(SAL) 조건으로 SAL이 널인건 제외됨
SELECT STD_YYYY, SAL
  FROM TB_EMP_SAL_13
 GROUP BY STD_YYYY, SAL
 HAVING COUNT(SAL) >= 1
 ORDER BY STD_YYYY, SAL
;

--③ 정답임 COUNT(SAL)의 값이 2보다 큰 값은 없음
SELECT STD_YYYY, SAL
  FROM TB_EMP_SAL_13
 GROUP BY STD_YYYY, SAL
 HAVING COUNT(SAL) >= 2
 ORDER BY STD_YYYY, SAL
;

--④  SAL > 0조건으로 SAL이 널인건 제외됨
SELECT STD_YYYY, SAL
  FROM TB_EMP_SAL_13
 GROUP BY STD_YYYY, SAL
 HAVING SAL > 0
 ORDER BY STD_YYYY, SAL
;

-----------------------------------------------------------------------------------------------------------------------------------------------------
		
--문제15

DROP TABLE TB_EMP_SAL_15;
DROP TABLE TB_EMP_15;
DROP TABLE TB_SAL_GRADE_15;

CREATE TABLE TB_EMP_15
(
  EMP_NO CHAR(6)
, EMP_NM VARCHAR2(50) NOT NULL
, CONSTRAINT TB_EMP_15_PK PRIMARY KEY (EMP_NO)
)
;

INSERT INTO TB_EMP_15 VALUES ('100001', '이경오');
INSERT INTO TB_EMP_15 VALUES ('100002', '이수지');

COMMIT;

CREATE TABLE TB_EMP_SAL_15
(
  EMP_NO CHAR(6)
, SAL_STD_YYYY CHAR(8)
, SAL NUMBER
, CONSTRAINT TB_EMP_SAL_15_PK PRIMARY KEY (EMP_NO, SAL_STD_YYYY)
)
;

ALTER TABLE TB_EMP_SAL_15
ADD CONSTRAINTS TB_EMP_SAL_15_FK FOREIGN KEY (EMP_NO)
REFERENCES TB_EMP_15(EMP_NO)
;

INSERT INTO TB_EMP_SAL_15 VALUES ('100001', '2020', 75000000);
INSERT INTO TB_EMP_SAL_15 VALUES ('100001', '2019', 65000000);
INSERT INTO TB_EMP_SAL_15 VALUES ('100001', '2018', 55000000);
INSERT INTO TB_EMP_SAL_15 VALUES ('100002', '2020', 55000000);
INSERT INTO TB_EMP_SAL_15 VALUES ('100002', '2019', 35000000);
INSERT INTO TB_EMP_SAL_15 VALUES ('100002', '2018', 25000000);

COMMIT;

CREATE TABLE TB_SAL_GRADE_15
(
  SAL_GRADE CHAR(1)
, LOW_SAL NUMBER(10) NOT NULL
, HIGH_SAL NUMBER(10) NOT NULL
, CONSTRAINT TB_SAL_GRADE_15_PK PRIMARY KEY (SAL_GRADE)
)
;

INSERT INTO TB_SAL_GRADE_15 VALUES ('S', 100000000, 9999999999);
INSERT INTO TB_SAL_GRADE_15 VALUES ('A',  80000000, 99999999  );
INSERT INTO TB_SAL_GRADE_15 VALUES ('B',  60000000, 79999999  );
INSERT INTO TB_SAL_GRADE_15 VALUES ('C',  40000000, 59999999  );
INSERT INTO TB_SAL_GRADE_15 VALUES ('D',  30000000, 39999999  );
INSERT INTO TB_SAL_GRADE_15 VALUES ('E',  20000000, 29999999  );
INSERT INTO TB_SAL_GRADE_15 VALUES ('F',         0, 19999999  );

COMMIT;

--<SQL문>

--각각의 등급이 B B C C D E가 나옴
--유일한 등급은 B C D E임 
--등급의 개수는 4개임
SELECT COUNT(DISTINCT C.SAL_GRADE) AS CNT_SAL_GRADE
  FROM TB_EMP_15 A
     , TB_EMP_SAL_15 B
     , TB_SAL_GRADE_15 C
 WHERE A.EMP_NO = B.EMP_NO
   AND B.SAL BETWEEN C.LOW_SAL AND C.HIGH_SAL
;


--<테스트>
SELECT C.SAL_GRADE AS CNT_SAL_GRADE --각각의 등급이 B B C C D E가 나옴
     , B.SAL
  FROM TB_EMP_15 A
     , TB_EMP_SAL_15 B
     , TB_SAL_GRADE_15 C
 WHERE A.EMP_NO = B.EMP_NO
   AND B.SAL BETWEEN C.LOW_SAL AND C.HIGH_SAL
   ORDER BY 1;

-----------------------------------------------------------------------------------------------------------------------------------------------------			

--문제19

DROP TABLE TB_EMP_19;
DROP TABLE TB_DEPT_19;

CREATE TABLE TB_DEPT_19
(
  DEPT_NO CHAR(6)
, DEPT_NM VARCHAR2(150) NOT NULL
, CONSTRAINT TB_DEPT_19_PK PRIMARY KEY (DEPT_NO)
)
;

INSERT INTO TB_DEPT_19 VALUES ('D00001', 'Data시각화팀');
INSERT INTO TB_DEPT_19 VALUES ('D00002', 'Data플랫폼팀');
INSERT INTO TB_DEPT_19 VALUES ('D00003', 'Data분석팀');

COMMIT;

CREATE TABLE TB_EMP_19
(
  EMP_NO CHAR(6)
, EMP_NM VARCHAR2(50) NOT NULL
, DEPT_NO CHAR(6)
, CONSTRAINT TB_EMP_19_PK PRIMARY KEY (EMP_NO)
)
;

INSERT INTO TB_EMP_19 VALUES ('E00001', '이경오', 'D00001');
INSERT INTO TB_EMP_19 VALUES ('E00002', '이수지', 'D00001');
INSERT INTO TB_EMP_19 VALUES ('E00003', '김효선', 'D00002');
INSERT INTO TB_EMP_19 VALUES ('E00004', '박상진', 'D00003');


COMMIT;

ALTER TABLE TB_EMP_19
ADD CONSTRAINTS TB_EMP_19_FK FOREIGN KEY (DEPT_NO)
REFERENCES TB_DEPT_19(DEPT_NO)
;


--<SQL문>

--DISTINCT A.DEPT_NO 이부분은 D00002에만 해당됨 D00001의 값은 그대로 중복으로 나옴
 SELECT DISTINCT A.DEPT_NO
   FROM TB_EMP_19 A
  WHERE A.DEPT_NO = 'D00002'
 UNION ALL
 SELECT A.DEPT_NO
   FROM TB_EMP_19 A
  WHERE A.DEPT_NO = 'D00001'
 ORDER BY DEPT_NO
 ;

--DEPT_NO 
--------- 
--D00001 
--D00001 
--D00002 

-----------------------------------------------------------------------------------------------------------------------------------------------------			
            
--문제21

DROP TABLE TB_DEPT_21;

CREATE TABLE TB_DEPT_21
(
  DEPT_NO CHAR(6)
, DEPT_NM VARCHAR2(150) NOT NULL
, UPPER_DEPT_NO CHAR(6) NULL
, CONSTRAINT TB_DEPT_21_PK PRIMARY KEY (DEPT_NO)
)
;

INSERT INTO TB_DEPT_21 VALUES ('D00001', '회장실'        ,  NULL   );

INSERT INTO TB_DEPT_21 VALUES ('D00002', '영업본부'      , 'D00001');
INSERT INTO TB_DEPT_21 VALUES ('D00003', '기술본부'      , 'D00001');

INSERT INTO TB_DEPT_21 VALUES ('D00004', '국내영업부'    , 'D00002');
INSERT INTO TB_DEPT_21 VALUES ('D00005', '해외영업부'    , 'D00002');

INSERT INTO TB_DEPT_21 VALUES ('D00006', '개발사업부'    , 'D00003');
INSERT INTO TB_DEPT_21 VALUES ('D00007', '데이터사업부'  , 'D00003');

INSERT INTO TB_DEPT_21 VALUES ('D00008', '기업영업팀'    , 'D00004');
INSERT INTO TB_DEPT_21 VALUES ('D00009', '공공영업팀'    , 'D00004');

INSERT INTO TB_DEPT_21 VALUES ('D00010', '북미영업팀'    , 'D00005');
INSERT INTO TB_DEPT_21 VALUES ('D00011', '남미영업팀'    , 'D00005');

INSERT INTO TB_DEPT_21 VALUES ('D00012', '서버개발팀'    , 'D00006');
INSERT INTO TB_DEPT_21 VALUES ('D00013', '화면개발팀'    , 'D00006');

INSERT INTO TB_DEPT_21 VALUES ('D00014', '오라클기술팀'  , 'D00007');
INSERT INTO TB_DEPT_21 VALUES ('D00015', '오픈소스기술팀', 'D00007');

COMMIT;

--<SQL문>
SELECT B.DEPT_NO, B.DEPT_NM, B.UPPER_DEPT_NO, A.UPPER_DEPT_NO
  FROM TB_DEPT_21 A ㉠ OUTER JOIN TB_DEPT_21 B
    ON (B.UPPER_DEPT_NO = A.DEPT_NO)
 WHERE A.UPPER_DEPT_NO IS NULL
ORDER BY B.DEPT_NO;


--<테스트>
SELECT B.DEPT_NO, B.DEPT_NM, B.UPPER_DEPT_NO, A.UPPER_DEPT_NO
  FROM TB_DEPT_21 A RIGHT OUTER JOIN TB_DEPT_21 B --B집합이 다나옴
    ON (B.UPPER_DEPT_NO = A.DEPT_NO)
 WHERE A.UPPER_DEPT_NO IS NULL --'D00002', 'D00003'의 상위부서인 'D00001'은 상위부서가 없음
ORDER BY B.DEPT_NO
;

--DEPT_NO DEPT_NM    UPPER_DEPT_NO UPPER_DEPT_NO 
--------- ---------- ------------- ------------- 
--D00001  회장실     NULL          NULL                  
--D00002  영업본부   D00001        NULL             
--D00003  기술본부   D00001        NULL     

-----------------------------------------------------------------------------------------------------------------------------------------------------
		  
--문제23

DROP TABLE TB_EMP_23;
DROP TABLE TB_DEPT_23;

CREATE TABLE TB_DEPT_23
(
  DEPT_CD CHAR(4)
, DEPT_NM VARCHAR2(150) NOT NULL
)
;

ALTER TABLE TB_DEPT_23
ADD CONSTRAINT TB_DEPT_23_PK PRIMARY KEY (DEPT_CD);

INSERT INTO TB_DEPT_23 (DEPT_CD, DEPT_NM) VALUES ('D001', 'Data시각화팀');
INSERT INTO TB_DEPT_23 (DEPT_CD, DEPT_NM) VALUES ('D002', 'Data플랫폼팀');
INSERT INTO TB_DEPT_23 (DEPT_CD, DEPT_NM) VALUES ('D003', 'Data분석팀');

COMMIT;

CREATE TABLE TB_EMP_23
(
  EMP_NO CHAR(6)
, EMP_NM VARCHAR2(50) NOT NULL
, SEX_CD CHAR(1)
, BIRTH_DE CHAR(8) NOT NULL
, DEPT_CD CHAR(4)
)
;

ALTER TABLE TB_EMP_23
ADD CONSTRAINT TB_EMP_23_PK PRIMARY KEY (EMP_NO);

ALTER TABLE TB_EMP_23
ADD CONSTRAINT TB_EMP_23_FK FOREIGN KEY (DEPT_CD) REFERENCES TB_DEPT_23(DEPT_CD);


INSERT INTO TB_EMP_23 (EMP_NO, EMP_NM, SEX_CD, BIRTH_DE, DEPT_CD) VALUES ('E00001', '이경오', '1', '19840718', 'D001');
INSERT INTO TB_EMP_23 (EMP_NO, EMP_NM, SEX_CD, BIRTH_DE, DEPT_CD) VALUES ('E00002', '이수지', '2', '19940502', 'D001');
INSERT INTO TB_EMP_23 (EMP_NO, EMP_NM, SEX_CD, BIRTH_DE, DEPT_CD) VALUES ('E00003', '박경민', '1', '19830414', 'D002');
INSERT INTO TB_EMP_23 (EMP_NO, EMP_NM, SEX_CD, BIRTH_DE, DEPT_CD) VALUES ('E00004', '최주연', '2', '19920508', 'D002');
INSERT INTO TB_EMP_23 (EMP_NO, EMP_NM, SEX_CD, BIRTH_DE, DEPT_CD) VALUES ('E00005', '최철순', '1', '19860112', 'D003');
INSERT INTO TB_EMP_23 (EMP_NO, EMP_NM, SEX_CD, BIRTH_DE, DEPT_CD) VALUES ('E00006', '이지연', '2', '19960218', 'D003');
INSERT INTO TB_EMP_23 (EMP_NO, EMP_NM, SEX_CD, BIRTH_DE, DEPT_CD) VALUES ('E00007', '차은영', '2', '19980218',  NULL );

COMMIT;

--①
 SELECT A.EMP_NO, A.EMP_NM
      , (SELECT L.DEPT_NM FROM TB_DEPT_23 L WHERE L.DEPT_CD = A.DEPT_CD) AS DEPT_NM
      , A.BIRTH_DE
   FROM TB_EMP_23 A
   WHERE (A.DEPT_CD, BIRTH_DE) IN
                             (SELECT B.DEPT_CD, MAX(BIRTH_DE) --나이가 어린사람이 출력되게됨
                                FROM TB_EMP_23 B GROUP BY B.DEPT_CD
                              )
 ORDER BY A.BIRTH_DE
 ;

-- ②
 SELECT A.EMP_NO, A.EMP_NM
      , (SELECT L.DEPT_NM FROM TB_DEPT_23 L WHERE L.DEPT_CD = A.DEPT_CD) AS DEPT_NM
      , A.BIRTH_DE
   FROM TB_EMP_23 A
   WHERE (A.DEPT_CD, BIRTH_DE) IN
                             (SELECT B.DEPT_CD, MIN(BIRTH_DE) --나이가많은 사람이 출력되지만
                                FROM TB_EMP_23 B GROUP BY B.DEPT_CD
                              )
 ORDER BY A.DEPT_CD, A.BIRTH_DE --DEPT_CD가 먼저 나와서 DEPT_CD로 정렬되게됨
 ;

-- ③ 아우터 조인임 오답
 SELECT A.EMP_NO, A.EMP_NM
      , C.DEPT_NM AS DEPT_NM
      , A.BIRTH_DE
   FROM TB_EMP_23 A
      , (
             SELECT B.DEPT_CD, MIN(BIRTH_DE) AS BIRTH_DE
             FROM TB_EMP_23 B
             GROUP BY B.DEPT_CD
        ) B
      , TB_DEPT_23 C
 WHERE A.DEPT_CD = B.DEPT_CD(+)
  AND A.BIRTH_DE = B.BIRTH_DE(+)
  AND A.DEPT_CD = C.DEPT_CD(+)
  ORDER BY A.BIRTH_DE
  ;

-- ④ 정답임
 SELECT A.EMP_NO, A.EMP_NM
      , (SELECT L.DEPT_NM FROM TB_DEPT_23 L WHERE L.DEPT_CD = A.DEPT_CD) AS DEPT_NM
      , A.BIRTH_DE
   FROM TB_EMP_23 A
      , (
             SELECT B.DEPT_CD, MIN(BIRTH_DE) AS BIRTH_DE --나이많은사람이 나옴
             FROM TB_EMP_23 B
             GROUP BY B.DEPT_CD
        ) B
 WHERE A.DEPT_CD = B.DEPT_CD
  AND A.BIRTH_DE = B.BIRTH_DE
  ORDER BY A.BIRTH_DE --나이가 많은 순으로 나옴
  ;

-----------------------------------------------------------------------------------------------------------------------------------------------------
	  
--문제25

DROP TABLE TB_EMP_25;
DROP TABLE TB_DEPT_25;

CREATE TABLE TB_DEPT_25
(
  DEPT_CD CHAR(4)
, DEPT_NM VARCHAR2(150) NOT NULL
, CONSTRAINT TB_DEPT_25_PK PRIMARY KEY(DEPT_CD)
)
;

CREATE TABLE TB_EMP_25
(
  EMP_NO CHAR(6)
, EMP_NM VARCHAR2(50) NOT NULL
, JOB_NM VARCHAR2(150) NULL
, CUR_SAL NUMBER
, DEPT_CD CHAR(4)
, CONSTRAINT TB_EMP_25_PK PRIMARY KEY(EMP_NO)
)
;

ALTER TABLE TB_EMP_25
ADD CONSTRAINT TB_EMP_25_FK FOREIGN KEY (DEPT_CD) REFERENCES TB_DEPT_25(DEPT_CD);

INSERT INTO TB_DEPT_25 VALUES ('D101', '데이터개발팀'        );
INSERT INTO TB_DEPT_25 VALUES ('D102', '데이터플랫폼팀'      );
INSERT INTO TB_DEPT_25 VALUES ('D103', '데이터사이언스팀'    );
INSERT INTO TB_DEPT_25 VALUES ('D104', '데이터성능팀'        );
INSERT INTO TB_DEPT_25 VALUES ('D105', '데이터마이그레이션팀');

COMMIT;

INSERT INTO TB_EMP_25 VALUES ('100001', '이경오', 'SQL개발자'     , 45000000, 'D101');
INSERT INTO TB_EMP_25 VALUES ('100002', '이동민', '프로시저개발자', 40000000, 'D101');

INSERT INTO TB_EMP_25 VALUES ('100003', '김철수', '리눅스엔지니어', 40000000, 'D102');
INSERT INTO TB_EMP_25 VALUES ('100004', '박상진', '윈도우엔지니어', 35000000, 'D102');


INSERT INTO TB_EMP_25 VALUES ('100005', '박은정', 'R개발자'       , 50000000, 'D103');
INSERT INTO TB_EMP_25 VALUES ('100006', '김다연', '파이썬개발자'  , 45000000, 'D103');


INSERT INTO TB_EMP_25 VALUES ('100007', '박수진', '오라클튜너'    , 65000000, 'D104');
INSERT INTO TB_EMP_25 VALUES ('100008', '김성수', '오픈소스튜너'  , 60000000, 'D104');

INSERT INTO TB_EMP_25 VALUES ('100009', '추상미', '쉘개발자'      , 35000000, 'D105');
INSERT INTO TB_EMP_25 VALUES ('100010', '박나래', '자바개발자'    , 30000000, 'D105');

COMMIT;


--<SQL문>
SELECT B.DEPT_NM
     , AVG(A.CUR_SAL) AS CUR_SAL
  FROM TB_EMP_25 A
     , TB_DEPT_25 B
 WHERE A.DEPT_CD = B.DEPT_CD
 GROUP BY ROLLUP (B.DEPT_NM) --DEPT_NM별의 개수가 5개, 전체평균 1개 => 총 6건
;


-----------------------------------------------------------------------------------------------------------------------------------------------------

--문제26

DROP TABLE TB_EMP_26 ;
DROP TABLE TB_DEPT_26 ;

CREATE TABLE TB_DEPT_26
(
  DEPT_CD CHAR(4)
, DEPT_NM VARCHAR2(150) NOT NULL
, CONSTRAINT TB_DEPT_26_PK PRIMARY KEY(DEPT_CD)
)
;


CREATE TABLE TB_EMP_26
(
  EMP_NO CHAR(6)
, EMP_NM VARCHAR2(50) NOT NULL
, JOB_NM VARCHAR2(150) NULL
, CUR_SAL NUMBER
, DEPT_CD CHAR(4)
, CONSTRAINT TB_EMP_26_PK PRIMARY KEY(EMP_NO)
)
;

ALTER TABLE TB_EMP_26
ADD CONSTRAINT TB_EMP_26_FK FOREIGN KEY (DEPT_CD) REFERENCES TB_DEPT_26(DEPT_CD);

INSERT INTO TB_DEPT_26 VALUES ('D101', '데이터개발팀');
INSERT INTO TB_DEPT_26 VALUES ('D102', '데이터플랫폼팀');
INSERT INTO TB_DEPT_26 VALUES ('D103', '데이터사이언스팀');
INSERT INTO TB_DEPT_26 VALUES ('D104', '데이터성능팀');
INSERT INTO TB_DEPT_26 VALUES ('D105', '데이터마이그레이션팀');

COMMIT;

INSERT INTO TB_EMP_26 VALUES ('100001', '이경오', 'SQL개발자', 45000000, 'D101');
INSERT INTO TB_EMP_26 VALUES ('100002', '이동민', 'SQL개발자', 40000000, 'D101');

INSERT INTO TB_EMP_26 VALUES ('100003', '김철수', 'SQL개발자', 40000000, 'D102');
INSERT INTO TB_EMP_26 VALUES ('100004', '박상진', 'SQL개발자', 35000000, 'D102');


INSERT INTO TB_EMP_26 VALUES ('100005', '박은정', 'SQL개발자', 50000000, 'D103');
INSERT INTO TB_EMP_26 VALUES ('100006', '김다연', 'SQL개발자', 45000000, 'D103');


INSERT INTO TB_EMP_26 VALUES ('100007', '박수진', 'SQL개발자', 65000000, 'D104');
INSERT INTO TB_EMP_26 VALUES ('100008', '김성수', 'SQL개발자', 60000000, 'D104');

INSERT INTO TB_EMP_26 VALUES ('100009', '추상미', 'SQL개발자', 35000000, 'D105');
INSERT INTO TB_EMP_26 VALUES ('100010', '박나래', 'SQL개발자', 30000000, 'D105');

COMMIT;

--<SQL1>
SELECT A.JOB_NM
     , B.DEPT_NM
     , AVG(A.CUR_SAL) AS CUR_SAL
  FROM TB_EMP_26 A
     , TB_DEPT_26 B
WHERE A.DEPT_CD = B.DEPT_CD
GROUP BY ROLLUP(A.JOB_NM, B.DEPT_NM)
ORDER BY A.JOB_NM, B.DEPT_NM, CUR_SAL
;

--<SQL2>
SELECT A.JOB_NM
     , B.DEPT_NM
     , AVG(A.CUR_SAL) AS CUR_SAL
  FROM TB_EMP_26 A
     , TB_DEPT_26 B
WHERE A.DEPT_CD = B.DEPT_CD
GROUP BY GROUPING SETS((A.JOB_NM, B.DEPT_NM), A.JOB_NM, ())
ORDER BY A.JOB_NM, B.DEPT_NM, CUR_SAL
;


--<3번 보기>
SELECT A.JOB_NM
     , B.DEPT_NM
     , AVG(A.CUR_SAL) AS CUR_SAL
  FROM TB_EMP_26 A
     , TB_DEPT_26 B
WHERE A.DEPT_CD = B.DEPT_CD
GROUP BY ROLLUP(B.DEPT_NM, A.JOB_NM)
ORDER BY A.JOB_NM, B.DEPT_NM, CUR_SAL
;

SELECT A.JOB_NM
     , B.DEPT_NM
     , AVG(A.CUR_SAL) AS CUR_SAL
  FROM TB_EMP_26 A
     , TB_DEPT_26 B
WHERE A.DEPT_CD = B.DEPT_CD
GROUP BY GROUPING SETS((B.DEPT_NM, A.JOB_NM), B.DEPT_NM, ())
ORDER BY A.JOB_NM, B.DEPT_NM, CUR_SAL
;

-----------------------------------------------------------------------------------------------------------------------------------------------------
		
--문제28

DROP TABLE TB_EMP_28 ;

CREATE TABLE TB_EMP_28
(
  EMP_NO CHAR(6)
, EMP_NM VARCHAR2(50) NOT NULL
, JOB_NM VARCHAR2(150) NULL
, CUR_SAL NUMBER
, DEPT_CD CHAR(4)
, CONSTRAINT TB_EMP_28_PK PRIMARY KEY(EMP_NO)
)
;

INSERT INTO TB_EMP_28 VALUES ('100001', '이경오', 'SQL개발자', 45000000, 'D101');
INSERT INTO TB_EMP_28 VALUES ('100002', '이동민', 'SQL개발자', 40000000, 'D101');

INSERT INTO TB_EMP_28 VALUES ('100003', '김철수', 'SQL개발자', 40000000, 'D102');
INSERT INTO TB_EMP_28 VALUES ('100004', '박상진', 'SQL개발자', 35000000, 'D102');


INSERT INTO TB_EMP_28 VALUES ('100005', '박은정', 'SQL개발자', 50000000, 'D103');
INSERT INTO TB_EMP_28 VALUES ('100006', '김다연', 'SQL개발자', 45000000, 'D103');


INSERT INTO TB_EMP_28 VALUES ('100007', '박수진', 'SQL개발자', 65000000, 'D104');
INSERT INTO TB_EMP_28 VALUES ('100008', '김성수', 'SQL개발자', 60000000, 'D104');

INSERT INTO TB_EMP_28 VALUES ('100009', '추상미', 'SQL개발자', 35000000, 'D105');
INSERT INTO TB_EMP_28 VALUES ('100010', '박나래', 'SQL개발자', 30000000, 'D105');

COMMIT;

--<SQL문>
SELECT SUM(DENSE_RANK_CUR_SAL) SUM_DENSE_RANK_CUR_SAL
  FROM
(
SELECT DISTINCT DENSE_RANK() OVER (ORDER BY CUR_SAL) DENSE_RANK_CUR_SAL --동일순위를 하나의 등수로 취급한다. 
    FROM TB_EMP_28                                                      --총 10명이 있고 중복된 연봉이 3개이다.(4500만, 4000만, 3500만) 즉 등수는 1, 2, 3, 4, 5, 6, 7이 나옴
)                                                                       --모두 더하면 28이 나옴
;

-----------------------------------------------------------------------------------------------------------------------------------------------------
		
--문제29

DROP TABLE TB_EMP_29;

CREATE TABLE TB_EMP_29
(
  EMP_NO CHAR(6)
, EMP_NM VARCHAR2(50) NOT NULL
, SEX_CD CHAR(1)
, BIRTH_DE CHAR(8) NOT NULL
, DEPT_CD CHAR(4)
)
;

ALTER TABLE TB_EMP_29
ADD CONSTRAINT TB_EMP_29_PK PRIMARY KEY (EMP_NO);

INSERT INTO TB_EMP_29 (EMP_NO, EMP_NM, SEX_CD, BIRTH_DE, DEPT_CD) VALUES ('E00001', '이경오', '1', '19840718', 'D001');
INSERT INTO TB_EMP_29 (EMP_NO, EMP_NM, SEX_CD, BIRTH_DE, DEPT_CD) VALUES ('E00002', '이수지', '2', '19940502', 'D001');
INSERT INTO TB_EMP_29 (EMP_NO, EMP_NM, SEX_CD, BIRTH_DE, DEPT_CD) VALUES ('E00003', '박경민', '1', '19830414', 'D002');
INSERT INTO TB_EMP_29 (EMP_NO, EMP_NM, SEX_CD, BIRTH_DE, DEPT_CD) VALUES ('E00004', '최주연', '2', '19920508', 'D002');
INSERT INTO TB_EMP_29 (EMP_NO, EMP_NM, SEX_CD, BIRTH_DE, DEPT_CD) VALUES ('E00005', '최철순', '1', '19860112', 'D003');
INSERT INTO TB_EMP_29 (EMP_NO, EMP_NM, SEX_CD, BIRTH_DE, DEPT_CD) VALUES ('E00006', '이지연', '2', '19960218', 'D003');
INSERT INTO TB_EMP_29 (EMP_NO, EMP_NM, SEX_CD, BIRTH_DE, DEPT_CD) VALUES ('E00007', '차은영', '2', '19980218',  NULL );

COMMIT;

--<SQL문>
SELECT EMP_NO, EMP_NM, COUNT(DEPT_CD) OVER(PARTITION BY SEX_CD) AS CNT --성별이 '1'인 직원의 부서는 'D001', 'D002', 'D003'임 총 3건
  FROM TB_EMP_29;                                                      --성별이 '2'인 직원의 부서는 'D001', 'D002', 'D003', NULL임 DEPT_CD가 널인건 건수에서 제외되서 3건
--모두 CNT는 3건이 나옴  
	
	
--문제30

DROP TABLE TB_EMP_30;

CREATE TABLE TB_EMP_30
(
  EMP_NO CHAR(6)
, EMP_NM VARCHAR2(50) NOT NULL
, JOB_NM VARCHAR2(150) NULL
, CUR_SAL NUMBER
, DEPT_CD CHAR(4)
, CONSTRAINT TB_EMP_30_PK PRIMARY KEY(EMP_NO)
)
;


INSERT INTO TB_EMP_30 VALUES ('100001', '이경오', 'SQL개발자'     , 80000000, 'D101');
INSERT INTO TB_EMP_30 VALUES ('100002', '이동민', '프로시저개발자', 60000000, 'D101');

INSERT INTO TB_EMP_30 VALUES ('100003', '김철수', '리눅스엔지니어', 40000000, 'D102');
INSERT INTO TB_EMP_30 VALUES ('100004', '박상진', '윈도우엔지니어', 20000000, 'D102');

COMMIT;

--<SQL문>

SELECT SUM(CUR_SAL)/10000 --1억 나누기 1만 = 10000
 FROM
    (
      SELECT A.EMP_NO
           , A.EMP_NM
           , LAG(CUR_SAL) OVER(ORDER BY CUR_SAL) AS LAG_CUR_SAL 
           , LEAD(CUR_SAL) OVER(ORDER BY CUR_SAL) AS LEAD_CUR_SAL 
           , CUR_SAL
        FROM TB_EMP_30 A
       ORDER BY A.EMP_NO
    ) A
WHERE LAG_CUR_SAL IS NULL
   OR LEAD_CUR_SAL IS NULL
;

			
--문제31

CONN SYSTEM/1234  --ⓐ

CREATE USER DCL IDENTIFIED BY 1234; --ⓑ
GRANT CONNECT, RESOURCE, DBA TO DCL; --ⓒ

CONN DCL/1234 --ⓓ

CREATE TABLE DCL_TABLE_31 --ⓔ
(
    DCL_COL1 NUMBER
)
;

INSERT INTO DCL_TABLE_31 VALUES (1); --ⓕ

COMMIT; --ⓖ

CONN SYSTEM/1234 --ⓗ
DROP USER DCL; --ⓘ   --CASCADE가 없어서 유저 제거 불가
	  
-----------------------------------------------------------------------------------------------------------------------------------------------------

--문제34

DROP TABLE TB_EMP_34;

CREATE TABLE TB_EMP_34
(
  EMP_NO CHAR(6)
, EMP_NM VARCHAR2(50)
, DEPT_CD CHAR(4)
, CONSTRAINT TB_EMP_34_PK PRIMARY KEY(EMP_NO)
)
;

INSERT INTO TB_EMP_34 VALUES ('100001', '이경오', 'D101' );
INSERT INTO TB_EMP_34 VALUES ('100002', '이수진', 'D101' );
INSERT INTO TB_EMP_34 VALUES ('100003', '권수철', 'D102' );
INSERT INTO TB_EMP_34 VALUES ('100004', '이지은', 'D102' );
INSERT INTO TB_EMP_34 VALUES ('100005', '정수라', 'D103' );
INSERT INTO TB_EMP_34 VALUES ('100006', '김연정', NULL );

COMMIT;

DROP FUNCTION FN_EMP_CNT_BY_EMP_NM_34; 
CREATE OR REPLACE FUNCTION FN_EMP_CNT_BY_EMP_NM_34(IN_EMP_NM IN VARCHAR)
RETURN NUMBER IS V_EMP_CNT NUMBER;

BEGIN
SELECT COUNT(*) CNT
  INTO V_EMP_CNT
  FROM TB_EMP_34
 WHERE EMP_NM LIKE IN_EMP_NM || '%'
 ;

RETURN V_EMP_CNT;
END;
/
;

--<SQL문>

--성이 '이'씨인건 3건, 그외는 각각 1건씩(동명이인없음) , '이'씨성 3명은 3-1 = 2씩 나옴, 그외 3명은 1-1 = 0이 나옴
--결과값은 6이 나옴
SELECT
      SUM(FN_EMP_CNT_BY_EMP_NM_34(SUBSTR(A.EMP_NM, 1, 1)) - FN_EMP_CNT_BY_EMP_NM_34(A.EMP_NM)) AS CNT_SUM
  FROM TB_EMP_34 A
ORDER BY A.EMP_NO
;
			