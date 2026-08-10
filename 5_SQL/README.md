# SQL with Snowflake - Class Notes

---

## PAGE 1

### 1. What is Snowflake?

- Snowflake is a Cloud Data Warehouse.
- It means: a place on the internet (cloud) where we store and manage large amount of data.
- We do not need to install anything on our computer. It works fully on browser.
- It is used by companies to store data and run SQL queries on that data fast.
- Snowflake separates two things:
  - Storage (where data is kept)
  - Compute / Warehouse (the engine that runs the query)
- This separation makes it fast and flexible. We pay only for what we use.

### Free Credits in Snowflake

- When you create a Snowflake trial account, you get free credits.
- Free trial gives around 400 dollars worth of free usage (validity around 30 days).
- These credits are used when your "Warehouse" (compute engine) is running.
- If warehouse is OFF, no credit is used.
- Good practice: always turn OFF warehouse after your work is done, so credits are saved.

---

### 2. Why we use Snowflake for SQL in Data Science?

- Data Science needs clean, organised, large data. Snowflake stores that data properly.
- Reasons to use Snowflake:
  - It can handle very large datasets (millions of rows) easily.
  - It supports normal SQL, so easy to learn and use.
  - It can store both structured data (tables) and semi-structured data (JSON, CSV files).
  - Multiple people can work on same data at same time without conflict.
  - Cloud based, so no installation, just login and start writing SQL.
  - Easily connects with Python, Tableau, Power BI, and other Data Science tools.
- In short: Snowflake gives us a real-world platform to practice SQL exactly like companies use it.

---

## PAGE 2

### 3. Difference between SQL and NoSQL (Simple Examples)

| Point | SQL | NoSQL |
|---|---|---|
| Full form | Structured Query Language | Not Only SQL |
| Data Format | Data stored in Tables (rows and columns) | Data stored in Documents, Key-Value, Graphs |
| Structure | Fixed structure (schema) needed before storing data | Flexible, no fixed structure needed |
| Example Databases | MySQL, Snowflake, Oracle, PostgreSQL | MongoDB, Firebase, Cassandra |
| Best For | Data with clear relationships (Banking, Billing) | Data that changes often (Social media posts, logs) |

**Simple Example:**

SQL Example (Table format):

| StudentID | Name | Marks |
|---|---|---|
| 1 | Raj | 85 |
| 2 | Priya | 90 |

- Every row has same columns. This is SQL style (structured).

NoSQL Example (Document format, like JSON):

```
{
  "StudentID": 1,
  "Name": "Raj",
  "Marks": 85,
  "Hobbies": ["Cricket", "Reading"]
}
```

- Here, one student can have extra field "Hobbies" and other student may not have it. This is NoSQL style (flexible).

---

## PAGE 3

### 4. Snowflake SQL - 5 Main Commands

SQL commands are divided into 5 main categories. Each category has its own job.

**1. DDL - Data Definition Language**
- Used to define or change the structure of database objects (table, database, schema).
- Commands inside DDL:
  - CREATE - to create table, database, warehouse
  - ALTER - to change structure of existing table
  - DROP - to delete table or database permanently
  - TRUNCATE - to remove all data from table but keep the table structure

**2. DML - Data Manipulation Language**
- Used to insert, update or delete actual data inside the table.
- Commands inside DML:
  - INSERT - to add new row of data
  - UPDATE - to change existing data
  - DELETE - to remove specific row of data

**3. DQL - Data Query Language**
- Used to read or fetch data from table. Most used command in Data Science.
- Command inside DQL:
  - SELECT - to view/fetch data from table

**4. DCL - Data Control Language**
- Used to give or remove access/permission to users.
- Commands inside DCL:
  - GRANT - to give permission to a user or role
  - REVOKE - to remove permission from a user or role

**5. TCL - Transaction Control Language**
- Used to manage transactions (a group of SQL steps done together).
- Commands inside TCL:
  - COMMIT - to save all changes permanently
  - ROLLBACK - to undo changes if something goes wrong
  - SAVEPOINT - to set a point to which we can rollback later

---

**Quick Memory Trick:**
- DDL = Structure (Design)
- DML = Data (Change)
- DQL = Query (Read)
- DCL = Control (Access)
- TCL = Transaction (Save/Undo)
