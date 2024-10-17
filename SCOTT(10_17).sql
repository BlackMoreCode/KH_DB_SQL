-- 다중행 함수 : 여러 행에 대해서 함수가 적용되어 하나의 결과를 나타내는 함수
SELECT deptno, sum(sal)
FROM emp
GROUP BY deptno;
-- 다중행 함수의 종류
-- SUM() : 지정한 데이터의 합을 반환
-- COUNT() : 지정한 데이터의 개수를 반환
-- MAX() : 최대값 반환
-- MIN() : 최소값 반환
-- AVG() : 평균값 반환
-- 집계함수(다중행 함수) NULL 값이 포함되어 있으면 무시

SELECT SUM(DISTINCT sal), sum(sal)
FROM EMP;

--모든 사원에 대해서 급여와 추가 수당의 합을 구하기
SELECT SUM(SAL), SUM(COMM)
FROM EMP;

-- 20번 부서의 모든 사원에 대해서 급여와 추가 수당의 합을 구하기
SELECT sum(sal), sum(comm), DEPTNO 
FROM emp
-- WHERE deptno = 20; 기존에 배웠던 방식; 위에 DEPTNO 안 적고..
GROUP BY deptno;

-- 각 직책별로 급여와 추가 수당의 합 구하기
SELECT sum(sal) AS "급여", sum(comm) AS "성과급", JOB AS "직책"
FROM EMP
GROUP BY job;

-- 각 부서별 최대(MAX) 급여 출력
SELECT  
	deptno AS "부서", 
	MAX(sal) AS "최대급여"
FROM EMP
GROUP BY deptno;

-- 위를 group by 없이 출력한다면?
SELECT max(sal) FROM EMP WHERE deptno = 10
UNION ALL
SELECT max(sal) FROM EMP WHERE deptno = 20
UNION ALL
SELECT max(sal) FROM EMP WHERE deptno = 30;

-- 부서 번호가 20인 사원중 입사일이 가장 최근 입사자 정보 출력
SELECT max(hiredate)
FROM emp e
WHERE e.deptno = 20;

-- 서브 쿼리 사용하기 : 각 부서별 최대(MAX) 급여 출력; 사원번호, 이름, 직책, 부서번호 출력
SELECT  -- 기존 시도 방식
	deptno AS "부서", 
	MAX(sal) AS "최대급여"
FROM EMP
GROUP BY deptno;

SELECT empno, ename, job, deptno
FROM EMP e 
WHERE sal =(
	SELECT MAX(sal)
	FROM EMP e2
	WHERE e2.deptno = e.deptno
);

-- Having절 : 그룹화된 대상에 대한 출력 제한
-- GROUP BY 존재할 때만 사용 가능
-- WHERE 조건절과 동일하게 동작하지만, 그룹화된 결과 값의 범위를 제한할 때 사용
SELECT deptno, job, avg(sal)
FROM EMP
GROUP BY DEPTNO, JOB
	HAVING avg(sal) >= 2000
ORDER BY deptno;

-- where 절과 having 절 함께 사용하기
SELECT deptno, job, avg(sal) 	-- 5. 출력할 열 제한
FROM EMP 						-- 1. 먼저 테이블을 가져옴
WHERE sal <= 3000				-- 2. 급여기준으로 행제한을 이미 걸었다; 3000 이하로만
GROUP BY deptno, JOB			-- 3. 부서별, 직책별 그룹화 
	HAVING avg(sal) >= 2000		-- 4. 그룹내에서 행 제한
ORDER BY deptno;				-- 6. 그룹별 직책별 오름차순 정렬 

-- HAVING 절을 사용하여 EMP 테이블의 부서별 직책의 평균 급여가 500 이상인
-- 사원들의 부서 번호, 직책, 부서별 직책의 평균급여 출력
SELECT deptno, job, avg(sal)
FROM EMP
GROUP BY deptno, JOB 
	HAVING avg(sal) >= 500
ORDER BY deptno;

