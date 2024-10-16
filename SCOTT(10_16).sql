-- 함수 : 특정 결과 데이터를 얻기 위해 데이터를 입력할 수 있는 특수 명령어
-- 함수에는 내장 함수와 사용자 정의 함수가 있다.
-- 내장 함수에는 단일행 함수와 다중행 함수로 나누어짐
-- 단일행 함수: 데이터가 한 행씩 입력되고 결과가 한 행씩 나오는 함수.
-- 다중행 함수: 여러행이 입력되서 결과가 하나의 행으로 반환되는 함수.
-- 숫자 함수 : 수학 계산식을 처리하기 위한 함수
SELECT -10, abs(-10) FROM dual;

-- ROUND(숫자, 반올림할 위치) : 반올림한 결과를 반환하는 함수
SELECT ROUND(1234.5678) AS ROUND, -- 소수점 첫째자리에 반올림해서 결과를 반환
	ROUND(1234.5678, 0) AS ROUND_0,
	ROUND(1234.5678, 1) AS ROUND_1,	-- 소수점 두번째 자리에서 반올림해서 소수점 1자리 표시
	ROUND(1234.5678, 2) AS ROUND_2, -- 소수점 3번째 자리에서 소수점 2자리 표시
	ROUND(1234.5678, -1) AS ROUND_MINUS1, --정수 첫번째 자리를 반올림 ( = 1230)
	ROUND(1234.5678, -2) AS ROUND_MINUS2 -- 정수 2번째 자리를 반올림 (= 1200)
FROM dual;

-- TRUNC : 버림을 한 결과를 반환하는 함수, 자릿수 지정 가능
SELECT TRUNC(1234.5678) AS TRUNC, -- 소수점 첫째자리에 버림해서 결과를 반환
	TRUNC(1234.5678, 0) AS TRUNC_0,
	TRUNC(1234.5678, 1) AS TRUNC_1,	-- 소수점 두번째 자리에서 버림해서 소수점 1자리 표시
	TRUNC(1234.5678, 2) AS TRUNC_2, -- 소수점 3번째 자리에서 버림해서 소수점 2자리 표시
	TRUNC(1234.5678, -1) AS TRUNC_MINUS1, --정수 첫번째 자리를 버림 ( = 1230)
	TRUNC(1234.5678, -2) AS TRUNC_MINUS2 -- 정수 2번째 자리를 버림 (= 1200)
FROM dual;
-- dual : SYS 계정에서 제공하는 테이블; 테이블 참조 없이 실행해보기 위해 FROM절에 사용하는 더미 테이블
SELECT 20*30 FROM dual;
-- mod: 나누기한 후 나머지를 출력하는 함수
SELECT MOD(21, 5) FROM dual; -- 1
-- CEIL : 소수점 이하를 올림
SELECT CEIL(12.345) FROM dual; -- 13
-- FLOOR : 소수점 이하를 날림
SELECT FLOOR (12.345) FROM dual; -- 12
-- POWER : 제곱하는 함수
SELECT POWER(3, 4) FROM dual; --3^4 => 81

-- 문자 함수: 문자 데이터로 부터 특정 결과를 얻고자 할 때 사용하는 함수
SELECT ename, UPPER(ename), LOWER(ename), INITCAP(ename)
	FROM EMP; -- 이름, 대문자 이름, 소문자 이름, 첫글자만 대문자
-- UPPER 함수로 문자열 비교하기
SELECT * FROM EMP
	WHERE UPPER(ENAME) LIKE UPPER('%james%');
	
-- 문자열 길이를 구하는 LENGTH 함수, LENGTHB 함수
-- LENGTH : 문자열의 길이를 반환
-- LENGTHB : 문자열의 바이트를 반환
SELECT LENGTH(ENAME), LENGTHB(ENAME) -- 영어는 한 byte를 차지하기 때문에 길이와 byte 수가 동일하다. 
	FROM emp;
	
SELECT LENGTH('죠죠'), LENGTHB('죠죠') FROM dual; -- 오라클 XE에서 한글은 3 byte를 차지한다.

-- 직책 이름의 길이 다 6글자 이상이고, COMM 있는 사원의 모드 정보 출력
SELECT * FROM EMP
	WHERE LENGTH(JOB) > 6 AND COMM IS NOT NULL AND COMM != 0;
	
-- SUBSTR / SUBSTRB : 시작 위치로부터 선택 개수만큼의 문자를 반환하는 함수
SELECT job, SUBSTR(job, 1, 2), SUBSTR(job, 3, 2), SUBSTR(job, 5)
	FROM emp;
	
