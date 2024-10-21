-- DDL(Date Definition Language) : 데이터베이스의 데이터를 보관하기 위해 
-- 제공되는 생성, 변경, 삭제 관련 기능을 수행
-- CREATE : 새로운 데이터베이스 개체(entity)를 생성 - 테이블, 뷰, 인덱스
-- ALTER : 기존 데이터베이스의 개체를 수정
-- DROP : 기존 데이터베이스의 개체를 삭제.
-- TRUNCATE : 모든 데이터를 삭제하지만 테이블 구조는 남겨둠
-- TABLE 이란? 데이터베이스의 기본 데이터 저장 단위인 테이블은 
-- 사용자가 접근 가능한 데이터를 보유하며 레코드(행)와 컬럼(열)으로 구성
-- 테이블과 테이블의 관계를 표현하는데 외래키 (FK)를 사용

CREATE TABLE emp_ddl(
	empno NUMBER(4), -- 숫자형 데이터 타입, 4자리를 선언/확보. 최대크기로 38자리까지의 숫자 지정
	ename VARCHAR2(10), -- 가변문자 데이터 타입, 4000바이트; 실제 입력된 크기 만큼 차지
	job VARCHAR2(9),
	mgr NUMBER(4),
	hiredate DATE, -- 날짜와 시간을 지정하는 날짜형 데이터 타입
	sal NUMBER(7, 2), -- 전체 번위가 7자리에 소수점 이하가 2자리 (정수부는 5자리)
	comm NUMBER(7, 2),
	deptno NUMBER(2)
);

SELECT * FROM emp_ddl;

-- 기존 테이블의 열 구조와 데이터를 복사하여 새 테이블 생성
CREATE TABLE dept_ddl
	AS SELECT * FROM dept;

SELECT * FROM dept_ddl;

CREATE TABLE emp_alter
	AS SELECT * FROM emp;
	
SELECT * FROM emp_alter;

-- 열 이름을 추가하는 add : 기존 테이블에 새로운 컬럼을 추가하는 명령어
-- 컬럼 값은 NULL로 입력
ALTER TABLE emp_alter
	ADD HP varchar2(20);


-- 열 이름을 변경하는 rename
ALTER TABLE emp_alter
	RENAME COLUMN HP TO tel;

-- 열의 자료형을 변경하는 modify
-- 자료형 변경시 데이터가 이미 존재하는 경우 크기를 크게하는 경우는 문제가 되지 않으나
-- 크기를 줄이는 경우 저장되어 있는 데이터 크게에 따라 변경되지 않을 수 있음
ALTER TABLE emp_alter
	MODIFY empno NUMBER(5); 

-- 특정 열을 삭제하는 DROP
ALTER TABLE emp_alter
	DROP COLUMN tel;


-- 테이블 이름을 변경하는 RENAME
RENAME emp_alter TO emp_rename;
SELECT * FROM emp_rename;

-- 테이블의 데이터를 삭제하는 TRUNCATE : 테이블의 모든 데이터를 삭제; 테이블 구조에 영향 주지 않음
-- DDL 명령어 이기 때문에 ROLLBACK 불가.
DELETE FROM EMP_RENAME; -- DELETE는 DML 명령어. TRUNCATE는 DDL 명령어..
ROLLBACK; -- 얘는 TRUNCATE가 아닌 delete로 처리했으니까 롤백처리 가능
TRUNCATE TABLE EMP_RENAME;

-- 테이블을 삭제하는 DROP
DROP TABLE EMP_RENAME;
---------------------------------------------
-- 제약조건 : 데이터의 무결성 (정확하고 일관된 값)을 보장하기 위해 테이블에 설정되는 규칙
-- NOT NULL : 지정한 열에 값이 있어야 함
-- UNIQUE : 값이 유일해야 함; 단 NULL 허용
-- PRIMARY KEY(PK) : 유일해야하고 NULL이면 안됨
-- FOREIGN KEY (FK) : 다른 테이블의 열을 참조하여 존재하는 값만 입력 가능
-- CHECK :  설정한 조건식을 만족하는 데이터만 입력 가능
CREATE TABLE table_notnull (
	login_id varchar2(20) NOT NULL,
	login_pw varchar2(20) NOT NULL,
	tel varchar2(20)
);

SELECT * FROM TABLE_NOTNULL;

INSERT INTO TABLE_NOTNULL(LOGIN_ID, LOGIN_PW, tel)
	VALUES('Invoker', 'quaswexexort', NULL);
	
UPDATE TABLE_NOTNULL 
	SET LOGIN_PW = 'test1234'
WHERE LOGIN_ID = 'Invoker';

UPDATE TABLE_NOTNULL 
	SET tel = '12345678'
WHERE LOGIN_ID = 'Invoker';

-- 이미 만들어진 테이블에 제약조건 지정하기
ALTER TABLE TABLE_NOTNULL
	MODIFY tel NOT NULL;

-- UNIQUE 제약 조건 : 중복 허용하지 않는 특성 
CREATE TABLE table_unique (
	login_id varchar2(20) UNIQUE,
	login_pw varchar2(20) NOT null,
	tel varchar2(20)
);

INSERT INTO TABLE_UNIQUE (LOGIN_ID, LOGIN_PW, TEL)
	values('LUCIAN', 'CALTZ', '010-0000-1111');
	
INSERT INTO TABLE_UNIQUE (LOGIN_ID, LOGIN_PW, TEL)
	values('BENYA', 'idk', '010-1313-1111');
	
SELECT * FROM TABLE_UNIQUE;

