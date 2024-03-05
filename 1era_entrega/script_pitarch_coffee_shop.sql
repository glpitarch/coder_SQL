-- ----------------------------------------- --
-- ----- DROP, CREATE AND USE DATABASE ----- --
-- ----------------------------------------- --

DROP DATABASE IF EXISTS coffee_shop;

CREATE DATABASE coffee_shop;

USE coffee_shop;

-- --------------------------- --
-- ----- TABLES CREATION ----- --
-- --------------------------- --

-- CUSTOMER TABLE --
CREATE TABLE CUSTOMER (
	ID_CUSTOMER INT PRIMARY KEY AUTO_INCREMENT,
    FIRST_NAME VARCHAR(50) NOT NULL,
    LAST_NAME VARCHAR(50) NOT NULL,
    PHONE_NUMBER VARCHAR(20) NOT NULL
);

-- EMPLOYEE TABLE --
CREATE TABLE EMPLOYEE (
	ID_EMPLOYEE INT PRIMARY KEY AUTO_INCREMENT,
    ID_STORE INT,
    FIRST_NAME VARCHAR(50) NOT NULL,
    LAST_NAME VARCHAR(50) NOT NULL,
    EMAIL VARCHAR(100) NOT NULL,
    PHONE_NUMBER VARCHAR(20) NOT NULL
);

-- STORE OWNER TABLE --
CREATE TABLE STORE_OWNER (
	ID_STORE_OWNER INT PRIMARY KEY AUTO_INCREMENT,
    ID_STORE INT,
    FIRST_NAME VARCHAR(50) NOT NULL,
    LAST_NAME VARCHAR(50) NOT NULL,
    EMAIL VARCHAR(100) NOT NULL,
    PHONE_NUMBER VARCHAR(20) NOT NULL
);

-- SUPPLIER TABLE --
CREATE TABLE SUPPLIER (
	ID_SUPPLIER INT PRIMARY KEY AUTO_INCREMENT,
    BRAND_NAME VARCHAR(50) NOT NULL,
    ADDRESS VARCHAR(50) NOT NULL,
    EMAIL VARCHAR(100) NOT NULL,
    PHONE_NUMBER VARCHAR(20) NOT NULL
);

-- PRODUCT TABLE --
CREATE TABLE PRODUCT (
	ID_PRODUCT INT PRIMARY KEY AUTO_INCREMENT,
    CATEGORY VARCHAR(50) NOT NULL,
    PRODUCT_NAME VARCHAR(50) NOT NULL,
    STOCK INT DEFAULT 0,
    PRICE DECIMAL(8, 2) NOT NULL
);

-- STORE TABLE --
CREATE TABLE STORE (
	ID_STORE INT PRIMARY KEY AUTO_INCREMENT,
    ID_STORE_OWNER INT,
    ID_EMPLOYEE INT,
    ID_PRODUCT INT,
    ADDRESS VARCHAR(50) NOT NULL
);

-- CUSTOMER ORDER TABLE --
CREATE TABLE CUSTOMER_ORDER (
	ID_ORDER INT PRIMARY KEY AUTO_INCREMENT,
    ID_STORE INT,
    ID_CUSTOMER INT,
    ORDER_TIMESTAMP DATETIME NOT NULL,
    PICKUP DATETIME NOT NULL,
    PAYMENT_METHOD VARCHAR(50) NOT NULL,
    TOTAL_ORDER_PRICE DECIMAL(8, 2) NOT NULL,
    FULFILLED BOOLEAN DEFAULT FALSE
);

-- ORDER SUMMARY TABLE --
CREATE TABLE ORDER_SUMMARY (
	ID_ORDER_SUMMARY INT PRIMARY KEY AUTO_INCREMENT,
    ID_ORDER INT
);

-- --------------------------- --
-- ----- JUNCTION TABLES ----- --
-- --------------------------- --

-- PRODUCT DETAIL TABLE --
CREATE TABLE PRODUCT_DETAIL (
	ID_PRODUCT_DETAIL INT PRIMARY KEY AUTO_INCREMENT,
    ID_ORDER_SUMMARY INT,
    ID_PRODUCT INT,
    QUANTITY INT NOT NULL,
    TOTAL_PRICE DECIMAL(8, 2) NOT NULL
);