-- SUBSTR 함수와 다름 함수 함께 사용
SELECT job,
	SUBSTR(job, -LENGTH(job)), -- -5에서 부터 끝까지; 
	SUBSTR(job, -LENGTH(job), 2),
	SUBSTR(job, -3)
	FROM emp;
	
-- INSTR : 문자열 데이터 안에 특정 문자나 문자열이 어디에 포함되어 있는지를 알고자 할 때 사용.
SELECT INSTR('HELLO, ORACLE', 'L') AS INSTR_1, -- L 문자의 위치
	INSTR('HELLO ORACLE', 'L', 5) AS INSTR_2, --5번째 위치에서 시작해서 L 문자의 위치 찾기
	INSTR('HELLO_ORACLE', 'L',2, 2) AS INSTR_3 -- 2번째 위치에서 시작해서 2번째에 나타나는 l 문자의 위치 찾기
	FROM dual;
	
-- 특정 문자가 포함된 행 찾기
SELECT * FROM EMP
	WHERE INSTR(ENAME, 'S') > 0; -- S 라는 문자가 포함된 행 출력.
	
SELECT * FROM EMP -- 위와 이건 같은 셈
	WHERE ENAME LIKE '%S%';
	
-- REPLACE : 특정 문자열 데이터에 포함된 문자를 다른 문자로 교체
-- 대체할 문자를 지정하지 않으면 삭제
SELECT '010-5009-4146' AS "변경 이전",
	REPLACE('010-5006-4146', '-', '/') AS "변경 이후 1",
	REPLACE('010-5006-4146', '-') AS "변경 이후 2"
FROM dual;

-- LPAD / RPAD : 기준 공간 칸수를 지정하고 빈칸 만큼을 특정 문자로 채우는 함수
SELECT LPAD('ORACLE', 10, '+') FROM DUAL; -- ++++ORACLE ; 왼쪽을 채워서 10칸이 된다.
SELECT RPAD('ORACLE', 10, '+') FROM DUAL; -- ORACLE++++ ; 오른쪽을 채워서 10칸이 된다.

SELECT RPAD('010222-', 14, '*') AS RPAD_SOCIAL_SECURITY,
	RPAD('010-5006-', 13, '*') AS RPAD_CONTACT
FROM DUAL;

-- 두 문자열을 합치는 CONCAT 함수
SELECT CONCAT(empno, ename) AS "사원정보",
	CONCAT(empno, CONCAT(' : ', ENAME)) AS "사원정보 : "
	FROM EMP
	WHERE ENAME = 'JAMES';
	
-- TRIM / LTRIM / RTRIM : 문자열 데이터 내에서 특정 문자를 지우기 위해 사용, 문자를 지정하지 않음 공백
SELECT '[' || TRIM('  _ORACLE_  ') || ']' AS TRIM,
	'[' || LTRIM( '  _ORACLE_  ') || ']' AS LTRIM,
	'[' || RTRIM( '  _ORACLE_  ') || ']' AS RTRIM
	FROM DUAL;
	
-- 날씨 데이터를 다루는 함수
-- 날짜 데이터 + 숫자 : 가능, 날짜에서 숫자 만큼의 이후 날짜
-- 날짜 데이터 - 숫자 : 가능, 날짜에서 숫자 만큼의 이전 날짜
-- 날짜 데이터 - 날짜 데이터 : 가능, 두 날짜간의 일 수 차이
-- 날짜 데이터 + 날짜 데이터 : 불가능 ; 연산 불가
-- SYSDATE : 운영체제로부터 시간을 가져오는 함수
SELECT SYSDATE FROM dual;

SELECT SYSDATE AS "현재시간",
	SYSDATE - 1 AS "어제",
	SYSDATE + 1 AS "내일"
FROM dual;

-- 몇개월 이후 날짜를 구하는 ADD_MONTH 함수 : 특정 날짜에 지정한 개월 수 이후 날짜 데이터를 반환
SELECT SYSDATE AS "현재 시간",
	ADD_MONTHS(SYSDATE, 3) AS "3개월 이후"
	FROM DUAL;

--입사 10주년이 되는 사원들의 데이터 출력하기 (입사일로부터 10년이 경과한 날짜 데이터 반환)
SELECT EMPNO, ENAME, HIREDATE AS "입사일", ADD_MONTHS(HIREDATE, 120) AS "10주년"
	FROM EMP
	
