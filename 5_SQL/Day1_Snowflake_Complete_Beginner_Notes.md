# Day 1: Snowflake + SQL, Complete Beginner Notes

You just created a brand new Snowflake account. It comes with $400 free credits to practice. Nothing is created yet, no database, no table, nothing. We build everything today, step by step, starting from zero.

---

## Part 1: What is Snowflake

Snowflake is a cloud data platform. In simple words, it is a big online office building where we store data (in cupboards/tables) and also rent workers (warehouses) to do calculations on that data.

Snowflake has 4 basic building blocks. Understand these fully before typing a single command.

### 1. Database
The whole "building". It holds everything related to one project or company.
Example: `BLINKIT_DB`

### 2. Schema
A "floor" inside that building. One building (database) can have many floors (schemas), used to organize things further.
Example: `BLINKIT_SCHEMA`

### 3. Table
A "cupboard" on that floor, where the actual data sits in rows and columns, like an Excel sheet.
Example: `PRODUCTS`

### 4. Warehouse
This is NOT a storage place. This is the "team of workers" that Snowflake hires to actually run your SQL commands. Your database and table can exist, but if there is no warehouse running, nobody is there to do the work, so nothing happens.

**Yes, you always need a Warehouse to run SQL queries in Snowflake, even if your database and tables already exist.** Think of it like this:

* Database and Table = your office and your filing cabinet, they just sit there
* Warehouse = the staff who actually walk to the cabinet, pull out the file, read it, and hand you the answer

No staff (warehouse) = no work gets done, even if the filing cabinet is right there.

The full address of any table is always:

```
DATABASE.SCHEMA.TABLE
```

Example: `BLINKIT_DB.BLINKIT_SCHEMA.PRODUCTS`

---

## Part 2: Create our Warehouse first

```sql
CREATE WAREHOUSE BLINKIT_WH
WITH WAREHOUSE_SIZE = 'X-SMALL'
  AUTO_SUSPEND = 300
  AUTO_RESUME = TRUE;
```

What each part means, in plain words:

* `WAREHOUSE_SIZE = 'X-SMALL'` — smallest, cheapest team of workers. Good enough for practice and learning. Bigger sizes (SMALL, MEDIUM, LARGE, X-LARGE...) mean more workers, faster results, but more credits used.
* `AUTO_SUSPEND = 300` — if nobody sends any command for 300 seconds (5 minutes), the workers automatically go home. This means you stop paying credits when the warehouse is sitting idle.
* `AUTO_RESUME = TRUE` — the moment you send a new SQL command, the workers automatically come back on their own. You never have to manually "start" the warehouse again.

This one warehouse setup is exactly why you don't waste your $400 free credits by accident. It switches off by itself when idle, and switches on by itself when needed.

---

## Part 3: Create our Database and Schema

```sql
CREATE DATABASE BLINKIT_DB;

CREATE SCHEMA BLINKIT_DB.BLINKIT_SCHEMA;
```

* First line builds the "building" called BLINKIT_DB
* Second line builds a "floor" called BLINKIT_SCHEMA inside it

At this point we have: workers ready (warehouse), building ready (database), floor ready (schema). Now we need the cupboard (table).

---

## Part 4: The 5 categories of SQL commands

Every SQL command in the world falls into one of these 5 buckets. Today we will mainly touch DDL and DML. The rest (DCL, TCL) you will use later, but you should know what they mean from day 1.

| Category | Full Form | What it does | Example Commands |
|---|---|---|---|
| **DDL** | Data Definition Language | Defines and manages the structure, like building or removing cupboards, floors, buildings | `CREATE`, `ALTER`, `DROP` |
| **DML** | Data Manipulation Language | Changes the actual data sitting inside the cupboard, adding, changing, removing rows | `INSERT`, `UPDATE`, `DELETE` |
| **DQL** | Data Query Language | Only reads/asks questions from the data, changes nothing | `SELECT` |
| **DCL** | Data Control Language | Controls who is allowed to enter and do what, like security passes | `GRANT`, `REVOKE` |
| **TCL** | Transaction Control Language | Makes sure a group of changes either fully happen or fully cancel, keeping data safe and consistent | `COMMIT`, `ROLLBACK`, `SAVEPOINT` |

Simple way to remember: DDL builds the structure, DML changes the data inside it, DQL reads the data, DCL controls who is allowed in, TCL protects the changes from going wrong halfway.

---

## Part 5: What is a Primary Key

A **Primary Key** is one column (or a small set of columns) in a table that uniquely identifies every single row. No two rows are ever allowed to have the same primary key value, and it can never be empty.

