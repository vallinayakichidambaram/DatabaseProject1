/*
Sample Project - Database for an eCommerce Website
To know more about the schema, refer ER Diagram attached

The file has DDL scripts for creating tables in the schema
Total tables - 10

*/
--Table for storing Main Category Details - T_MAINCATEGORY

CREATE TABLE T_MAINCATEGORY
(
  MAIN_CAT_NO INTEGER PRIMARY KEY,
  MAIN_CAT_NAME VARCHAR(255) NOT NULL,
  MAIN_CAT_DESCRIPTION VARCHAR(255),
  MAIN_CAT_STATUS BOOLEAN,
  MAIN_CAT_CREATED DATE,
  MAIN_CAT_UPDATED DATE
 );
 
 /*
 Under each main category, there will be a number of subcategories
 
 Ex - Under Electronics - we have Mobiles, Laptops, Accessories, etc
 Electronics - Main Category
 Mobiles, Laptops - Sub Categories
 
 Table for storing Sub Categories - T_SUBCATEGORY
 
 */
CREATE TABLE T_SUBCATEGORY
(
  SUB_CAT_NO INTEGER PRIMARY KEY,
  SUB_CAT_NAME VARCHAR(255) NOT NULL,
  MAIN_CAT_NO INTEGER NOT NULL,
  SUB_CAT_DESCRIPTION VARCHAR(255),
  SUB_CAT_STATUS BOOLEAN,
  SUB_CAT_CREATED DATE,
  SUB_CAT_UPDATED DATE,
  FOREIGN KEY(MAIN_CAT_NO) REFERENCES T_MAINCATEGORY(MAIN_CAT_NO)
  );
  
/*
Table for storing the Product details - T_PRODUCTS

Products are tagged under Sub Categories

*/
CREATE TABLE T_PRODUCTS
(
  PRODUCT_NO INTEGER PRIMARY KEY,
  PRODUCT_NAME VARCHAR(255) NOT NULL,
  SUB_CAT_NO INTEGER NOT NULL,
  PRODUCT_DESCRIPTION VARCHAR(255),
  PRODUCT_STATUS BOOLEAN,
  PRODUCT_CREATED DATE NOT NULL,
  PRODUCT_UPDATED DATE NOT NULL,
  FOREIGN KEY(SUB_CAT_NO) REFERENCES T_SUBCATEGORY(SUB_CAT_NO)
  );
/*

Table for storing Supplier Details - T_SUPPLIERS

*/  
  
  
  CREATE TABLE T_SUPPLIERS
(
  SUPPLIER_NO INTEGER PRIMARY KEY,
  SUPPLIER_NAME VARCHAR(255) NOT NULL,
  SUPPLIER_ADDRESS VARCHAR(255),
  SUPPLIER_TYPE VARCHAR(255),
  SUPPLIER_CITY VARCHAR(255),
  SUPPLIER_PINCODE INTEGER NOT NULL,
  SUPPLIER_STATUS BOOLEAN,
  SUPPLIER_CREATED DATE,
  SUPPLIER_UPDATED DATE
  );
  
/* 
 Table to store the Supplier product relation - T_PRODUCT_SUPPLIER
 
 A Product can have multiple suppliers in a location and a Supplier can sell many products under his/her name

*/  
  
  CREATE TABLE T_PRODUCT_SUPPLIER
(
  RELATION_NO INTEGER NOT NULL,
  PRODUCT_NO INTEGER NOT NULL,
  SUPPLIER_NO INTEGER NOT NULL,
  RELATION_STATUS BOOLEAN,
  PRODUCT_PRICE INTEGER NOT NULL,
  DELIVERY_CHARGE INTEGER NOT NULL,
  RELATION_CREATED DATE NOT NULL,
  RELATION_UPDATED DATE NOT NULL,
  FOREIGN KEY PRODUCT_NO REFERENCES T_PRODUCTS(PRODUCT_NO),
  FOREIGN KEY SUPPLIER_NO REFERENCES T_SUPPLIERS(SUPPLIER_NO)
  );
  
/*
Table for storing Customer details - T_CUSTOMERS
*/  
  
  
  CREATE TABLE T_CUSTOMERS
