-- ============================================================================
-- BLINKIT SNOWFLAKE SQL PRACTICE NOTEBOOK - DAY 3
-- Topic: DQL - Data Query Language
-- Commands: SELECT, WHERE, ORDER BY, GROUP BY, HAVING, LIMIT
-- Created: 2026-08-13
-- ============================================================================

-- ============================================================================
-- SECTION 0: QUICK RECAP - What We Learned in Day 1 & Day 2
-- ============================================================================

/*
═══════════════════════════════════════════════════════════════════════════════
  DAY 1  →  DDL  (Data Definition Language)
═══════════════════════════════════════════════════════════════════════════════
  What it does : Creates / modifies / deletes the STRUCTURE of the database.
  Think of it  : Building the house (walls, rooms, doors).
  Commands     : CREATE, ALTER, DROP, TRUNCATE
  Auto-commit  : YES  →  Cannot rollback.

  Quick Examples:
    CREATE TABLE students (id NUMBER, name VARCHAR(50));
    ALTER TABLE students ADD COLUMN email VARCHAR(100);
    DROP TABLE students;
    TRUNCATE TABLE students;   -- keeps table, deletes all rows

═══════════════════════════════════════════════════════════════════════════════
  DAY 2  →  DML  (Data Manipulation Language)
═══════════════════════════════════════════════════════════════════════════════
  What it does : Adds / changes / removes DATA inside the tables.
  Think of it  : Moving furniture into the house.
  Commands     : INSERT, UPDATE, DELETE, SELECT, COMMIT, ROLLBACK
  Auto-commit  : NO  →  Must run COMMIT to save. Can rollback before commit.

  Quick Examples:
    INSERT INTO students (id, name) VALUES (1, 'Rahul');
    UPDATE students SET name = 'Rahul S.' WHERE id = 1;
    DELETE FROM students WHERE id = 1;
    COMMIT;    -- saves changes permanently
    ROLLBACK;  -- undoes changes (only before COMMIT)

═══════════════════════════════════════════════════════════════════════════════
  ONE-LINE DIFFERENCE
═══════════════════════════════════════════════════════════════════════════════
  DDL  →  Works on STRUCTURE  (CREATE table, ALTER column, DROP table)
  DML  →  Works on DATA       (INSERT row, UPDATE row, DELETE row)

═══════════════════════════════════════════════════════════════════════════════
  TODAY  →  DAY 3  →  DQL  (Data Query Language)
═══════════════════════════════════════════════════════════════════════════════
  What it does : READS and ANALYZES data from tables.
  Think of it  : Looking at what's inside the house.
  Commands     : SELECT, WHERE, ORDER BY, GROUP BY, HAVING, LIMIT
*/

-- ============================================================================
-- SECTION 1: SETUP
-- ============================================================================

USE ROLE ACCOUNTADMIN;

CREATE WAREHOUSE IF NOT EXISTS PRACTICE_WH
    WITH
    WAREHOUSE_SIZE = 'X-SMALL'
    AUTO_SUSPEND = 300
    AUTO_RESUME = TRUE;

USE WAREHOUSE PRACTICE_WH;

CREATE DATABASE IF NOT EXISTS DQL_PRACTICE_DB;
USE DATABASE DQL_PRACTICE_DB;

CREATE SCHEMA IF NOT EXISTS practice_schema;
USE SCHEMA DQL_PRACTICE_DB.practice_schema;

-- ============================================================================
-- SECTION 2: CREATE TABLES & INSERT SAMPLE DATA (Only 4-5 rows each)
-- ============================================================================

DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS orders;

-- Table 1: students (5 rows)
CREATE TABLE students (
    student_id   NUMBER(10) PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL
);

INSERT INTO students (student_id, student_name) VALUES
    (1, 'Rahul Sharma'),
    (2, 'Priya Deshmukh'),
    (3, 'Vikram Jadhav'),
    (4, 'Sneha Kulkarni'),
    (5, 'Amit Patil');

-- Table 2: products (5 rows)
CREATE TABLE products (
    product_id   NUMBER(10) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category     VARCHAR(50)  NOT NULL,
    price        NUMBER(10,2) NOT NULL,
    stock        NUMBER(10)   NOT NULL
);

