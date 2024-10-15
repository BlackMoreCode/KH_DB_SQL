-- SELECT와 FROM 절
-- SELECT 문은 데이터 베이스에 보관되어 있는 데이터를 조회할 때 사용
-- SELECT 절은 FROM 절에 명시한 테이블에서 조회할 열(COLUMN)을 지정할 수 있다
-- 기본형태:
-- SELECT [조회할 열], [조회할 열] FROM 테이블 이름;

SELECT * FROM EMP; -- *  아스테리스크는 "모든 컬럼"를 의미. FROM 다음에 오는 것이 테이블 이름. SQL 수행문은 "; (세미콜론)" 으로 끝내야한다.

-- 특정 컬럼만 선택해서 조회
SELECT EMPNO, ENAME, DEPTNO FROM EMP;
-- 사원번호와 부서번호만 나오도록 sql 작성 (EMPNO, DEPTNO)
SELECT EMPNO, DEPTNO FROM EMP;

--한눈에 보기 좋게 별칭 부여하기
SELECT ENAME, SAL, COMM, SAL * 12 + COMM
	FROM EMP;
	
SELECT ENAME "이름", SAL AS "급여", COMM AS "성과급", SAL * 12 "연봉"
	FROM EMP;
	
-- 중복 제거 DISTINCT, 데이터를 조회할 때 중복되는 행이 여러행이 조회될 때, 중복된 행을 한개씩만 선택
SELECT DISTINCT DEPTNO 
FROM EMP 
ORDER BY DEPTNO;

-- 컬럼 값을 계산하는 산술 연산자 (+, -, *, /)
SELECT ENAME, SAL, SAL * 12 "연간급여", SAL * 12  + COMM "총 연봉"
	FROM emp;
	
-- 연습문제: 직책(job) 중복 제거해서 출력하기
SELECT DISTINCT JOB FROM EMP;

-- WHERE 구문 (조건문)
-- 데이터를 조회할 때 사용자가 원하는 조건에 맞는 데이터만 조회할 때 사용

SELECT * FROM EMP -- 먼저 테이블이 선택되고, WHERE절에서 행을 제한하고, 출력할 열을 결정
WHERE DEPTNO = 20;

-- 사원 번호가 7369인 사원의 모든 정보를 보여라 예시
SELECT * FROM EMP
	WHERE EMPNO = 7369; -- 데이터베이스에서 비교는 =(같다) 라는 의미로 사용 됨
	
-- 급여가 2500 초과인 사원번호, 이름, 직책, 급여 출력
-- EMP 테이블에서 급여가 2500 초과인 행을 선택, 사원번호, 이름, 직책, 급여에 컬럼을 선택해 출력
SELECT EMPNO, ENAME, JOB, SAL
	FROM EMP
	WHERE SAL > 2500;
	
-- WHERE 절에 기본 연산자 사용
SELECT * FROM EMP
	WHERE sal * 12 = 36000;

-- WHERE 절에 사용하는 비교 연산자: >, >=, <. <=
-- 성과급이 500 초과인 사람의 모든 정보 출력
SELECT * FROM EMP
	WHERE COMM > 500;

-- 입사일이 81년 1월 1일 이전 사람의 모든 정보 출력
SELECT * FROM EMP
	WHERE HIREDATE <= '90/01/01'; --DB에 있는 문자열 비교시 ''사용; DATE 타입은 날짜의 형식에 맞으면 가능

-- 같지 않음을 표현하는 여러가지 방법: <>, !=, ^=, NOT 칼럼명 =
SELECT * FROM EMP
	--WHERE DEPTNO ^= 30;
	--WHERE DEPTNO != 30;
	--WHERE DEPTNO <> 30;
	WHERE NOT DEPTNO = 30;
	
-- 논리 연산자: AND, OR, NOT
-- 급여가 3000 이상이고 부서가 20번인 사원의 모든 정보 출력
SELECT * FROM EMP
	WHERE SAL >= 3000 AND DEPTNO = 20;
-- 급여가 3000 이상"이거나" 부서가 20번인 사원의 모든 정보 출력
SELECT * FROM EMP
	WHERE SAL >= 3000 OR DEPTNO = 20;
-- 급여가 3000 이상이고, 부서가 20번이고, 입사일이 82년 1월 1일 이전 사원의 모든 정보 출력
SELECT * FROM EMP
	WHERE SAL >= 3000 AND DEPTNO = 20 AND HIREDATE <= '82/01/01';
--급여가 3000 이상이고, 부서가 20번이거나, 입사일이 82년 1월 1일 이전 사원의 모든 정보 출력
SELECT * FROM EMP
	WHERE SAL >= 3000 AND (DEPTNO = 20 OR HIREDATE <= '82/01/01');	

-- 급여가 2500 이상이고 직책이 MANAGER인 사원의 모든 정보 출력
SELECT * FROM EMP
	WHERE SAL >= 2500 AND JOB = 'MANAGER';