-- 유일하게 하나만 있는 값 (Primary Key) : UNIQUE 와 NOT NULL 제약 조건을 모두 가짐
-- PK로 지정하면 자동으로 인덱스가 만들어짐 (PK를 통한 검색속도를 빠르게 하기 위함)
CREATE TABLE table_pk (
	login_id varchar2(20) PRIMARY KEY,
	login_pw varchar2(20) NOT NULL,
	tel varchar2(20)
);

INSERT INTO table_pk VALUES ('OSIRIS', 'YUGI', '123-1234-1234');
INSERT INTO table_pk VALUES ('OBELISK', 'YUGI', '123-1234-1234');
INSERT INTO table_pk VALUES ('RA', 'YUGI', '123-1234-1234');

-- 다른 테이블과 관계를 맺는 FOREIGN KEY
-- 서로 다른 테이블간 관계를 정의하는 데 사용하는 제약 조건 
-- 참조하고 있는 기본키의 데이터 타입과 일치해야 하며, 
-- 외래키에 참조되고 있는 기본키는 삭제 불가
CREATE TABLE dept_fk (
	deptno NUMBER(2) PRIMARY KEY,
	dname varchar2 (14),
	loc varchar2(13)
);

CREATE TABLE emp_fk (
	empno number(4) PRIMARY KEY,
	ename varchar2(10),
	job varchar2(9),
	mgr NUMBER(4),
	hiredate DATE,
	sal number(7, 2),
	comm NUMBER(7, 2),
	deptno number(2) REFERENCES dept_fk (deptno) -- 참조하겠다고 설정
);
INSERT INTO DEPT_FK VALUES(10, 'MASTER', 'SEOUL');

SELECT * FROM DEPT_FK;

INSERT INTO EMP_FK 
VALUES (2001, 'JOJO', 'STANDO', '1001', '2024/09/01', 2000, 1000, 10);

SELECT * FROM EMP_FK;

DELETE FROM EMP_FK
WHERE deptno = 10;

DELETE FROM DEPT_FK
WHERE deptno = 10;

-- 데이터 형태와 범위를 정하는 CHECK
-- ID 및 PW 등의 딜이 제한
-- 유효 범위값 확인 등에 사용
CREATE TABLE table_check(
	login_id varchar2(20) PRIMARY KEY,
	login_pw varchar2(20) CHECK(LENGTH(login_pw) > 6),
	tel varchar2(20)
);

INSERT INTO TABLE_CHECK
VALUES ('JOKER', '1234567', '999-9999-9999');

-- 기본값을 정하는 DEFAULT: 특정열에 저장할 값을 지정하지 않는 경우 기본값을 지정
CREATE TABLE table_default(
	login_id varchar2(20) PRIMARY KEY,
	login_pw varchar2(20) DEFAULT '1234567',
	tel varchar2(20)
);

INSERT INTO table_default
VALUES ('JOKER', NULL, '999-9999-9999');

INSERT INTO table_default (LOGIN_ID, tel)
VALUES ('BATMAN', '999-9999-9999');

SELECT * FROM TABLE_DEFAULT;

-- 데이터 사전 : 데이터베이스를 구성하고, 운영하는데 필요한 모든 벙보를 저장하는 특수한 테이블을 의미함
-- 데이터 사전에는 데이터베이스 메모리, 성능 , 사용자, 권한, 객체 등등의 정보가 포함된다
SELECT * FROM dict;

SELECT * FROM USER_INDEXES;

-- 인덱스 생성 : 오라클에서는 자동으로 생성해주는 인덱스(pk)외에 사용자가 직접 인덱스를 만들 때는
-- CREATE 문을 사용.
CREATE INDEX IDX_EMP_SAL ON EMP(sal); -- 

-- 인덱스 삭제
DROP INDEX IDX_EMP_SAL;

-- 테이블뷰
-- 뷰란? 가상 테이블로 부르는 뷰(view)는 하나 이상의 테이블을
-- 조회하는 SELECT문을 저장한 객체를 의미
-- SELECT * FROM VW_EMP20;

-- 인라인 뷰; 잘라서 검색을 가져옴 (1회용)
SELECT *
FROM (
	SELECT empno, ename, job, deptno
	FROM EMP
	WHERE deptno = 20
);

-- 검색을 하기위해 아예 테이블을 지정 조건으로 새로 만듬? (영구적으로 테이블 만듬)
CREATE VIEW vw_emp20
AS (SELECT empno, ename, job, deptno
	FROM EMP
	WHERE deptno = 20
);

SELECT * FROM vw_emp20;

-- 규칙에 따라 순번을 생성하는 시퀀스
-- 시퀀스 : 오라클 데이터베이스에서 특정 규칙에 맞는 연속 숫자를 생성하는 객체
CREATE TABLE dept_sequence
AS SELECT * 
	FROM dept
	WHERE 1 <> 1;
-- 시퀀스 생성하기
CREATE SEQUENCE seq_dept_sequence
INCREMENT BY 10
START WITH 10
MAXVALUE 90
MINVALUE 0
NOCYCLE
cache 2;

SELECT * FROM user_sequences;

INSERT INTO DEPT_SEQUENCE (deptno, dname, loc)
	VALUES (seq_dept_sequence.nextval, 'DATABASE', 'SEOUL');
INSERT INTO DEPT_SEQUENCE (deptno, dname, loc)
	VALUES (seq_dept_sequence.nextval, 'JAVA', 'BUSAN');


SELECT * FROM DEPT_SEQUENCE
ORDER BY deptno;

SELECT * FROM DBA_USERS;