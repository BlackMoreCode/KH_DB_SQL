-- DML (Data Manipulation Language) : Insert(입력), Update(수정), Delete(삭제)
-- 연습용 테이블 생생하기

-- DDL 명령어로 일단 테이블 생성부터.
CREATE TABLE DEPT_TEMP
AS SELECT * FROM dept;

SELECT * FROM DEPT_TEMP;
SELECT * FROM DEPT;

-- 테이블에 데이터를 추가하는 INSERT문
-- 방법1: INSERT INTO 테이블명(컬럼명...) VALUES(데이터...)
INSERT INTO DEPT_TEMP(deptno, dname, loc) VALUES (50, 'DATABASE', 'SEOUL');
-- 방법2: 컬럼명 제외하고 넣어도 된다. 다만 열 정보를 안주니까 정확하게 맞춰서 넣어야한다.
INSERT INTO DEPT_TEMP VALUES (60, 'BACKEND', 'BUSAN');

-- 이렇게 넣으면 특정 컬럼 (deptno) 만 넣으므로, 안넣은 부분들은 NULL값이 생긴다.
INSERT INTO DEPT_TEMP(deptno) VALUES (70);

INSERT INTO DEPT_TEMP VALUES (80, 'FRONTEND', 'INCHUN');
INSERT INTO DEPT_TEMP(dname, loc) VALUES ('APP', 'DAEGU');

INSERT INTO DEPT VALUES (50, 'BACKEND', 'BUSAN');

DELETE FROM DEPT_TEMP
WHERE deptno = 80;

INSERT INTO DEPT_TEMP VALUES (70, '웹개발', '');

CREATE TABLE EMP_TEMP
AS SELECT *
FROM emp
WHERE 1 != 1

SELECT * FROM EMP_TEMP;

INSERT INTO EMP_TEMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
	VALUES (9001, 'JOJO', 'PD', NULL, '2020/01/01', 9900, 1000, 50);

INSERT INTO EMP_TEMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
	VALUES (9002, 'DIO', 'MC', NULL, TO_DATE('2021/01/02', 'YYYY/MM/DD'), 9900, 1000, 50);

INSERT INTO EMP_TEMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
	VALUES (9003, 'PUCCI', 'MC', NULL, SYSDATE, 9000, 1000, 50);
	

SELECT * FROM DEPT_TEMP;

INSERT INTO dept_temp(deptno, dname, loc) VALUES (80, 'FRONTEND', 'SUWON');
ROLLBACK;

UPDATE DEPT_TEMP
	SET dname = 'WEB-PROGRAM',
		loc = 'SUWON'
	WHERE deptno = 70;

DELETE TABLE DEPT_TEMP
	WHERE deptno = 70;