SELECT * FROM EMP
	WHERE JOB = 'MANAGER' OR JOB = 'SALESMAN' OR JOB = 'CLERK';
-- IN 연산자 : 여러개의 열 이름을 조회해야할 경우 연속해서 나열 할 수 있음
SELECT * FROM EMP
	WHERE JOB IN ('MANAGER', 'SALESMAN', 'CLERK');

-- IN 연산자를 사용해 20번과 30번 부서의 포함된 사원을 모든 정보를 출력
SELECT * FROM EMP
	WHERE DEPTNO IN (20, 30);

-- NOT IN 연산자를 사용해 20번과 30번 부서에 포함된 사원 조회
SELECT * FROM EMP
	WHERE DEPTNO NOT IN (10);

-- 비교 연산자와 AND 연산자를 사용하여 출력하기
SELECT * FROM EMP
	WHERE JOB != 'MANAGER' AND JOB <> 'SALESMAN' AND JOB ^= 'CLERK';

-- 급여가 2000에서 3000사이 사원의 모든 정보를 출력
SELECT * FROM EMP
	WHERE SAL >= 2000 AND SAL <= 3000;
	
-- BETWEEN A AND B 연산자 : 일정한 범위를 조회할 때 사용하는 연산자
SELECT * FROM EMP
	WHERE SAL BETWEEN 2000 AND 3000;
	
-- 사원번호가 7689 에서 7902까지의 사원의 모든 정보 출력하기
SELECT * FROM EMP
	WHERE EMPNO BETWEEN 7689 AND 7902;
	
--1980년이 아닌 해에 입사한 사원의 모든 정보를 출력
SELECT * FROM EMP
	WHERE NOT HIREDATE BETWEEN '80/01/01' AND '80/12/31';
	
-- LIKE, NOT LIKE 연산자 : 내용중에서 문자열을 검색할 때 사용하는 연산자
-- % : 길이와 상관 없이 모든 문자 데이터를 의미
-- _ : 문자 1개를 의미
SELECT empno, ename FROM emp
	WHERE ename LIKE '%K%'; --앞과 뒤의 문자열 길이에 상관 없이 K라는 문자가 ename에 포함된 사원 정보 출력

-- 사원의 이름의 2번째 글자가 L인 사원만 출력하기
SELECT * FROM EMP
	WHERE ename LIKE '_L%';
	
-- [실습] 사원 이름에 am이 포함되어 있는 사원 데이터만 출력
SELECT * FROM emp
	WHERE ename LIKE '%AM%';
-- [실습] 사원 이름에 am이 포함되어 있지 않은 사원 데이터만 출력
SELECT * FROM EMP
	WHERE ENAME NOT LIKE '%AM%'; -- %AM 이면 am으로 끝나는 것만, AM%면 AM으로 시작하는 것만
	
-- 와일드 카드 문자가 데이터 일부일 때 : (%, _) => escape로 지정된 '\' 뒤에 오는 %는 와일드 카드가 아니라는 의미
	
--DML
INSERT INTO EMP(empno, ename, job, mgr, hiredate, SAL, COMM, DEPTNO)
	VALUES(8888, 'JAME%S', 'MANAGER', 7839, '2024-10-15', 3500, 450, 30);
	
SELECT * FROM EMP
	WHERE ENAME LIKE '%\%S' ESCAPE '\'; --사원이름이 %S로 끝나는 모든 사원을 조회
	
DELETE FROM EMP
	WHERE EMPNO = 8888;
	
SELECT * FROM emp;

-- is null 연산자 : 
-- 데이터 값에는 NULL값을 가질 수 있음; 값이 정해지지 않음을 의미.

SELECT ename, sal, sal*12+comm "연봉", COMM
	FROM emp;
	
-- 비교연산으로 NULL 비교하기 => null은 애초에 연산불가, 비교불가
SELECT * FROM EMP
	WHERE comm = NULL;
	
-- 해당 데이터가 NULL인지 확인하는 방법은 is NULL 연산자를 사용해야한다
SELECT * FROM EMP
	WHERE COMM IS NULL;
	
-- 해당 데이터가 null이 아닌 데이터만 출력하기
SELECT * FROM EMP
	WHERE COMM IS NOT NULL;
	
-- 직속상관 (MANAGER)가 없는 사원만 출력
SELECT * FROM EMP
	WHERE mgr IS NOT NULL;
	
-- 정렬을 위한 ORDER BY 절; 오름차순 또는 내림차순 정렬 가능
SELECT * FROM EMP
	ORDER BY SAL; -- 급여에 대한 오름차순 정렬
	
SELECT * FROM EMP
	ORDER BY SAL DESC; -- 급여에 대한 내림차순 정렬
	
-- 정렬 조건을 여러 컬럼을 설정하기
SELECT * FROM EMP
	ORDER BY SAL DESC, ENAME; --급여는 내림차순으로, 급여가 같으면 이름순으로 오름차순 정렬
	
