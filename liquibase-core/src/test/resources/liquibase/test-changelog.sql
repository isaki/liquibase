--liquibase formatted sql

--changeset Erzsebet:1578520961284-1
CREATE TABLE ACCOUNT (ACCT_NUM NUMBER(*, 0), AMOUNT NUMBER(10, 2));

--changeset Erzsebet:1578520961284-2
CREATE TABLE PRIMARY_TABLE (NULLABLECOL VARCHAR2(20 BYTE), NOTNULLCOL VARCHAR2(20 BYTE), PKCOL VARCHAR2(20 BYTE), UQCOL NUMBER(*, 0), INCCOL NUMBER(*, 0), DEFVALCOL VARCHAR2(20 BYTE) DEFAULT 'defaultVal', NUMVALCOL NUMBER(*, 0) DEFAULT 22, DATEVALCOL date DEFAULT TO_DATE('2014-08-11', 'YYYY-MM-DD'), COMPVALCOL NUMBER DEFAULT 1*22, IDXUNCLUSTEREDCOL NUMBER, COMMENTCOL VARCHAR2(20 BYTE));
COMMENT ON COLUMN PRIMARY_TABLE.COMMENTCOL IS 'This is a remark.';

--changeset Erzsebet:1578520961284-3
CREATE OR REPLACE TRIGGER TRIGGER1
AFTER UPDATE OR DELETE ON "PROSCHEMA".ACCOUNT
DECLARE
   v_transaction VARCHAR2(10);
BEGIN
   -- determine the transaction typ
   v_transaction := CASE  
         WHEN UPDATING THEN 'UPDATE'
         WHEN DELETING THEN 'DELETE'
   END;
   -- tell the world
   DBMS_OUTPUT.PUT_LINE('Hello Beautiful World!');
END;
/

--changeset Erzsebet:1578520961284-4
CREATE OR REPLACE FORCE VIEW VIEW1 (AMOUNT) AS SELECT AMOUNT FROM "PROSCHEMA"."ACCOUNT";

--changeset Erzsebet:1578520961284-5
CREATE SYNONYM PRIVATETABLESYN FOR PRIMARY_TABLE;

--changeset Erzsebet:1578520961284-6
CREATE OR REPLACE PROCEDURE             "PROC_HELLO_WORLD" AS 
BEGIN
  DBMS_OUTPUT.PUT_LINE('Hello Beautiful World!!');
END PROC_HELLO_WORLD;
/

--changeset Erzsebet:1578520961284-7
CREATE TABLE SUPPLIERS (SUPPLIER_ID NUMBER(4, 0), SUPPLIER_NAME VARCHAR2(50 BYTE));

--changeset Erzsebet:1578520961284-8
CREATE TABLE TABLECHANGELOG3 (NULLABLECOL VARCHAR2(20 BYTE));

--changeset Erzsebet:1578520961284-9
ALTER TABLE SUPPLIERS ADD CONSTRAINT CHECK_SUPPLIER_ID CHECK (supplier_id BETWEEN 100 and 9999);

--changeset Erzsebet:1578520961284-10
CREATE OR REPLACE FORCE VIEW VIEWCHANGELOG3 (AMOUNT) AS SELECT AMOUNT FROM "PROSCHEMA"."ACCOUNT";

--changeset Erzsebet:1578520961284-11
CREATE OR REPLACE FUNCTION             "FUNC_COMPUTE_TAX"(PRICE IN NUMBER) 
  RETURN NUMBER AS 
   BEGIN
		  RETURN PRICE * 08.25;
  END FUNC_COMPUTE_TAX;
/

--changeset Erzsebet:1578520961284-12
CREATE PUBLIC SYNONYM PUBLICTABLESYN FOR PRIMARY_TABLE;

--changeset Erzsebet:1578520961284-13
CREATE OR REPLACE PACKAGE             "PKG1" AS
	PROCEDURE add_test (col1_in NUMBER, col2_in CHAR)
	PROCEDURE del_test (col1_in NUMBER)
END PKG1;
/

--changeset Erzsebet:1578520961284-14
CREATE OR REPLACE PACKAGE BODY             "PKG1" AS
	PROCEDURE add_test(col1_in IN NUMBER,col2_in IN CHAR) AS
		BEGIN
			INSERT INTO test VALUES (col1_in,col2_in);
		END add_test;
	
	PROCEDURE del_test(col1_in IN NUMBER) AS
		  BEGIN
		   DELETE FROM test WHERE col1_in = col1;
		  END del_test;
END PKG1;
/

