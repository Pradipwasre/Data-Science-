CREATE TABLE employees (
    emp_id      INTEGER,
    emp_name    VARCHAR(50),
    dept_id     INTEGER,
    salary      INTEGER,
    join_date   DATE
);


CREATE TABLE departments (
    dept_id     INTEGER,
    dept_name   VARCHAR(50),
    location    VARCHAR(50),
    budget      INTEGER
);


INSERT INTO employees VALUES
(1,  'Alice',   10,  70000, '2023-01-15'),
(2,  'Bob',     20,  85000, '2022-06-20'),
(3,  'Carol',   10,  72000, '2023-03-10'),
(4,  'David',   30,  90000, '2021-11-05'),
(5,  'Eve',     NULL,65000, '2024-01-20'),
(6,  'Frank',   20,  88000, '2022-09-12'),
(7,  'Grace',   40,  95000, '2020-05-18'),
(8,  'Henry',   NULL,60000, '2024-02-28'),
(9,  'Ivy',     10,  75000, '2023-07-01'),
(10, 'Jack',    50,  80000, '2022-12-10'),
(11, 'Kate',    30,  92000, '2023-08-14'),
(12, 'Leo',     NULL,70000, '2024-03-05');


INSERT INTO departments VALUES
(10, 'Engineering', 'New York',    500000),
(20, 'Marketing',   'Los Angeles', 300000),
(30, 'Sales',       'Chicago',     400000),
(40, 'HR',          'Boston',      150000),
(50, 'Finance',     'Seattle',     250000),
(60, 'Operations',  'Denver',      200000),
(70, 'IT Support',  'Austin',      180000),
(80, 'Legal',       'Miami',       220000);