-- 두 날짜간의 개월 수 차이를 구하는 MONTHS_BETWEEN() 함수
SELECT empno, ename, hiredate, SYSDATE,
	MONTHS_BETWEEN(sysdate, hiredate) AS "재직기간",
	TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS "재직 기간2"
	FROM emp;
	
-- 돌아오는 요일 (NEXT_DAY), 달의 마지막 날짜 (LAST_DAY)
SELECT SYSDATE,
	NEXT_DAY(SYSDATE, '월요일'),
	LAST_DAY(SYSDATE)
FROM DUAL;

-- 날짜 정보 추출 함수 : extract
SELECT EXTRACT (YEAR FROM DATE '2024-10-16')
FROM DUAL;

SELECT * FROM EMP
	WHERE EXTRACT (MONTH FROM HIREDATE) = 12;
	
-- 자료형을 변환하는 형 변환 함수
SELECT empno, ename, '2345' + '500' -- 오라클의 기본 형 변환 변경 가능 숫자로 변환
	FROM emp
WHERE ename = 'FORD';

-- 날짜, 숫자를 문자로 변환하는 TO_CHAR 함수: 자바의 SimpleDateFormat과 유사
SELECT SYSDATE AS "기본시간형태", TO_CHAR(SYSDATE, 'YYYY/MM/DD') AS "현재날짜"
FROM DUAL;

-- 다양한 형식으로 출력 하기
SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'CC') AS 세기,
    TO_CHAR(SYSDATE, 'YY') AS 연도,
    TO_CHAR(SYSDATE, 'YYYY/MM/DD PM HH:MI:SS ') AS "년/월/일 시:분:초",
    TO_CHAR(SYSDATE, 'Q') AS 쿼터,
    TO_CHAR(SYSDATE, 'DD') AS 일,
    TO_CHAR(SYSDATE, 'DDD') AS 경과일,
    TO_CHAR(SYSDATE, 'HH') AS "12시간제",
    TO_CHAR(SYSDATE, 'HH12') AS "12시간제",
    TO_CHAR(SYSDATE, 'HH24') AS "24시간제",
    TO_CHAR(SYSDATE, 'W') AS 몇주차
FROM DUAL;

-- 여러 언어로 날짜(월) 출력 하기
SELECT SYSDATE,
     TO_CHAR(SYSDATE, 'MM') AS MM,
     TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN' ) AS MON_KOR,
     TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE') AS MON_JPN,
     TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS MON_ENG,
     TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = KOREAN' ) AS MONTH_KOR,
     TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = JAPANESE') AS MONTH_JPN,
     TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS MONTH_ENG
FROM DUAL;

-- 숫자 데이터 형식을 지정하여 출력하기
SELECT SAL,
     TO_CHAR(SAL, '$999,999') AS SAL_$, -- 9는 숫자의 한 자리를 의미; 빈자리를 채우지 않는다.
     TO_CHAR(SAL, 'L999,999') AS SAL_L,	-- L은 지역화폐 단위 출력 (LOCAL)
     TO_CHAR(SAL, '999,999.00') AS SAL_1, -- 0은 빈자를 0으로 채움
     TO_CHAR(SAL, '000,999,999.00') AS SAL_2,
     TO_CHAR(SAL, '000999999.99') AS SAL_3,
     TO_CHAR(SAL, '999,999,00') AS SAL_4
FROM EMP;

-- TO_NUMBER : 숫자 타입의 문자열을 숫자 데이터로 변환 해주는 함수
SELECT 1300 - '1500'
	FROM DUAL;
SELECT TO_NUMBER('1300') - TO_NUMBER('1500') AS "TO_NUMBER 사용"
	FROM DUAL;
	
-- TO_DATE : 문자열로 명시된 날짜로 변환하는 함수
SELECT TO_DATE('24-10-24', 'YY/MM/DD') AS "날짜타입",
	TO_DATE('20240714', 'YYYY/MM/DD') AS "날짜타입2"
FROM DUAL;

-- 1981년 7월 1일 이후 입사한 사원 정보 출력하기
SELECT *
	FROM EMP
	-- WHERE HIREDATE > '1981/07/01'; -- 이렇게 써도 인식은 하지만..
	WHERE HIREDATE > TO_DATE('1981/07/01', 'YYYY/MM/DD'); -- 원칙적으로는 TO_DATE 써야한다.
	
-- NULL 처리 함수: 특정 열의 행에 데이터가 없는 경우 데이터의 값이 NULL이 됨 (NULL 값이 없음)
-- NULL : 값이 할당디지 않았기 때문에 공백이나 0 과는 다른 의미, 연산 (계산, 비교 등등)
-- NVL(검사할 데이터 또는 열, 앞의 데이터가 NULL인 경우 대체할 값)
SELECT empno, ename, sal, comm, sal+comm,
	NVL(comm, 0),
	sal * 12 + NVL(comm, 0) AS "연봉"
