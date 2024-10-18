-- 조인 : 여러 테이블을 하나의 테이블 처럼 사용하는 것
-- 이 때 필요한 것 PK (Primary Key) 와 테이블 간 공통 값인 FK (Foreign Key)
-- Join의 종류
-- Inner Join (동등 조인) : 두 테이블에서 일치하는 데이터만 선택
-- Left Join : 왼쪽 테이블의 모든 데이터와 일치하는 데이터 선택
-- Right Join : 오른쪽 테이블의 모든 데이터와 일치하는 데이터 선택

-- 간단 예시 : 카테시안의 곱
-- 2개의 테이블을 조인할 때 기준 열을 지정하지 않으면 모든 행 * 모든 행
SELECT * 
FROM emp, DEPT
ORDER BY empno;

-- 등가 조인: 일치하는 열이 존재; Inner 조인이라고도 함; 가장 일반적인 방식
-- 오라클 조인 방식
SELECT empno, ename, job, sal, e.deptno
FROM EMP e, DEPT d 
WHERE e.DEPTNO = d. DEPTNO
ORDER BY empno;

-- ANSI 조인 (위의 오라클 조인 방식과 같은 결과를 만드는 쿼리)
SELECT empno, ename, job, sal, e.deptno
FROM EMP e JOIN DEPT d 
ON e.DEPTNO = d.DEPTNO;
ORDER BY empno;

-- DEPT 테이블과 emp 테이블은 1:N 관계를 가짐 (부서 테이블의 부서번호에는 여러명의 사원이 올 수 있음)
SELECT empno, ename, sal, d.deptno, dname, loc
FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
WHERE sal >= 3000;

-- EMP 테이블 별칭을 E로, DEPT테이블 별칭은 D로 하여 다음과 같아
-- 등가 조인을 했을 때 급여가 2500 이하이고
-- 사원번호가 9999 이하인 사원의 정보가 출력되도록 작성
-- Oracle Join / ANSI Join 중 택 1
SELECT empno, ename, sal, d.deptno, dname, loc
FROM EMP e JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
WHERE e.sal <= 2500 AND e.empno <= 9999
ORDER BY empno;

--비등가 조인 : 동일한 컬럼이 존재하지 않는 경우에서 조인할 때 사용; 일반적인 방식은 아님.
SELECT * FROM SALGRADE; -- 각 급여에 대한 등급 표시

SELECT ename, sal, grade
FROM EMP e JOIN SALGRADE s
ON sal BETWEEN s.LOSAL AND s.HISAL; -- 급여와 losal~hisal 비등가 조인

-- 자체 조인 (SELF JOIN) : 자기 자신의 테이블과 조인하는 것을 말한다 (같은 테이블을 두번 사용)
SELECT e1.empno AS "사원 번호", e1.ename AS "사원 이름", e1.mgr,
	e2.empno AS "상관 사원번호",
	e2.ename AS "상관 이름"
FROM EMP e1 JOIN EMP e2
ON e1.mgr = e2.empno; -- 상관의 번호도 결국 그 상관의 사원번호니까 이렇게 건다.

-- 외부 조인 (Outer Join) : Left, Right, Full; 
SELECT e.ename, e.deptno, d.dname
FROM EMP e FULL OUTER JOIN DEPT d
ON e.DEPTNO = d.DEPTNO
ORDER BY e.DEPTNO;

-- NATURAL JOIN : 등가 조인 비슷하지만 WHERE 조건절이 없이 사용 
-- 두 테이블에서 동일한 이름이 있는 열을 자동으로 찾아서 조인 해줌.
SELECT empno, ename, deptno, dname
FROM emp e NATURAL JOIN dept d;

-- JOIN ~ USING : 등가 조인을 대신하는 방법
SELECT e.empno, e.ename, e.job, deptno, d.dname, d.loc
FROM EMP e JOIN DEPT d USING(deptno)
ORDER BY e.empno;

-- Q1. 급여가 2000 초과인 사원들의 정보 출력 (부서번호, 부서이름, 사원번호, 사원이름, 급여)
-- JOIN~ON, NATURAL JOIN, JOIN~USING 아무거나 사용 가능
SELECT e.empno, e.ename, e.sal, deptno, d.dname
FROM EMP e JOIN DEPT d USING(deptno)
WHERE e.sal >= 2000
ORDER BY e.sal;

-- Q2. 각 부서별 평균 급여, 최대 급여, 최소 급여, 사원 수 출력 
-- (부서번호, 부서이름, 최대 급여, 최소 급여, 사원 수 출력)
SELECT d.deptno, d.dname,
	ROUND(AVG(e.sal)) AS "평균 급여",
	MAX(e.sal) AS "최대 급여",
	MIN(e.sal) AS "최소 급여",
	count(*) AS "사원 수"
FROM EMP e JOIN DEPT d
ON e.deptno = d.deptno
GROUP BY d.deptno, d.dname

-- Q3. 모든 부서 정보와 사원 정보 출력 (부서 번호와 부서 이름순으로 정렬), 모든 부서가 나와야한다.
-- OUTER JOIN 사용
SELECT * FROM EMP e FULL OUTER JOIN DEPT d
ON e.deptno = d.deptno
ORDER BY e.deptno, d.dname;