INSERT INTO products (product_id, product_name, category, price, stock) VALUES
    (1, 'Amul Milk 1L', 'Dairy', 66.00, 120),
    (2, 'Tata Salt 1Kg', 'Grocery', 25.00, 200),
    (3, 'Maggi Noodles', 'Instant Food', 56.00, 150),
    (4, 'Colgate Paste', 'Personal Care', 55.00, 100),
    (5, 'Coca Cola 750ml', 'Beverages', 40.00, 180);

-- Table 3: orders (5 rows)
CREATE TABLE orders (
    order_id      NUMBER(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    product_id    NUMBER(10)   NOT NULL,
    quantity      NUMBER(5)    NOT NULL,
    order_date    DATE         NOT NULL,
    city          VARCHAR(50)  NOT NULL,
    order_status  VARCHAR(20)  NOT NULL
);

INSERT INTO orders (order_id, customer_name, product_id, quantity, order_date, city, order_status) VALUES
    (1, 'Rahul Sharma', 1, 2, '2026-01-15', 'Pune', 'Delivered'),
    (2, 'Priya Deshmukh', 2, 1, '2026-01-16', 'Mumbai', 'Delivered'),
    (3, 'Vikram Jadhav', 3, 3, '2026-01-17', 'Pune', 'Pending'),
    (4, 'Sneha Kulkarni', 1, 1, '2026-01-18', 'Bangalore', 'Delivered'),
    (5, 'Amit Patil', 4, 2, '2026-01-20', 'Pune', 'Cancelled');

-- Verify data loaded
SELECT 'students' AS table_name, COUNT(*) AS row_count FROM students
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'orders', COUNT(*) FROM orders;

-- ============================================================================
-- SECTION 3: SELECT - Choosing What to See
-- ============================================================================

/*
WHAT IS SELECT?
  SELECT is the command that tells the database WHICH columns you want to see.
  Think of it like looking at a menu - you choose what dishes to order.

WHY DO WE NEED IT?
  A table might have 50 columns, but you only care about 2 or 3.
  Instead of seeing everything (which is confusing), SELECT lets you pick
  exactly what you need - saving time and making results easier to read.

OUTPUT TYPE:
  Returns a TABLE with only the columns you asked for.

EXAMPLE OUTPUT:
  SELECT student_name FROM students;
  +------------------+
  |  STUDENT_NAME    |
  +------------------+
  | Rahul Sharma     |
  | Priya Deshmukh   |
  | Vikram Jadhav    |
  +------------------+
*/

-- Practice 3.1: Select ALL columns
SELECT * FROM students;

-- Practice 3.2: Select only names
SELECT student_name FROM students;

-- Practice 3.3: Select specific columns from products
SELECT product_name, price FROM products;

-- Practice 3.4: Column alias (rename in output)
SELECT product_name AS item, price AS cost FROM products;


-- Practice 3.5: DISTINCT values (shows only unique values, removes duplicates)
SELECT DISTINCT city FROM orders;

-- Practice 3.6: DISTINCT statuses
SELECT DISTINCT order_status FROM orders;

-- ============================================================================
-- SECTION 4: WHERE - Filtering Rows
-- ============================================================================

/*
WHAT IS WHERE?
  WHERE is the command that filters WHICH ROWS you want to see.
  Think of it like a sieve - it keeps only the rows that match your condition.

WHY DO WE NEED IT?
  A table might have 1 million rows, but you only need rows from 'Pune'.
  WHERE saves processing time and shows only relevant data.
  Without WHERE, you would manually scroll through thousands of unwanted rows.

OUTPUT TYPE:
  Returns a TABLE with ONLY the rows that satisfy the condition.

EXAMPLE OUTPUT:
  SELECT * FROM orders WHERE city = 'Pune';
  +----------+----------------+------------+----------+------------+------+--------------+
  | ORDER_ID | CUSTOMER_NAME  | PRODUCT_ID | QUANTITY | ORDER_DATE | CITY | ORDER_STATUS |
  +----------+----------------+------------+----------+------------+------+--------------+
  |    1     | Rahul Sharma   |     1      |    2     | 2026-01-15 | Pune |  Delivered   |
  |    3     | Vikram Jadhav  |     3      |    3     | 2026-01-17 | Pune |  Pending     |
  |    5     | Amit Patil     |     4      |    2     | 2026-01-20 | Pune |  Cancelled   |
  +----------+----------------+------------+----------+------------+------+--------------+
  (Only 3 rows because only 3 orders are from Pune)

COMMON OPERATORS:
  =    Equal to          |  <> or !=  Not equal to
  >    Greater than      |  <         Less than
  >=   Greater or equal  |  <=        Less or equal
  BETWEEN  Within range  |  LIKE      Pattern match
  IN       Match list     |  AND / OR  Combine conditions
*/

-- Practice 4.1: Filter with = (Equal to)
SELECT * FROM orders WHERE city = 'Pune';

-- Practice 4.2: Filter with <> (Not equal to)
SELECT * FROM orders WHERE city <> 'Pune';

-- Practice 4.3: Filter with > (Greater than)
SELECT * FROM products WHERE price > 50;

-- Practice 4.4: Filter with < (Less than)
SELECT * FROM products WHERE stock < 150;

-- Practice 4.5: Filter with BETWEEN
SELECT * FROM products WHERE price BETWEEN 30 AND 60;

-- Practice 4.6: Filter with LIKE (starts with 'A')
SELECT * FROM products WHERE product_name LIKE 'A%';

-- Practice 4.7: Filter with LIKE (contains 'Cola')
SELECT * FROM products WHERE product_name LIKE '%Cola%';

-- Practice 4.8: Filter with IN
SELECT * FROM orders WHERE city IN ('Pune', 'Mumbai');

-- Practice 4.9: Filter with AND (both conditions must be true)
SELECT * FROM orders WHERE city = 'Pune' AND order_status = 'Delivered';

-- Practice 4.10: Filter with OR (any one condition can be true)
SELECT * FROM orders WHERE order_status = 'Cancelled' OR order_status = 'Pending';

-- Practice 4.11: AND + OR combined (use brackets for clarity)
SELECT * FROM orders WHERE (city = 'Pune' OR city = 'Mumbai') AND order_status = 'Delivered';

-- ============================================================================
-- SECTION 5: ORDER BY - Sorting Results
-- ============================================================================

/*
WHAT IS ORDER BY?
  ORDER BY is the command that SORTS your results in a specific order.
  Think of it like arranging books on a shelf - alphabetically, by price, by date.

WHY DO WE NEED IT?
  By default, SQL returns rows in random order. ORDER BY gives you control:
  - See cheapest products first (price low to high)
  - See latest orders first (date newest to oldest)
  - Arrange names alphabetically (A to Z)

OUTPUT TYPE:
  Returns the SAME rows but REARRANGED in sorted order.

EXAMPLE OUTPUT:
  SELECT product_name, price FROM products ORDER BY price;
  +-------------------+-------+
  |   PRODUCT_NAME    | PRICE |
  +-------------------+-------+
  | Tata Salt 1Kg     | 25.00 |   <-- Cheapest first (ASC)
  | Coca Cola 750ml   | 40.00 |
  | Colgate Paste     | 55.00 |
  | Maggi Noodles     | 56.00 |
  | Amul Milk 1L      | 66.00 |   <-- Most expensive last
  +-------------------+-------+

DIRECTIONS:
  ASC  = Ascending  (A to Z, smallest to largest)  -- DEFAULT
  DESC = Descending (Z to A, largest to smallest)
*/

-- Practice 5.1: Sort by price low to high (default is ASC)
SELECT product_name, price FROM products ORDER BY price;

-- Practice 5.2: Sort by price high to low
SELECT product_name, price FROM products ORDER BY price DESC;

-- Practice 5.3: Sort orders by date (oldest first)
SELECT customer_name, order_date, order_status FROM orders ORDER BY order_date;

-- Practice 5.4: Sort orders by date (newest first)
SELECT customer_name, order_date, order_status FROM orders ORDER BY order_date DESC;

-- Practice 5.5: Sort by multiple columns (city first, then date)
SELECT city, customer_name, order_date FROM orders ORDER BY city, order_date;

-- Practice 5.6: Sort by column number (2 = second selected column = price)
SELECT product_name, price FROM products ORDER BY 2 DESC;

-- ============================================================================
-- SECTION 6: LIMIT - Restricting How Many Rows You See
-- ============================================================================

/*
WHAT IS LIMIT?
  LIMIT is the command that says 'Show me only the first N rows'.
  Think of it like reading only the top 3 search results on Google.

WHY DO WE NEED IT?
  - A table might have millions of rows. You don't want to see all of them.
  - You only need the TOP 5 most expensive products, not all 10,000.
  - Used for pagination: Show 10 results per page on a website.

OUTPUT TYPE:
  Returns a SMALLER table with only the specified number of rows.

EXAMPLE OUTPUT:
  SELECT product_name, price FROM products ORDER BY price DESC LIMIT 3;
  +-------------------+-------+
  |   PRODUCT_NAME    | PRICE |
  +-------------------+-------+
  | Amul Milk 1L      | 66.00 |   <-- Top 3 most expensive
  | Maggi Noodles     | 56.00 |
  | Colgate Paste     | 55.00 |
  +-------------------+-------+
  (Only 3 rows returned, even though table has 5 rows)

OFFSET: Skips rows before showing results (used for pagination)
  LIMIT 2 OFFSET 2  →  Skip first 2 rows, show next 2 rows
*/

-- Practice 6.1: Get only first 3 products
SELECT * FROM products LIMIT 3;

-- Practice 6.2: Top 3 most expensive products
SELECT product_name, price FROM products ORDER BY price DESC LIMIT 3;

-- Practice 6.3: First 3 orders by date
SELECT order_id, customer_name, order_date FROM orders ORDER BY order_date LIMIT 3;

-- Practice 6.4: Skip 2 rows, get next 2 (pagination)
SELECT order_id, customer_name, order_date FROM orders ORDER BY order_date LIMIT 2 OFFSET 2;

-- Practice 6.5: Cheapest product (only 1 row)
SELECT product_name, price FROM products ORDER BY price LIMIT 1;

-- ============================================================================
-- SECTION 7: GROUP BY - Grouping Rows Together
-- ============================================================================

/*
WHAT IS GROUP BY?
  GROUP BY collects rows that have the SAME value and puts them into one group.
  Think of it like sorting candies by color - all red together, all blue together.

WHY DO WE NEED IT?
  Instead of seeing every single row, you want SUMMARIES:
  - How many orders came from each city? (not every order individually)
  - What is the average price per category? (not every product individually)
  - What is the total stock for each product type?

OUTPUT TYPE:
  Returns a SUMMARY table with ONE row per group + calculated values.

EXAMPLE OUTPUT:
  SELECT city, COUNT(*) AS order_count FROM orders GROUP BY city;
  +-----------+-------------+
  |   CITY    | ORDER_COUNT |
  +-----------+-------------+
  | Bangalore |      1      |   <-- 1 order from Bangalore
  | Mumbai    |      1      |   <-- 1 order from Mumbai
  | Pune      |      3      |   <-- 3 orders from Pune
  +-----------+-------------+
  (5 rows became 3 rows because rows were GROUPED by city)

AGGREGATE FUNCTIONS (used with GROUP BY):
  COUNT(*)     - How many rows in the group?
  SUM(column)  - Total of all values in the group
  AVG(column)  - Average of all values in the group
  MAX(column)  - Highest value in the group
  MIN(column)  - Lowest value in the group
*/

-- Practice 7.1: Count total products
SELECT COUNT(*) AS total_products FROM products;

-- Practice 7.2: Count orders per city
SELECT city, COUNT(*) AS order_count FROM orders GROUP BY city;

-- Practice 7.3: Count orders per status
SELECT order_status, COUNT(*) AS status_count FROM orders GROUP BY order_status;

-- Practice 7.4: Count products per category
SELECT category, COUNT(*) AS product_count FROM products GROUP BY category;

-- Practice 7.5: Sum of all quantities ordered
SELECT SUM(quantity) AS total_items FROM orders;

-- Practice 7.6: Average product price
SELECT AVG(price) AS avg_price FROM products;

-- Practice 7.7: Max and min price
SELECT MAX(price) AS highest, MIN(price) AS lowest FROM products;

-- Practice 7.8: Total quantity per city
SELECT city, SUM(quantity) AS total_qty FROM orders GROUP BY city;

-- Practice 7.9: Group by multiple columns
SELECT city, order_status, COUNT(*) AS count FROM orders GROUP BY city, order_status;

-- ============================================================================
-- SECTION 8: HAVING - Filtering Groups (Not Rows)
-- ============================================================================

/*
WHAT IS HAVING?
  HAVING filters the GROUPS created by GROUP BY.
  Think of it like this: WHERE filters individual candies,
  but HAVING filters entire bags of candies.

WHY DO WE NEED IT?
  WHERE cannot use aggregate functions (COUNT, SUM, AVG, etc.).
  But sometimes you need to filter based on group totals:
  - Show only cities with MORE than 2 orders
  - Show only categories with average price ABOVE 50
  - These conditions need HAVING because they work on GROUPS, not rows.

OUTPUT TYPE:
  Returns a SUMMARY table with ONLY the groups that meet the condition.

EXAMPLE OUTPUT:
  SELECT city, COUNT(*) AS order_count FROM orders GROUP BY city HAVING COUNT(*) > 1;
  +------+-------------+
  | CITY | ORDER_COUNT |
  +------+-------------+
  | Pune |      3      |   <-- Only Pune has more than 1 order
  +------+-------------+
  (Bangalore and Mumbai are HIDDEN because they have only 1 order each)

WHERE vs HAVING - THE RULE:
  WHERE  = filters ROWS before grouping  →  Cannot use COUNT, SUM, AVG
  HAVING = filters GROUPS after grouping →  CAN use COUNT, SUM, AVG
*/

-- Practice 8.1: Find cities with MORE than 1 order
SELECT city, COUNT(*) AS order_count FROM orders GROUP BY city HAVING COUNT(*) > 1;

-- Practice 8.2: Find categories with average price above 40
SELECT category, AVG(price) AS avg_price FROM products GROUP BY category HAVING AVG(price) > 40;

-- Practice 8.3: Find order statuses appearing more than once
SELECT order_status, COUNT(*) AS count FROM orders GROUP BY order_status HAVING COUNT(*) > 1;

-- Practice 8.4: WHERE + GROUP BY + HAVING together
-- First WHERE filters rows, then GROUP BY groups them, then HAVING filters groups
SELECT city, COUNT(*) AS delivered_count
FROM orders
WHERE order_status = 'Delivered'
GROUP BY city
HAVING COUNT(*) >= 1;

-- ============================================================================
-- SECTION 9: COMBINED PRACTICE - Real-World Queries
-- ============================================================================

-- Query 1: Most expensive product
SELECT product_name, price FROM products ORDER BY price DESC LIMIT 1;

-- Query 2: All pending orders from Pune
SELECT customer_name, order_date, order_status
FROM orders
WHERE city = 'Pune' AND order_status = 'Pending'
ORDER BY order_date;

-- Query 3: Category-wise count and average price
SELECT category, COUNT(*) AS product_count, ROUND(AVG(price), 2) AS avg_price
FROM products
GROUP BY category
ORDER BY product_count DESC;

-- Query 4: Cities with delivered orders only
SELECT city, COUNT(*) AS delivered_orders
FROM orders
WHERE order_status = 'Delivered'
GROUP BY city
ORDER BY delivered_orders DESC;

-- Query 5: Products with stock less than 150
SELECT product_name, stock, price
FROM products
WHERE stock < 150
ORDER BY price DESC;

-- ============================================================================
-- SECTION 10: DQL CHEAT SHEET
-- ============================================================================

/*
┌─────────────────────────────────────────────────────────────────────────────┐
│                              DQL CHEAT SHEET                                │
├──────────────────┬──────────────────────────────────────────────────────────┤
│ SELECT           │ Choose columns to display                                │
│   SELECT col1, col2 FROM t;                                                │
│   SELECT * FROM t;                                                         │
│   SELECT DISTINCT col FROM t;                                              │
├──────────────────┼──────────────────────────────────────────────────────────┤
│ WHERE            │ Filter ROWS before grouping                              │
│   WHERE col = 'value'                                                      │
│   WHERE col > 100                                                          │
│   WHERE col BETWEEN 10 AND 20                                              │
│   WHERE col LIKE 'A%'                                                      │
│   WHERE col IN ('A', 'B')                                                  │
│   WHERE a = 1 AND b = 2                                                    │
│   WHERE a = 1 OR b = 2                                                     │
├──────────────────┼──────────────────────────────────────────────────────────┤
│ ORDER BY         │ Sort results                                             │
│   ORDER BY col ASC;       -- default                                       │
│   ORDER BY col DESC;                                                       │
│   ORDER BY col1, col2;                                                     │
├──────────────────┼──────────────────────────────────────────────────────────┤
│ GROUP BY         │ Group rows with same values                              │
│   Used with: COUNT(), SUM(), AVG(), MAX(), MIN()                           │
├──────────────────┼──────────────────────────────────────────────────────────┤
│ HAVING           │ Filter GROUPS after grouping                             │
│   HAVING COUNT(*) > 1                                                      │
│   HAVING AVG(col) > 50                                                     │
├──────────────────┼──────────────────────────────────────────────────────────┤
│ LIMIT            │ Restrict number of rows                                  │
│   LIMIT 5                                                                  │
│   LIMIT 3 OFFSET 2                                                         │
└──────────────────┴──────────────────────────────────────────────────────────┘

EXECUTION ORDER:
  1. FROM       -> Pick the table
  2. WHERE      -> Filter rows
  3. GROUP BY   -> Group rows
  4. HAVING     -> Filter groups
  5. SELECT     -> Choose columns
  6. ORDER BY   -> Sort results
  7. LIMIT      -> Restrict rows
*/

-- ============================================================================
-- SECTION 11: INTERVIEW QUESTIONS
-- ============================================================================

/*
═══════════════════════════════════════════════════════════════════════════════
                    PART A: SNOWFLAKE QUESTIONS (5 Questions)
═══════════════════════════════════════════════════════════════════════════════

Q1. What is the difference between LIMIT and FETCH FIRST in Snowflake?
ANSWER:
    Both restrict the number of rows returned.
    LIMIT: SELECT * FROM t LIMIT 10; (common syntax)
    FETCH FIRST: SELECT * FROM t FETCH FIRST 10 ROWS ONLY; (ANSI standard)
    Snowflake supports both. LIMIT is more commonly used.

Q2. What is a Result Cache in Snowflake?
ANSWER:
    Result Cache stores query results for 24 hours.
    If the SAME query is run again, Snowflake returns cached result
    INSTANTLY without using compute resources. Saves warehouse credits.

Q3. What is the difference between COUNT(*) and COUNT(column_name)?
ANSWER:
    COUNT(*)       - Counts ALL rows, including NULL values.
    COUNT(col)     - Counts only rows where 'col' is NOT NULL.
    If a column has 100 rows but 10 are NULL:
    COUNT(*) = 100, COUNT(col) = 90

Q4. Can you use WHERE with aggregate functions like SUM() or COUNT()?
ANSWER:
    NO. WHERE filters individual ROWS before grouping.
    To filter based on aggregated values, use HAVING instead.
    WHERE COUNT(*) > 1  --> ERROR!
    HAVING COUNT(*) > 1 --> CORRECT!

Q5. What is the difference between a View and a Table in Snowflake?
ANSWER:
    TABLE: Stores actual data physically.
    VIEW:  Is a saved SELECT query. Does NOT store data.
           Every time you query a view, it runs the underlying SELECT.
    Benefits: Reusability, security (hide columns), simplicity.

═══════════════════════════════════════════════════════════════════════════════
                    PART B: SQL DQL QUESTIONS (10 Questions)
═══════════════════════════════════════════════════════════════════════════════

Q1. What is the difference between WHERE and HAVING?
ANSWER:
    WHERE:
    - Filters individual ROWS before grouping
    - Cannot use aggregate functions
    - Executed BEFORE GROUP BY

    HAVING:
    - Filters GROUPS after grouping
    - CAN use aggregate functions
    - Executed AFTER GROUP BY

Q2. What is the purpose of the GROUP BY clause?
ANSWER:
    GROUP BY groups rows with same values into summary rows.
    Used with aggregate functions: COUNT(), SUM(), AVG(), MAX(), MIN().
    Example: GROUP BY city gives one row per city with aggregated data.

Q3. What happens if you use ORDER BY on a column with NULL values?
ANSWER:
    In Snowflake, NULL values are treated as HIGHEST by default.
    With ASC, NULLs appear at the END.
    With DESC, NULLs appear at the BEGINNING.
    You can control with: ORDER BY col NULLS FIRST;

Q4. Can you use SELECT without FROM?
ANSWER:
    YES! In Snowflake you can run SELECT without FROM:
      SELECT 5 + 3;           -- Returns 8
      SELECT CURRENT_DATE();  -- Returns today's date
      SELECT 'Hello World';   -- Returns Hello World

Q5. What is the difference between DISTINCT and GROUP BY?
ANSWER:
    DISTINCT: Returns unique values. Cannot use aggregates.
    GROUP BY: Groups rows + allows aggregate calculations.
    Example:
    SELECT DISTINCT city FROM orders;  -- Just unique cities
    SELECT city, COUNT(*) FROM orders GROUP BY city;  -- Cities + counts

Q6. What is the correct order of SQL query execution?
ANSWER:
    1. FROM       - Identify table(s)
    2. WHERE      - Filter rows
    3. GROUP BY   - Group rows
    4. HAVING     - Filter groups
    5. SELECT     - Choose columns
    6. ORDER BY   - Sort results
    7. LIMIT      - Restrict rows

Q7. What is the difference between LIMIT and OFFSET?
ANSWER:
    LIMIT:  How many rows to RETURN.
    OFFSET: How many rows to SKIP first.
    Together they enable pagination.
    Example: SELECT * FROM orders LIMIT 2 OFFSET 2;
             -- Skips first 2 rows, returns rows 3-4

Q8. Can you GROUP BY multiple columns? Give an example.
ANSWER:
    YES. One group per unique combination.
    Example:
    SELECT city, order_status, COUNT(*)
    FROM orders
    GROUP BY city, order_status;

Q9. What is an aggregate function? Name 5 common ones.
ANSWER:
    Performs calculation on a set of values, returns one value.
    1. COUNT()  2. SUM()  3. AVG()  4. MAX()  5. MIN()

Q10. Write a query to find the second highest price from products.
ANSWER:
    Method 1: Using LIMIT and OFFSET
    SELECT price FROM products ORDER BY price DESC LIMIT 1 OFFSET 1;

    Method 2: Using MAX with subquery
    SELECT MAX(price) FROM products
    WHERE price < (SELECT MAX(price) FROM products);
*/

-- ============================================================================
-- SECTION 12: CLEANUP (Run when practice is complete)
-- ============================================================================

-- Uncomment below to clean up
-- DROP TABLE IF EXISTS orders;
-- DROP TABLE IF EXISTS products;
-- DROP TABLE IF EXISTS students;
-- DROP SCHEMA IF EXISTS DQL_PRACTICE_DB.practice_schema;
-- DROP DATABASE IF EXISTS DQL_PRACTICE_DB;
-- DROP WAREHOUSE IF EXISTS PRACTICE_WH;

-- ============================================================================
-- END OF DAY 3 NOTEBOOK - KEEP PRACTICING!
-- ============================================================================


CREATE TABLE orders (
    order_id      NUMBER(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    product_id    NUMBER(10)   NOT NULL,
    quantity      NUMBER(5)    NOT NULL,
    order_date    DATE         NOT NULL,
    city          VARCHAR(50)  NOT NULL,
    order_status  VARCHAR(20)  NOT NULL,
    price         NUMBER(10,2) NOT NULL
);

INSERT INTO orders VALUES (1, 'Amit', 101, 2, DATE '2025-03-04', 'Pune', 'Delivered', 499.00);
INSERT INTO orders VALUES (2, 'Sneha', 102, 1, DATE '2025-03-05', 'Mumbai', 'Pending', 1299.00);
INSERT INTO orders VALUES (3, 'Ravi', 103, 3, DATE '2025-03-06', 'Delhi', 'Delivered', 299.00);
INSERT INTO orders VALUES (4, 'Priya', 104, 5, DATE '2025-03-07', 'Pune', 'Cancelled', 199.00);
INSERT INTO orders VALUES (5, 'Karan', 105, 2, DATE '2025-03-08', 'Hyderabad', 'Delivered', 799.00);
INSERT INTO orders VALUES (6, 'Meera', 106, 4, DATE '2025-03-09', 'Chennai', 'Delivered', 349.00);
INSERT INTO orders VALUES (7, 'Arjun', 107, 1, DATE '2025-03-10', 'Pune', 'Pending', 999.00);
INSERT INTO orders VALUES (8, 'Neha', 108, 2, DATE '2025-03-11', 'Delhi', 'Delivered', 459.00);
INSERT INTO orders VALUES (9, 'Suresh', 109, 3, DATE '2025-03-12', 'Mumbai', 'Delivered', 699.00);
INSERT INTO orders VALUES (10, 'Anita', 110, 1, DATE '2025-03-13', 'Hyderabad', 'Cancelled', 129.00);
INSERT INTO orders VALUES (11, 'Vikas', 111, 2, DATE '2025-03-14', 'Chennai', 'Delivered', 599.00);
INSERT INTO orders VALUES (12, 'Pooja', 112, 4, DATE '2025-03-15', 'Delhi', 'Pending', 899.00);
INSERT INTO orders VALUES (13, 'Rahul', 113, 2, DATE '2025-03-16', 'Pune', 'Delivered', 399.00);
INSERT INTO orders VALUES (14, 'Divya', 114, 1, DATE '2025-03-17', 'Mumbai', 'Delivered', 1499.00);
INSERT INTO orders VALUES (15, 'Sanjay', 115, 5, DATE '2025-03-18', 'Hyderabad', 'Delivered', 249.00);
INSERT INTO orders VALUES (16, 'Kavita', 116, 3, DATE '2025-03-19', 'Chennai', 'Pending', 799.00);
INSERT INTO orders VALUES (17, 'Manoj', 117, 2, DATE '2025-03-20', 'Delhi', 'Delivered', 349.00);
INSERT INTO orders VALUES (18, 'Rina', 118, 1, DATE '2025-03-21', 'Pune', 'Cancelled', 1299.00);
INSERT INTO orders VALUES (19, 'Ashok', 119, 4, DATE '2025-03-22', 'Mumbai', 'Delivered', 499.00);
INSERT INTO orders VALUES (20, 'Geeta', 120, 2, DATE '2025-03-23', 'Hyderabad', 'Delivered', 699.00);
INSERT INTO orders VALUES (21, 'Nikhil', 121, 3, DATE '2025-03-24', 'Chennai', 'Delivered', 899.00);
INSERT INTO orders VALUES (22, 'Shweta', 122, 1, DATE '2025-03-25', 'Delhi', 'Pending', 399.00);
INSERT INTO orders VALUES (23, 'Ramesh', 123, 2, DATE '2025-03-26', 'Pune', 'Delivered', 599.00);
INSERT INTO orders VALUES (24, 'Anjali', 124, 4, DATE '2025-03-27', 'Mumbai', 'Delivered', 799.00);
INSERT INTO orders VALUES (25, 'Deepak', 125, 2, DATE '2025-03-28', 'Hyderabad', 'Cancelled', 299.00);
INSERT INTO orders VALUES (26, 'Sunita', 126, 3, DATE '2025-03-29', 'Chennai', 'Delivered', 999.00);
INSERT INTO orders VALUES (27, 'Vivek', 127, 1, DATE '2025-03-30', 'Delhi', 'Delivered', 129.00);
INSERT INTO orders VALUES (28, 'Payal', 128, 2, DATE '2025-03-31', 'Pune', 'Pending', 499.00);
INSERT INTO orders VALUES (29, 'Ajay', 129, 3, DATE '2025-04-01', 'Mumbai', 'Delivered', 699.00);
INSERT INTO orders VALUES (30, 'Leena', 130, 2, DATE '2025-04-02', 'Hyderabad', 'Delivered', 899.00);