FROM emp;

-- NVL2(검사할 데이터, 데이터가 NULL이 아닐 때 반환 되는 값, 데이터가 NULL일 때 반환되는 값)
SELECT empno, ename, comm, 
	NVL2(comm, 'O', 'X'),
	NVL2(comm, sal*12+comm, sal*12) AS "연봉"
FROM emp;

--NULLIF : 두 값을 비교하여 동일하면 NULL, 아니면 첫번째 값을 반환
SELECT NULLIF (10, 10), NULLIF ('A', 'B')
	FROM dual;
	
--DECODE : 주어진 데이터 값이 조건 값과 일치하는 값을 출력하고 일치하는 값이 없으면 기본값 출력
SELECT empno, ename, job, sal,
	DECODE(job, 
		'MANAGER', sal * 1.1,
		'SALESMAN', sal * 1.05,
		'ANALYST', sal,
		sal * 1.03) AS "연봉 인상"
FROM EMP;

-- CASE : SQL의 표준 함수; 일반적으로 SELECT절에 많이 사용됨. 하지만 다른 곳에서도 사용 가능 
-- 위의 DECODE 보다 이게 일반적으로 낫다
SELECT empno, ename, job, sal,
	CASE job
		WHEN 'MANAGER' THEN SAL * 1.1
		WHEN 'SALESMAN' THEN SAL * 1.05
		WHEN 'ANALYSDT' THEN SAL
		ELSE SAL * 1.03
	END AS "연봉 인상"
FROM emp;

-- 열 값에 따라서 출력이 달라지는 case 문 : 기존 데이터를 지정하지 않고 사용하는 방법
SELECT empno, ename, comm,
	CASE
		WHEN comm IS NULL THEN '해당 사항 없음'
		WHEN comm = 0 THEN '수당 없음'
		WHEN comm > 0 THEN '수당 : ' || comm -- || 가 db에서는 연결 연산자다
	END AS "수당 정보"
FROM emp;	
	
-- 1. EMP테이벌에서 사번, 사원명, 급여 조회
-- 다만 급여는 100 단위 값까지만 출력 처리, 급여 기준 내림차순 정렬
SELECT empno, ename, sal, TRUNC(SAL, -2) FROM emp
	ORDER BY SAL DESC;

-- 2. EMP 테이블에서 9월에 입사한 직원의 정보 조회
SELECT * FROM EMP
	WHERE EXTRACT (MONTH FROM hiredate) = 9;
	
-- 3. 테이블에서 사번, 사원명, 입사일, 입사일로부터 40년되는 날짜 조회
SELECT empno, ename, hiredate, ADD_MONTHS(HIREDATE, 12 * 40) -- 특정 날짜에 개월 수를 더해 날짜를 계산
	FROM EMP;
-- 4. EMP테이블에서 입사일로부터 38년 이상 근무한 직원의 정보 조회
SELECT * FROM EMP
	WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE) /12 >= 38; 

-- 실습문제
-- Q1
SELECT empno, 
	RPAD(SUBSTR(empno, 1, 2), 4, '*') AS MASKING_EMPNO,
	ENAME,
	RPAD(SUBSTR(ename, 1, 1), 5, '*') AS MASKING_ENAME
FROM emp
WHERE LENGTH(ENAME) = 5;
-- Q2 일급/시급 구하기
SELECT EMPNO, ENAME, SAL,
	TRUNC(SAL / 21.5, 2) AS DAY_PAY, --소수점 3번째 자리에서 버림해서 2번째 자리 출력
	ROUND(SAL / 21.5 / 8, 1) AS TIME_PAY -- 2번째 자리에서 버림해서 1번째 자리 출력
FROM EMP;
-- Q3
SELECT EMPNO, ENAME, HIREDATE,
	TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
	NVL(TO_CHAR(COMM), 'N/A') AS COMM
	--NVL2(comm, TO_CHAR(comm), 'N/A') AS COMM
FROM EMP;
-- Q4
SELECT EMPNO, ENAME, MGR,
	CASE
		WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '75' THEN '5555'
		WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '76' THEN '6666'
		WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '77' THEN '7777'
		WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '78' THEN '8888'
		WHEN MGR IS NULL THEN '0000'
		ELSE TO_CHAR(MGR)
	END AS CHG_MGR
FROM EMP;
	