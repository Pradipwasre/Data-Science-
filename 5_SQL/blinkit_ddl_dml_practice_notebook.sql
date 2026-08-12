-- ============================================================================
-- BLINKIT SNOWFLAKE SQL PRACTICE NOTEBOOK
-- Topic: DDL (Data Definition Language) & DML (Data Manipulation Language)
-- Created: 2026-08-12
-- ============================================================================

-- ============================================================================
-- SECTION 1: DDL vs DML - THEORY
-- ============================================================================

/*
┌─────────────────────────────────────────────────────────────────────────────┐
│                         DDL - DATA DEFINITION LANGUAGE                      │
├─────────────────────────────────────────────────────────────────────────────┤
│  Purpose: Defines and manages the STRUCTURE of database objects.            │
│  What it does: Creates, modifies, or removes databases, schemas, tables,    │
│                columns, constraints, indexes, views, etc.                   │
│  Auto-commit: YES - Every DDL command is automatically committed.           │
│  Rollback: NO - You CANNOT undo a DDL command with ROLLBACK.                │
│                                                                             │
│  Core Commands:                                                             │
│    CREATE  - Creates a new database, schema, table, view, etc.              │
│    ALTER   - Modifies the structure of an existing object.                  │
│    DROP    - Permanently deletes an object.                                 │
│    TRUNCATE- Removes all data from a table (keeps structure).               │
│                                                                             │
│  Example: CREATE TABLE, ALTER TABLE ADD COLUMN, DROP TABLE                  │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                         DML - DATA MANIPULATION LANGUAGE                    │
├─────────────────────────────────────────────────────────────────────────────┤
│  Purpose: Manages the DATA inside the database tables.                      │
│  What it does: Inserts, updates, deletes, and retrieves rows of data.       │
│  Auto-commit: NO - DML needs explicit COMMIT to save changes.               │
│  Rollback: YES - You CAN undo DML with ROLLBACK before COMMIT.              │
│                                                                             │
│  Core Commands:                                                             │
│    INSERT  - Adds new rows into a table.                                    │
│    UPDATE  - Modifies existing rows in a table.                             │
│    DELETE  - Removes specific rows from a table.                            │
│    SELECT  - Retrieves data from one or more tables.                        │
│    MERGE   - Combines INSERT, UPDATE, DELETE in one command.                │
│                                                                             │
│  Example: INSERT INTO, UPDATE SET, DELETE FROM, SELECT * FROM               │
└─────────────────────────────────────────────────────────────────────────────┘

KEY DIFFERENCE:
  DDL = Works on STRUCTURE (the container)  ->  CREATE, ALTER, DROP
  DML = Works on DATA (the content inside)  ->  INSERT, UPDATE, DELETE, SELECT
*/

-- ============================================================================
-- SECTION 2: SETUP - Create Warehouse, Database, and Schema
-- ============================================================================

-- Use ACCOUNTADMIN or SYSADMIN role (run this in Snowflake worksheet)
USE ROLE ACCOUNTADMIN;

-- Create Warehouse (DDL: CREATE)
CREATE OR REPLACE WAREHOUSE PRACTICE_WH
    WITH
    WAREHOUSE_SIZE = 'X-SMALL'
    AUTO_SUSPEND = 300
    AUTO_RESUME = TRUE;

-- Use the warehouse
USE WAREHOUSE PRACTICE_WH;

-- Create Database (DDL: CREATE)
CREATE OR REPLACE DATABASE PRACTICE_DB;

-- Use the database
USE DATABASE PRACTICE_DB;

-- Create Schema (DDL: CREATE)
CREATE OR REPLACE SCHEMA PRACTICE_SCHEMA;

-- Use the schema
USE SCHEMA PRACTICE_DB.PRACTICE_SCHEMA;

-- ============================================================================
-- SECTION 3: DDL PRACTICE - Data Definition Language
-- ============================================================================

-- ============================================================================
-- EXERCISE 1: CREATE TABLE 
-- ============================================================================