-- STORE STOCK TABLE --
CREATE TABLE STORE_STOCK (
	ID_STORE_STOCK INT PRIMARY KEY AUTO_INCREMENT,
    ID_STORE INT,
    ID_PRODUCT INT,
    STOCK INT DEFAULT 0
);

-- PRODUCT SUPPLIER TABLE --
CREATE TABLE PRODUCT_SUPPLIER (
	ID_PRODUCT_SUPPLIER INT PRIMARY KEY AUTO_INCREMENT,
    ID_SUPPLIER INT,
    ID_PRODUCT INT,
    REATIL_PRICE DECIMAL(8, 2) NOT NULL,
    WHOLESALE_PRICE DECIMAL(8, 2) NOT NULL
);

-- ----------------------------------- --
-- ----- FOREIGN KEYS DEFINITION ----- --
-- ----------------------------------- --

-- EMPLOYEE TABLE --
ALTER TABLE EMPLOYEE
	ADD CONSTRAINT FK_EMPLOYEE_STORE
    FOREIGN KEY (ID_STORE) REFERENCES STORE(ID_STORE);
    
-- STORE OWNER TABLE --
ALTER TABLE STORE_OWNER
	ADD CONSTRAINT FK_OWNER_STORE
    FOREIGN KEY (ID_STORE) REFERENCES STORE(ID_STORE);
    
-- STORE TABLE --
ALTER TABLE STORE
	ADD CONSTRAINT FK_STORE_PRODUCT
    FOREIGN KEY (ID_PRODUCT) REFERENCES PRODUCT(ID_PRODUCT);
    
-- CUSTOMER ORDER TABLE --
ALTER TABLE CUSTOMER_ORDER
	ADD CONSTRAINT FK_ORDER_STORE
    FOREIGN KEY (ID_STORE) REFERENCES STORE(ID_STORE);
    
ALTER TABLE CUSTOMER_ORDER
	ADD CONSTRAINT FK_ORDER_CUSTOMER
    FOREIGN KEY (ID_CUSTOMER) REFERENCES CUSTOMER(ID_CUSTOMER);
    
-- ORDER SUMMARY TABLE --
ALTER TABLE ORDER_SUMMARY
	ADD CONSTRAINT FK_SUMMARY_ORDER
    FOREIGN KEY (ID_ORDER) REFERENCES CUSTOMER_ORDER(ID_ORDER);
    
-- PRODUCT DETAIL TABLE --
ALTER TABLE PRODUCT_DETAIL
	ADD CONSTRAINT FK_DETAIL_SUMMARY
    FOREIGN KEY (ID_ORDER_SUMMARY) REFERENCES ORDER_SUMMARY(ID_ORDER_SUMMARY);
    
ALTER TABLE PRODUCT_DETAIL
	ADD CONSTRAINT FK_DETAIL_PRODUCT
    FOREIGN KEY (ID_PRODUCT) REFERENCES PRODUCT(ID_PRODUCT);
    
-- STORE STOCK TABLE --
ALTER TABLE STORE_STOCK
	ADD CONSTRAINT FK_STOCK_STORE
    FOREIGN KEY (ID_STORE) REFERENCES STORE(ID_STORE);
    
ALTER TABLE STORE_STOCK
	ADD CONSTRAINT FK_STOCK_PRODUCT
    FOREIGN KEY (ID_PRODUCT) REFERENCES PRODUCT(ID_PRODUCT);
    
-- PRODUCT SUPPLIER TABLE --
ALTER TABLE PRODUCT_SUPPLIER
	ADD CONSTRAINT FK_PRODUCT_SUPPLIER_PRODUCT
    FOREIGN KEY (ID_PRODUCT) REFERENCES PRODUCT(ID_PRODUCT);
    
ALTER TABLE PRODUCT_SUPPLIER
	ADD CONSTRAINT FK_PRODUCT_SUPPLIER_SUPPLIER
    FOREIGN KEY (ID_SUPPLIER) REFERENCES SUPPLIER(ID_SUPPLIER);