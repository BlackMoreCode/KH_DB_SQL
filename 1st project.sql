-- 테이블 생성용 쿼리들
CREATE TABLE ACC_INFO(
	user_id varchar2(20) PRIMARY KEY,
	user_pw varchar2(20) CHECK(LENGTH(user_pw) > 7),
	user_name varchar2(15) NOT NULL,
	user_phone char(13) UNIQUE,
	join_date DATE DEFAULT SYSDATE,
	auth_lv NUMBER(1) NOT NULL,
	store_id varchar2(20) REFERENCES STORE (store_id)
);

CREATE TABLE INV_ORDER(
	menu_name varchar2(10) PRIMARY KEY,
	price number(5) NOT NULL,
	category varchar2(10) CHECK (category IN ('버거', '사이드', '음료'))
);

CREATE TABLE INV(
	menu_name varchar2(20) REFERENCES INV_ORDER(menu_name),
	store_id varchar2(20) REFERENCES STORE(store_id),
	PRIMARY KEY (menu_name, store_id), --
	price number(5) NOT NULL,
	stock number(4) NOT NULL,
	descr varchar2(30)
);

CREATE TABLE STORE(
	store_id varchar2(20) PRIMARY KEY,
	sales number(10) NOT NULL,
	capital number(10) NOT NULL
);

CREATE TABLE ORDER_RECORD(
	order_code varchar(20) PRIMARY KEY,
	order_list varchar(20) NOT NULL,
	order_time DATE NOT NULL,
	order_price number(10) NOT NULL,
	user_id varchar(20) REFERENCES ACC_INFO(user_id),
	store_id varchar(20) REFERENCES STORE(store_ID)
);

--DROP TABLE INV;
SELECT * FROM INV;