Think of it like an Aadhar number or a roll number in a class. Two students can have the same name, but never the same roll number. That roll number is the "primary key" of the class register.

In our BLINKIT products table, `PRODUCT_ID` will be the primary key. Every product gets one unique ID number, no repeats.

This is defined inside the `CREATE TABLE` command, which is a DDL command, because it is part of defining the table's structure.

---

## Part 6: Common SQL Data Types (Snowflake)

Every column in a table must have a data type, this tells Snowflake what kind of value is allowed to go inside it.

| Data Type | Used for | Example value |
|---|---|---|
| `NUMBER` or `INT` | Whole numbers | 101, 25, 500 |
| `DECIMAL(10,2)` | Numbers with decimal points, like price | 49.50, 199.99 |
| `VARCHAR(n)` or `STRING` | Text, letters, names | 'Amul Milk 1L' |
| `DATE` | Only a date | '2026-08-11' |
| `BOOLEAN` | True or False values only | TRUE, FALSE |

`n` in `VARCHAR(n)` means the maximum number of characters allowed. Example: `VARCHAR(100)` allows up to 100 characters of text.

---

## Part 7: Create our first real table (Blinkit Products)

We are building a simple product table like the one Blinkit (grocery delivery app) would use. 5 columns total.

```sql
CREATE OR REPLACE TABLE BLINKIT_DB.BLINKIT_SCHEMA.PRODUCTS (
    PRODUCT_ID       NUMBER PRIMARY KEY,
    PRODUCT_NAME     VARCHAR(100),
    CATEGORY         VARCHAR(50),
    PRICE            DECIMAL(10,2),
    QUANTITY_IN_STOCK NUMBER
);
```

What each column means:

* `PRODUCT_ID` — unique number for every product, this is our Primary Key
* `PRODUCT_NAME` — name of the product, text up to 100 characters
* `CATEGORY` — which section it belongs to, like Dairy, Snacks, Fruits
* `PRICE` — cost of the product, allows decimal values like 49.50
* `QUANTITY_IN_STOCK` — how many units are currently available

---

## Part 8: Insert 10 rows of data (DML)

```sql
INSERT INTO BLINKIT_DB.BLINKIT_SCHEMA.PRODUCTS
(PRODUCT_ID, PRODUCT_NAME, CATEGORY, PRICE, QUANTITY_IN_STOCK)
VALUES
(1, 'Amul Milk 1L', 'Dairy', 66.00, 120),
(2, 'Britannia Bread', 'Bakery', 45.00, 80),
(3, 'Tata Salt 1Kg', 'Grocery', 25.00, 200),
(4, 'Maggi Noodles 4pack', 'Instant Food', 56.00, 150),
(5, 'Fortune Sunflower Oil 1L', 'Grocery', 145.00, 60),
(6, 'Banana Robusta 1Dozen', 'Fruits', 48.00, 90),
(7, 'Onion 1Kg', 'Vegetables', 32.00, 300),
(8, 'Colgate Toothpaste 100g', 'Personal Care', 55.00, 100),
(9, 'Lays Chips Classic', 'Snacks', 20.00, 250),
(10, 'Coca Cola 750ml', 'Beverages', 40.00, 180);
```

What happened: we just placed 10 real rows of grocery product data inside our PRODUCTS cupboard. Each row got its own unique PRODUCT_ID from 1 to 10.

---

## Part 9: Check that the data is actually there (DQL)

```sql
SELECT * FROM BLINKIT_DB.BLINKIT_SCHEMA.PRODUCTS;
```

`SELECT *` means "show me every column." This command reads and displays all 10 rows we just inserted. If you see all 10 rows with correct values, today's goal is complete.

---

## Full recap, in the order we did it today

| Step | Command Type | What we did |
|---|---|---|
| 1 | DDL | Created warehouse BLINKIT_WH (X-SMALL, auto suspend and resume) |
| 2 | DDL | Created database BLINKIT_DB |
| 3 | DDL | Created schema BLINKIT_SCHEMA |
| 4 | DDL | Created table PRODUCTS with 5 columns and a Primary Key |
| 5 | DML | Inserted 10 rows of Blinkit product data |
| 6 | DQL | Used SELECT to confirm the data is actually saved |

---

## What is coming next (Day 2 onward)

* DML deeper practice: `UPDATE` a price, `DELETE` a product
* DQL deeper practice: `WHERE`, `ORDER BY`, `GROUP BY` on this same PRODUCTS table
* DCL: `GRANT` and `REVOKE` access to a role
* TCL: `COMMIT` and `ROLLBACK` to safely undo mistakes before saving them permanently
* Later: a second table like ORDERS, so we can practice JOIN between PRODUCTS and ORDERS