(
  CUSTOMER_ID INTEGER PRIMARY KEY,
  CUSTOMER_NAME VARCHAR(255) NOT NULL,
  CUSTOMER_EMAIL VARCHAR(255) NOT NULL,
  CUSTOMER_CONTACT INTEGER NOT NULL,
  CUSTOMER_STATUS BOOLEAN,
  CUSTOMER_CREATED DATE,
  CUSTOMER_UPDATED DATE
  );
 
/*
Table to store the Payment methods for a customer - T_CUSTOMER_PAYMENT

A Customer can have zero or more payment methods

*/
 CREATE TABLE T_CUSTOMER_PAYMENT
(
  PAYMENT_ID INTEGER PRIMARY KEY,
  CUSTOMER_ID VARCHAR(255) NOT NULL,
  PAYMENT_TYPE VARCHAR(255) NOT NULL,
  PAYMENT_REFERENCE INTEGER (35) NOT NULL,
  PAYMENT_STATUS BOOLEAN,
  PAYMENT_CREATED DATE NOT NULL,
  PAYMENT_UPDATED DATE NOT NULL,
  FOREIGN KEY CUSTOMER_ID REFERENCES T_CUSTOMERS(CUSTOMER_ID)
  ); 
  
 
/* 
Table for Storing Customer Delivery Addresses - T_CUSTOMER_ADDRESS

A Customer can have multiple delivery locations

*/
 
 
  CREATE TABLE T_CUSTOMER_ADDRESS
(
  ADDRESS_ID INTEGER NOT NULL,
  CUSTOMER_ID INTEGER NOT NULL,
  ADDRESS_LINE1 VARCHAR(255) NOT NULL,
  ADDRESS_LINE2 VARCHAR(255),
  CITY VARCHAR(255),
  PIN_CODE INTEGER,
  STATE_NAME VARCHAR(255),
  CUSTOMER_CONTACT INTEGER,
  ADDRESS_CREATED DATE NOT NULL,
  ADDRESS_UPDATED DATE NOT NULL,
  FOREIGN KEY CUSTOMER_NO REFERENCES T_CUSTOMERS(CUSTOMER_NO)
  ); 

/* 

Table to store transation details of a customer - T_TRANSACTION_DETAILS

*/

  CREATE TABLE T_TRANSACTION_DETAILS
(
  TRANSACTION_ID VARCHAT PRIMARY KEY,
  CUSTOMER_ID INTEGER NOT NULL,
  PAYMENT_ID INTEGER NOT NULL,
  TRANSACTION_STATUS BOOLEAN,
  TRANSACTION_DONE_ON DATE NOT NULL,
  FOREIGN KEY CUSTOMER_NO REFERENCES T_CUSTOMERS(CUSTOMER_NO),
  FOREIGN KEY PAYMENT_ID REFERENCES T_CUSTOMERPAYMENT(PAYMENT_ID)
  ); 



/*
Table for storing Order Details T_ORDERS
 */  
    
    CREATE TABLE T_ORDERS
(
  ORDER_ID INTEGER PRIMARY KEY,
  CUSTOMER_ID INTEGER NOT NULL,
  ADDRESS_ID INTEGER NOT NULL,
  ORDER_PLACED DATE NOT NULL,
  EXPECTED_DELIVERY DATE NOT NULL,
  TRANSACTION_ID VARCHAR NOT NULL,
  FOREIGN KEY CUSTOMER_ID REFERENCES T_CUSTOMERS(CUSTOMER_ID)
  FOREIGN KEY ADDRESS_ID REFERENCES T_CUSTOMERADDRESS(ADDRESS_ID)
  FOREIGN KEY TRANSACTION_ID REFERENCES T_TRANSACTIONDETAILS(TRANSACTION_ID)
  );
  
/*
Table for storing Order to product relation Details T_ORDER_PRODUCTS
 */   
  
      CREATE TABLE T_ORDER_PRODUCTS	
(
  ORDER_RELATION_NO	INTEGER PRIMARY KEY,
  ORDER_ID INTEGER NOT NULL,
  PRODUCT_NO INTEGER NOT NULL,
  SUPPLIER_ID INTEGER NOT NULL,
  EXPECTED_DELIVERY DATE NOT NULL,
  FOREIGN KEY ORDER_ID REFERENCES T_ORDERS(ORDER_ID)
  FOREIGN KEY PRODUCT_NO REFERENCES T_PRODUCTS(PRODUCT_NO)
  FOREIGN KEY SUPPLIER_ID REFERENCES T_SUPPLIERS(SUPPLIER_ID)

  );
  
/