/*
COMMAND: CREATE TABLE
PURPOSE: Creates a new table with specified columns and data types.
SYNTAX: CREATE TABLE table_name (column1 datatype, column2 datatype, ...);
*/

-- Practice 1.1: Create a simple table with 2 columns
CREATE TABLE STUDENTS (
    STUDENT_ID  NUMBER(10) PRIMARY KEY,
    STUDENT_NAME VARCHAR(100) NOT NULL
);

-- Practice 1.2: Create another simple table with 2 columns
CREATE TABLE COURSES (
    COURSE_ID   NUMBER(10) PRIMARY KEY,
    COURSE_NAME VARCHAR(100) NOT NULL
);

-- Practice 1.3: Create a table for delivery partners (2 columns)
CREATE TABLE DELIVERY_PARTNERS (
    PARTNER_ID   NUMBER(10) PRIMARY KEY,
    PARTNER_NAME VARCHAR(100) NOT NULL
);

-- Practice 1.4: Create a table for products (2 columns)
CREATE TABLE PRODUCTS (
    PRODUCT_ID   NUMBER(10) PRIMARY KEY,
    PRODUCT_NAME VARCHAR(100) NOT NULL
);

-- Practice 1.5: Create a table for orders (2 columns)
CREATE TABLE ORDERS (
    ORDER_ID   NUMBER(10) PRIMARY KEY,
    ORDER_AMOUNT NUMBER(10,2)
);

-- Verify: See all tables created in this schema
SHOW TABLES;

-- ============================================================================
-- EXERCISE 2: ALTER TABLE (Modify existing table structure)
-- ============================================================================

/*
COMMAND: ALTER TABLE
PURPOSE: Modifies the structure of an existing table.
SYNTAX: ALTER TABLE table_name ADD COLUMN column_name datatype;
        ALTER TABLE table_name DROP COLUMN column_name;
        ALTER TABLE table_name RENAME COLUMN old_name TO new_name;
*/

-- Practice 2.1: Add a new column to STUDENTS table
ALTER TABLE STUDENTS
ADD COLUMN EMAIL VARCHAR(100);

-- Practice 2.2: Add a new column to COURSES table
ALTER TABLE COURSES
ADD COLUMN DURATION_HOURS NUMBER(5);

-- Practice 2.3: Rename a column in STUDENTS table
ALTER TABLE STUDENTS
RENAME COLUMN EMAIL TO STUDENT_EMAIL;

-- Practice 2.4: Drop a column from COURSES table
ALTER TABLE COURSES
DROP COLUMN DURATION_HOURS;

-- Practice 2.5: Add column back to COURSES table
ALTER TABLE COURSES
ADD COLUMN INSTRUCTOR_NAME VARCHAR(100);

-- Verify: See the structure of STUDENTS table
DESC TABLE STUDENTS;

-- ============================================================================
-- EXERCISE 3: DROP TABLE (Delete table permanently)
-- ============================================================================

/*
COMMAND: DROP TABLE
PURPOSE: Permanently deletes a table and ALL its data.
WARNING: This CANNOT be undone! Use with caution.
SYNTAX: DROP TABLE table_name;
        DROP TABLE IF EXISTS table_name;  -- Safer version
*/

-- Practice 3.1: Create a temporary table to drop
CREATE TABLE TEMP_TABLE (
    ID   NUMBER(10),
    NAME VARCHAR(50)
);

-- Practice 3.2: Drop the temporary table
DROP TABLE TEMP_TABLE;