-- 별칭 사용과 ORDER BY
SELECT empno 사원번호, ename 사원명, sal 월급, hiredate 입사일 --3.출력해야할 컬럼 제한
	FROM emp -- 1.먼저 테이블을 가져온다
	WHERE sal >= 2000 --2. 해당 조건에 맞는 행(튜플)을 가져옴
	ORDER BY 월급 DESC, 사원명 ASC; -- 4. 마지막 정렬 수행
	
-- 연결 연산자 : SELECT문 조회 시, 컬럼 사이에 특정한 문자를 넣을 때 사용
SELECT ename || '의 직책은 ' || job "사원 정보"
	FROM emp;
	
-- [실습문제1] 사원 이름이 S로 끝나는 사원 데이터를 모두 출력
SELECT * FROM EMP
	WHERE ENAME LIKE '%S';
-- [실습문제2] 30번 부서에 근무하고 있는 사원중, 직책이 SALESMAN인 사원의 사원번호
-- 이름, 직책, 급여, 부서번호 출력
SELECT ENAME, JOB, SAL, DEPTNO FROM EMP
	WHERE JOB = 'SALESMAN';
-- [실습문제3] 20번과 30번 부서에 근무하고 있는 사원중 급여가 2000 초과인 사원의
-- 사원번호, 이름, 직책, 급여, 부서번호 출력
SELECT ENAME, JOB, SAL, DEPTNO FROM EMP
	WHERE DEPTNO IN (20, 30)
	AND SAL >= 2000;
-- [실습문제4] 급여가 2000 이상 3000이하 범위 이하의 값을 가진 사원 정보 출력
SELECT * FROM EMP
	WHERE SAL NOT BETWEEN 2000 AND 3000;
-- [실습문제5] 사원 이름에 E가 포함되어 있는 30번 부서의 사원 중 급여가 1000 ~ 2000 사이가
-- 아닌 사원의 이름, 번호, 급여, 부서번호 출력
SELECT ENAME, JOB, SAL, DEPTNO FROM EMP
	WHERE ENAME LIKE '%E%'
	AND DEPTNO = 30
	AND SAL NOT BETWEEN 1000 AND 2000;
-- [실습문제6] 추가수당(comm) 이 존재하지 않고 상급자가 존재하고 직책이 MANAGER, CLERK인 사원 중
-- 사원 이름의 2번째 글자가 L이 아닌 사원의 모든 정보 출력
SELECT * FROM EMP
	WHERE COMM IS NULL
	AND MGR IS NOT NULL
	AND JOB IN ('MANAGER', 'CLERK')
	AND ENAME NOT LIKE '_L%';

-- SELECT 연습 문제 -- 9/11/13/17/18/19 현재 제외 
-- 1번
SELECT * FROM EMP
	WHERE COMM IS NOT NULL;
-- 2번
SELECT * FROM EMP
	WHERE COMM IS NULL;
--3번
SELECT * FROM EMP
	WHERE MGR IS NULL;
--4번
SELECT * FROM EMP
	ORDER BY SAL DESC;
--5번
SELECT * FROM EMP
	ORDER BY SAL, COMM DESC;
--6번
SELECT EMPNO, ENAME, JOB, HIREDATE FROM EMP
	ORDER BY HIREDATE;
--7번
SELECT EMPNO, ENAME FROM EMP
	ORDER BY EMPNO DESC;
--8번
SELECT EMPNO, HIREDATE, ENAME, SAL FROM EMP
	ORDER BY DEPTNO, HIREDATE DESC;
-- 9번 오늘 날짜에 대한 정보 조회
SELECT SYSDATE
FROM dual; -- 더미 테이블 'dual' 을 꺼내옴.

--10번
SELECT EMPNO, ENAME, SAL FROM EMP;
--12번
SELECT ENAME, HIREDATE FROM EMP;
--13번 EMP 테이블에서 9월에 입사한 직원의 정보 조회
SELECT * FROM EMP
	WHERE EXTRACT (MONTH FROM hiredate) = 9;
--14번
SELECT * FROM EMP
	WHERE HIREDATE BETWEEN '81/01/01' AND '81/12/31';

SELECT * FROM EMP --방법 2
	WHERE EXTRACT (YEAR FROM HIREDATE) = 1981;

--15번
SELECT * FROM EMP
	WHERE ENAME LIKE '%E';
--16번
SELECT * FROM EMP
	WHERE ENAME LIKE '__R%';
-- 17번 EMP테이블에서 사번 사원명 입사일 입사일로부터 40년 되는 날짜 조회
SELECT empno, ename, hiredate, ADD_MONTHS(HIREDATE, 12 * 40) -- 특정 날짜에 개월 수를 더해 날짜를 계산
	FROM EMP;

-- 18번 EMP테이블에서 입사일로부터 38년 이상 근무한 직원의 정보 조회**

-- 19번 오늘 날짜에서 년도만 추출**
SELECT EXTRACT (YEAR FROM sysdate)
FROM dual;