-- EMP 테이블을 이용하여 부서번호, 평균급여, 최고급여, 최저급여, 사원수를 출력
-- 다만 평균 급여를 출력할때는 소수점 제외하고 부서 번호별로 출력
SELECT deptno, 
	TRUNC(AVG(sal)), 
	max(sal), 
	min(sal)
FROM EMP
GROUP BY deptno
ORDER BY deptno;
-- 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원을 출력
SELECT job, count(*)
FROM EMP
group BY job
	HAVING count(*) >= 3;
-- 사원들의 입사 연도를 기준으로 부서별로 몇 명이 입사했는지 출력
SELECT 
	TO_CHAR(hiredate, 'YYYY') AS "입사년도", 
	deptno, 
	count(*) AS "사원 수"
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY'), deptno -- 아니면 EXTRACT (YEAR FROM hiredate) 쓰던가
ORDER BY TO_CHAR(hiredate, 'YYYY');
-- 추가 수당을 받는 사원수와 받지 않는 사원수를 출력 (O, X로 표기 필요)
--SELECT NVL2(comm, 'O', 'X') AS "추가수당 여부", 
--	count (*) AS "사원 수"
--FROM emp
--GROUP BY NVL2(comm, 'O', 'X');

SELECT -- 이 경우는 NULL인 경우도 고려한다.
	CASE
		WHEN comm IS NULL THEN 'X'
		WHEN comm = 0 THEN 'X'
		ELSE 'O'
	END AS "추가수당",
	count(*) AS "사원 수"
FROM emp	
GROUP BY CASE
		WHEN comm IS NULL THEN 'X'
		WHEN comm = 0 THEN 'X'
		ELSE 'O'
	END
ORDER BY "추가수당";

-- 각 부서의 입사 연도별 사원 수, 최고 급여, 급여 합, 평균 급여를 출력
SELECT DEPTNO, 
	TO_CHAR(hiredate, 'YYYY') AS "입사년도",
	count(*) AS "사원 수",
	max(sal) AS "최고급여",
	trunc(avg(sal)) AS "평균급여",
	sum(sal) AS "급여합계"
FROM emp
GROUP BY deptno, TO_CHAR(hiredate, 'YYYY')
ORDER BY deptno, TO_CHAR(hiredate, 'YYYY');

-- 그룹화 관련 기타 함수 : ROLLUP 그룹화 데이터의 합계를 출력할 때 유용
SELECT NVL(to_char(deptno), '전체 부서') AS "부서번호",
	NVL(to_char(job), '부서별 직책') AS "직책",
	COUNT(*) AS "사원 수",
	MAX(sal) AS "최대급여",
	MIN(sal) AS "최소급여",
	ROUND(AVG(sal)) AS "평균급여"
FROM emp
GROUP BY ROLLUP (deptno, job)
ORDER BY "부서번호", "직책";

-- 집합 연산자 : 2개 이상의 쿼리 결과를 하나로 결합하는 연산자(수직적 처리)
-- 여러개의 SELECT문을 하나로 연결하는 기능
-- 집합 연산자로 결합하는 결과의 컬럼은 데이터 타입이 동일해야한다 (열의 개수도 동일해야한다!)

SELECT empno, ename, sal, deptno
FROM EMP
WHERE deptno = 10;
SELECT empno, ename, sal, deptno
FROM EMP
WHERE deptno = 20;
SELECT empno, ename, sal, deptno
FROM EMP
WHERE deptno = 30;

-- 교집합 : INTERSECT
-- 여러개의 SQL문의 결과에 대한 교집합을 반환
SELECT empno, ename, sal
FROM EMP
WHERE sal > 1000 -- 1001~
INTERSECT -- 1001~1999
SELECT empno, ename, sal
FROM EMP
WHERE sal < 2000; -- ~1999

-- 차집합 : MINUS, 중복행에 대한 결과를 하나의 결과를 보여줌
SELECT empno, ename, sal
FROM emp
MINUS
SELECT empno, ename, sal
FROM emp
WHERE sal > 2000;