-- Practice 3.3: Safe drop (no error if table doesn't exist)
DROP TABLE IF EXISTS TEMP_TABLE;

-- Practice 3.4: Create and immediately drop another test table
CREATE TABLE TEST_DROP (
    COL1 NUMBER(5),
    COL2 VARCHAR(20)
);

DROP TABLE TEST_DROP;

-- Verify: Check that tables are gone
SHOW TABLES LIKE 'TEST%';

-- ============================================================================
-- EXERCISE 4: TRUNCATE TABLE (Remove all data, keep structure)
-- ============================================================================

/*
COMMAND: TRUNCATE TABLE
PURPOSE: Removes ALL rows from a table but keeps the table structure.
DIFFERENCE FROM DROP: DROP deletes the table itself. TRUNCATE only deletes data.
DIFFERENCE FROM DELETE: TRUNCATE is faster, cannot use WHERE clause, auto-commits.
SYNTAX: TRUNCATE TABLE table_name;
*/

-- First, insert some data into ORDERS table (we'll learn INSERT in DML section)
INSERT INTO ORDERS (ORDER_ID, ORDER_AMOUNT) VALUES (1, 150.00);
INSERT INTO ORDERS (ORDER_ID, ORDER_AMOUNT) VALUES (2, 250.50);
INSERT INTO ORDERS (ORDER_ID, ORDER_AMOUNT) VALUES (3, 99.99);

-- Practice 4.1: Check data before truncate
SELECT * FROM ORDERS;

-- Practice 4.2: Truncate the table (removes all 3 rows, keeps structure)
TRUNCATE TABLE ORDERS;

-- Practice 4.3: Verify table is empty but still exists
SELECT * FROM ORDERS;

-- Practice 4.4: Check table still exists with DESC
DESC TABLE ORDERS;

-- ============================================================================
-- SECTION 4: DML PRACTICE - Data Manipulation Language
-- ============================================================================

-- ============================================================================
-- EXERCISE 5: INSERT (Add rows to a table)
-- ============================================================================

/*
COMMAND: INSERT INTO
PURPOSE: Adds new rows of data into a table.
SYNTAX: INSERT INTO table_name (col1, col2) VALUES (val1, val2);
        INSERT INTO table_name VALUES (val1, val2);  -- All columns
*/

-- Practice 5.1: Insert 1 row into STUDENTS table
INSERT INTO STUDENTS (STUDENT_ID, STUDENT_NAME)
VALUES (1, 'Rahul Sharma');

-- Practice 5.2: Insert 1 row into COURSES table
INSERT INTO COURSES (COURSE_ID, COURSE_NAME)
VALUES (101, 'Snowflake Basics');

-- Practice 5.3: Insert 1 row into DELIVERY_PARTNERS table
INSERT INTO DELIVERY_PARTNERS (PARTNER_ID, PARTNER_NAME)
VALUES (1, 'Amit Patil');

-- Practice 5.4: Insert 1 row into PRODUCTS table
INSERT INTO PRODUCTS (PRODUCT_ID, PRODUCT_NAME)
VALUES (1, 'Amul Milk 1L');

-- Practice 5.5: Insert multiple rows in one command
INSERT INTO STUDENTS (STUDENT_ID, STUDENT_NAME)
VALUES
    (2, 'Priya Deshmukh'),
    (3, 'Vikram Jadhav'),
    (4, 'Sneha Kulkarni');

-- Practice 5.6: Insert into ORDERS table
INSERT INTO ORDERS (ORDER_ID, ORDER_AMOUNT)
VALUES (10, 499.99);

-- Verify: Check all inserted data
SELECT * FROM STUDENTS;
SELECT * FROM COURSES;
SELECT * FROM DELIVERY_PARTNERS;
SELECT * FROM PRODUCTS;
SELECT * FROM ORDERS;

-- ============================================================================
-- EXERCISE 6: UPDATE (Modify existing rows - ONLY 1 row for clarity)
-- ============================================================================

/*
COMMAND: UPDATE
PURPOSE: Modifies existing data in a table.
SYNTAX: UPDATE table_name SET column = new_value WHERE condition;
WARNING: ALWAYS use WHERE clause, or ALL rows will be updated!
*/

-- Practice 6.1: Update 1 row in STUDENTS table
-- Before update: Rahul Sharma -> After update: Rahul S. Sharma
UPDATE STUDENTS
SET STUDENT_NAME = 'Rahul S. Sharma'
WHERE STUDENT_ID = 1;

-- Practice 6.2: Update 1 row in COURSES table
UPDATE COURSES
SET COURSE_NAME = 'Snowflake Advanced'
WHERE COURSE_ID = 101;

-- Practice 6.3: Update 1 row in DELIVERY_PARTNERS table
UPDATE DELIVERY_PARTNERS
SET PARTNER_NAME = 'Amit K. Patil'
WHERE PARTNER_ID = 1;

-- Practice 6.4: Update 1 row in PRODUCTS table
UPDATE PRODUCTS
SET PRODUCT_NAME = 'Amul Milk 1L (Full Cream)'
WHERE PRODUCT_ID = 1;

-- Practice 6.5: Update 1 row in ORDERS table
UPDATE ORDERS
SET ORDER_AMOUNT = 599.99
WHERE ORDER_ID = 10;

-- Verify: Check updated data
SELECT * FROM STUDENTS WHERE STUDENT_ID = 1;
SELECT * FROM COURSES WHERE COURSE_ID = 101;
SELECT * FROM DELIVERY_PARTNERS WHERE PARTNER_ID = 1;
SELECT * FROM PRODUCTS WHERE PRODUCT_ID = 1;
SELECT * FROM ORDERS WHERE ORDER_ID = 10;

-- ============================================================================
-- EXERCISE 7: DELETE (Remove specific rows)
-- ============================================================================

/*
COMMAND: DELETE
PURPOSE: Removes specific rows from a table based on a condition.
SYNTAX: DELETE FROM table_name WHERE condition;
WARNING: ALWAYS use WHERE clause, or ALL rows will be deleted!
DIFFERENCE FROM TRUNCATE: DELETE can use WHERE, TRUNCATE cannot.
*/

-- Practice 7.1: Delete 1 specific row from STUDENTS
DELETE FROM STUDENTS
WHERE STUDENT_ID = 4;

-- Practice 7.2: Delete 1 specific row from COURSES
-- (First insert a row to delete)
INSERT INTO COURSES (COURSE_ID, COURSE_NAME)
VALUES (999, 'Temp Course');

DELETE FROM COURSES
WHERE COURSE_ID = 999;

-- Practice 7.3: Delete 1 specific row from DELIVERY_PARTNERS
-- (First insert a row to delete)
INSERT INTO DELIVERY_PARTNERS (PARTNER_ID, PARTNER_NAME)
VALUES (999, 'Temp Partner');

DELETE FROM DELIVERY_PARTNERS
WHERE PARTNER_ID = 999;

-- Practice 7.4: Delete 1 specific row from PRODUCTS
-- (First insert a row to delete)
INSERT INTO PRODUCTS (PRODUCT_ID, PRODUCT_NAME)
VALUES (999, 'Temp Product');

DELETE FROM PRODUCTS
WHERE PRODUCT_ID = 999;

-- Practice 7.5: Delete 1 specific row from ORDERS
-- (First insert a row to delete)
INSERT INTO ORDERS (ORDER_ID, ORDER_AMOUNT)
VALUES (999, 1.00);

DELETE FROM ORDERS
WHERE ORDER_ID = 999;

-- Verify: Check remaining data after deletes
SELECT * FROM STUDENTS;
SELECT * FROM COURSES;
SELECT * FROM DELIVERY_PARTNERS;
SELECT * FROM PRODUCTS;
SELECT * FROM ORDERS;

-- ============================================================================
-- EXERCISE 8: SELECT (Retrieve data - also part of DML)
-- ============================================================================

/*
COMMAND: SELECT
PURPOSE: Retrieves data from one or more tables.
SYNTAX: SELECT column1, column2 FROM table_name WHERE condition;
*/

-- Practice 8.1: Select all columns and all rows
SELECT * FROM STUDENTS;

-- Practice 8.2: Select specific columns
SELECT STUDENT_NAME FROM STUDENTS;

-- Practice 8.3: Select with WHERE condition
SELECT * FROM STUDENTS WHERE STUDENT_ID = 1;

-- Practice 8.4: Select with ORDER BY
SELECT * FROM STUDENTS ORDER BY STUDENT_NAME;

-- Practice 8.5: Select with LIMIT
SELECT * FROM STUDENTS LIMIT 2;

-- ============================================================================
-- EXERCISE 9: COMMIT and ROLLBACK (Transaction Control)
-- ============================================================================

/*
COMMAND: COMMIT
PURPOSE: Permanently saves all DML changes made in the current transaction.
SYNTAX: COMMIT;

COMMAND: ROLLBACK
PURPOSE: Undoes all DML changes made in the current transaction.
SYNTAX: ROLLBACK;
*/

-- Practice 9.1: Start a transaction, insert data, then rollback
BEGIN;

INSERT INTO STUDENTS (STUDENT_ID, STUDENT_NAME)
VALUES (100, 'Rollback Test Student');

-- Check: Data exists temporarily
SELECT * FROM STUDENTS WHERE STUDENT_ID = 100;

-- Rollback: Undo the insert
ROLLBACK;

-- Verify: Row 100 should NOT exist anymore
SELECT * FROM STUDENTS WHERE STUDENT_ID = 100;

-- Practice 9.2: Start a transaction, insert data, then commit
BEGIN;

INSERT INTO STUDENTS (STUDENT_ID, STUDENT_NAME)
VALUES (200, 'Committed Student');

COMMIT;

-- Verify: Row 200 should exist permanently
SELECT * FROM STUDENTS WHERE STUDENT_ID = 200;

-- ============================================================================
-- SECTION 5: QUICK REFERENCE CHEAT SHEET
-- ============================================================================

/*
┌─────────────────────────────────────────────────────────────────────────────┐
│                              DDL COMMANDS                                   │
├──────────────────┬──────────────────────────────────────────────────────────┤
│ CREATE DATABASE  │ CREATE DATABASE db_name;                                 │
│ CREATE SCHEMA    │ CREATE SCHEMA schema_name;                               │
│ CREATE TABLE     │ CREATE TABLE t (col1 type, col2 type);                   │
│ ALTER TABLE      │ ALTER TABLE t ADD COLUMN col type;                       │
│ ALTER TABLE      │ ALTER TABLE t DROP COLUMN col;                           │
│ ALTER TABLE      │ ALTER TABLE t RENAME COLUMN old TO new;                  │
│ DROP TABLE       │ DROP TABLE t;                                            │
│ DROP TABLE       │ DROP TABLE IF EXISTS t;                                  │
│ TRUNCATE TABLE   │ TRUNCATE TABLE t;                                        │
│ DROP DATABASE    │ DROP DATABASE db_name;                                   │
│ DROP SCHEMA      │ DROP SCHEMA schema_name;                                 │
└──────────────────┴──────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                              DML COMMANDS                                   │
├──────────────────┬──────────────────────────────────────────────────────────┤
│ INSERT           │ INSERT INTO t (col1, col2) VALUES (val1, val2);          │
│ UPDATE           │ UPDATE t SET col = val WHERE condition;                  │
│ DELETE           │ DELETE FROM t WHERE condition;                           │
│ SELECT           │ SELECT * FROM t WHERE condition;                         │
│ COMMIT           │ COMMIT;                                                  │
│ ROLLBACK         │ ROLLBACK;                                                │
└──────────────────┴──────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                         DDL vs DML - KEY DIFFERENCES                        │
├──────────────────┬─────────────────┬────────────────────────────────────────┤
│   Feature        │      DDL        │         DML                            │
├──────────────────┼─────────────────┼────────────────────────────────────────┤
│ Works On         │ Structure       │ Data (rows)                            │
│ Commands         │ CREATE, ALTER,  │ INSERT, UPDATE, DELETE, SELECT         │
│                  │ DROP, TRUNCATE  │                                        │
│ Auto Commit      │ YES             │ NO (needs explicit COMMIT)             │
│ Can Rollback?    │ NO              │ YES (before COMMIT)                    │
│ Affects          │ Schema/Objects  │ Table rows                             │
└──────────────────┴─────────────────┴────────────────────────────────────────┘
*/

-- ============================================================================
-- SECTION 6: INTERVIEW QUESTIONS
-- ============================================================================

-- ============================================================================
-- PART A: SNOWFLAKE INTERVIEW QUESTIONS (5 Questions)
-- ============================================================================

/*
Q1. What is Snowflake and how is it different from traditional databases?
ANSWER:
    Snowflake is a cloud-native data warehouse built on top of AWS, Azure, or GCP.
    Unlike traditional databases (Oracle, MySQL) that combine compute and storage,
    Snowflake SEPARATES compute (Virtual Warehouses) from storage (cloud blob storage).
    This allows independent scaling - you can scale compute up/down without affecting
    storage costs. It is a SaaS (Software-as-a-Service) platform with zero infrastructure
    management required.

Q2. What is a Virtual Warehouse in Snowflake?
ANSWER:
    A Virtual Warehouse is a cluster of compute resources (CPU, memory, SSD) in Snowflake
    that executes SQL queries. It is independent of data storage. Key features:
    - Sizes: X-Small, Small, Medium, Large, X-Large, 2X-Large, 3X-Large, 4X-Large
    - Auto-suspend: Automatically pauses when idle (saves cost)
    - Auto-resume: Automatically starts when a query is submitted
    - Multi-cluster: Can have multiple clusters for high concurrency

Q3. What is the difference between a Database, Schema, and Table in Snowflake?
ANSWER:
    DATABASE  -> Top-level container. Holds multiple schemas. Example: BLINKIT_DB
    SCHEMA    -> Logical grouping inside a database. Holds tables, views, procedures.
                 Example: BLINKIT_SCHEMA, DELIVERY_PARTNERS_SCHEMA
    TABLE     -> Actual data storage with rows and columns.
                 Example: PRODUCTS, PARTNERS, DELIVERIES
    Hierarchy: DATABASE > SCHEMA > TABLE

Q4. What is the difference between Transient and Permanent tables in Snowflake?
ANSWER:
    PERMANENT TABLE (default):
    - Full Time Travel support (up to 90 days for Enterprise)
    - Full Fail-safe support (7 days after Time Travel expires)
    - Higher storage cost due to historical data retention

    TRANSIENT TABLE:
    - Has Time Travel but NO Fail-safe
    - Lower storage cost
    - Good for staging/temporary data that doesn't need disaster recovery

    TEMPORARY TABLE:
    - Exists only for the current session
    - Automatically dropped when session ends
    - No Time Travel, no Fail-safe

Q5. What is Time Travel in Snowflake?
ANSWER:
    Time Travel allows you to query, clone, or restore data from the past.
    You can access historical data using:
    - AT / BEFORE clause: SELECT * FROM table AT(OFFSET => -60*5)  -- 5 min ago
    - UNDROP: UNDROP TABLE table_name  -- Restores a dropped table
    - CLONE: CREATE TABLE new CLONE old AT(OFFSET => -3600)  -- Clone from 1 hour ago
    Standard Edition: 1 day Time Travel
    Enterprise Edition: Up to 90 days Time Travel
*/

-- ============================================================================
-- PART B: SQL INTERVIEW QUESTIONS (10 Questions on DDL & DML)
-- ============================================================================

/*
Q1. What is the difference between DDL and DML? Give examples of each.
ANSWER:
    DDL (Data Definition Language) works on the STRUCTURE of the database.
    Examples: CREATE, ALTER, DROP, TRUNCATE
    DML (Data Manipulation Language) works on the DATA inside the tables.
    Examples: INSERT, UPDATE, DELETE, SELECT
    Key difference: DDL is auto-committed and cannot be rolled back.
    DML requires explicit COMMIT and CAN be rolled back before COMMIT.

Q2. What is the difference between DROP and TRUNCATE?
ANSWER:
    DROP TABLE:
    - Removes the ENTIRE table structure + all data + all constraints + indexes
    - Cannot be rolled back (it's DDL)
    - Frees up all storage immediately

    TRUNCATE TABLE:
    - Removes ALL rows but KEEPS the table structure, columns, constraints
    - Cannot use WHERE clause (removes everything)
    - Faster than DELETE because it doesn't log individual row deletions
    - Cannot be rolled back (it's DDL)

Q3. What is the difference between DELETE and TRUNCATE?
ANSWER:
    DELETE:
    - Can use WHERE clause to delete specific rows
    - Logs each row deletion (slower for large tables)
    - Can be rolled back (it's DML, before COMMIT)
    - Triggers fire on DELETE

    TRUNCATE:
    - Cannot use WHERE clause (deletes ALL rows)
    - Does NOT log individual row deletions (much faster)
    - Cannot be rolled back (it's DDL)
    - Triggers do NOT fire on TRUNCATE

Q4. What happens if you run UPDATE without a WHERE clause?
ANSWER:
    If you run UPDATE without WHERE, EVERY SINGLE ROW in the table gets updated.
    Example: UPDATE STUDENTS SET STUDENT_NAME = 'Same Name';
    This will change ALL student names to 'Same Name' - a dangerous mistake!
    Always use WHERE with UPDATE to target specific rows.

Q5. Can you rollback a CREATE TABLE command? Why or why not?
ANSWER:
    NO, you cannot rollback a CREATE TABLE command.
    Reason: CREATE TABLE is a DDL command, and ALL DDL commands are auto-committed.
    They are committed immediately after execution, so there is nothing to rollback.
    Only DML commands (INSERT, UPDATE, DELETE) can be rolled back before COMMIT.

Q6. What is the syntax to add a new column to an existing table?
ANSWER:
    ALTER TABLE table_name ADD COLUMN column_name datatype;
    Example: ALTER TABLE STUDENTS ADD COLUMN EMAIL VARCHAR(100);
    This is a DDL command that modifies the table structure.

Q7. How do you insert multiple rows in a single INSERT statement?
ANSWER:
    INSERT INTO table_name (col1, col2)
    VALUES
        (val1, val2),
        (val3, val4),
        (val5, val6);
    Example from this notebook:
    INSERT INTO STUDENTS (STUDENT_ID, STUDENT_NAME)
    VALUES
        (2, 'Priya Deshmukh'),
        (3, 'Vikram Jadhav'),
        (4, 'Sneha Kulkarni');

Q8. What is the purpose of the PRIMARY KEY constraint?
ANSWER:
    A PRIMARY KEY uniquely identifies each row in a table.
    Rules:
    - Must contain UNIQUE values (no duplicates)
    - Cannot contain NULL values
    - A table can have only ONE primary key
    - It automatically creates a unique index for fast lookups
    Example: STUDENT_ID NUMBER(10) PRIMARY KEY

Q9. What is the difference between COMMIT and ROLLBACK?
ANSWER:
    COMMIT:
    - Permanently saves all DML changes to the database
    - After COMMIT, changes cannot be undone with ROLLBACK
    - Makes changes visible to other users/sessions

    ROLLBACK:
    - Undoes all DML changes made since the last COMMIT or BEGIN
    - Restores the data to its state before the transaction started
    - Only works for DML (INSERT, UPDATE, DELETE), NOT for DDL

Q10. Write a SQL command to rename a column in an existing table.
ANSWER:
    In Snowflake:
    ALTER TABLE table_name RENAME COLUMN old_column_name TO new_column_name;
    Example: ALTER TABLE STUDENTS RENAME COLUMN EMAIL TO STUDENT_EMAIL;
    This is a DDL command that changes the structure without affecting data.
*/

-- ============================================================================
-- SECTION 7: CLEANUP (Optional - Run when practice is complete)
-- ============================================================================

-- Drop all practice tables
DROP TABLE IF EXISTS STUDENTS;
DROP TABLE IF EXISTS COURSES;
DROP TABLE IF EXISTS DELIVERY_PARTNERS;
DROP TABLE IF EXISTS PRODUCTS;
DROP TABLE IF EXISTS ORDERS;

-- Drop schema
DROP SCHEMA IF EXISTS PRACTICE_DB.PRACTICE_SCHEMA;

-- Drop database
DROP DATABASE IF EXISTS PRACTICE_DB;

-- Drop warehouse
DROP WAREHOUSE IF EXISTS PRACTICE_WH;

-- ============================================================================
-- END OF NOTEBOOK - HAPPY LEARNING!
-- ============================================================================