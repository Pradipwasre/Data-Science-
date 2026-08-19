CREATE OR REPLACE DATABASE SQL_LEARNING_DB;

USE DATABASE SQL_LEARNING_DB;

CREATE OR REPLACE SCHEMA PRACTICE;

USE SCHEMA PRACTICE;


CREATE OR REPLACE TABLE CUSTOMERS (
    CUSTOMER_ID NUMBER,
    FIRST_NAME VARCHAR(50),
    LAST_NAME VARCHAR(50),
    CITY VARCHAR(50),
    STATE VARCHAR(50),
    AGE NUMBER,
    GENDER VARCHAR(10),
    CUSTOMER_TYPE VARCHAR(20),
    SIGNUP_DATE DATE,
    IS_ACTIVE BOOLEAN
);

INSERT INTO CUSTOMERS
(CUSTOMER_ID, FIRST_NAME, LAST_NAME, CITY, STATE, AGE, GENDER, CUSTOMER_TYPE, SIGNUP_DATE, IS_ACTIVE)
VALUES
(1, 'Aarav', 'Sharma', 'Pune', 'Maharashtra', 24, 'Male', 'Regular', '2024-01-15', TRUE),
(2, 'Priya', 'Patel', 'Mumbai', 'Maharashtra', 31, 'Female', 'Premium', '2023-11-20', TRUE),
(3, 'Rohan', 'Mehta', 'Delhi', 'Delhi', 42, 'Male', 'Regular', '2022-05-10', TRUE),
(4, 'Sneha', 'Joshi', 'Bangalore', 'Karnataka', 27, 'Female', 'Premium', '2024-02-18', TRUE),
(5, 'Vikram', 'Singh', 'Jaipur', 'Rajasthan', 36, 'Male', 'Regular', '2023-08-12', FALSE),
(6, 'Ananya', 'Iyer', 'Chennai', 'Tamil Nadu', 22, 'Female', 'Regular', '2024-03-05', TRUE),
(7, 'Rahul', 'Verma', 'Hyderabad', 'Telangana', 29, 'Male', 'Premium', '2023-12-01', TRUE),
(8, 'Neha', 'Kapoor', 'Delhi', 'Delhi', 34, 'Female', 'Regular', '2022-09-25', TRUE),
(9, 'Aditya', 'Nair', 'Kochi', 'Kerala', 45, 'Male', 'Premium', '2021-06-14', FALSE),
(10, 'Pooja', 'Reddy', 'Hyderabad', 'Telangana', 26, 'Female', 'Regular', '2024-01-30', TRUE),
(11, 'Karan', 'Malhotra', 'Chandigarh', 'Punjab', 39, 'Male', 'Premium', '2022-03-17', TRUE),
(12, 'Meera', 'Desai', 'Ahmedabad', 'Gujarat', 30, 'Female', 'Regular', '2023-04-22', TRUE),
(13, 'Arjun', 'Kumar', 'Pune', 'Maharashtra', 28, 'Male', 'Regular', '2024-02-01', TRUE),
(14, 'Kavya', 'Rao', 'Bangalore', 'Karnataka', 33, 'Female', 'Premium', '2022-12-11', TRUE),
(15, 'Siddharth', 'Shah', 'Surat', 'Gujarat', 41, 'Male', 'Regular', '2021-10-09', FALSE),
(16, 'Ishita', 'Gupta', 'Noida', 'Uttar Pradesh', 25, 'Female', 'Regular', '2024-04-15', TRUE),
(17, 'Manish', 'Agarwal', 'Kolkata', 'West Bengal', 48, 'Male', 'Premium', '2020-07-19', TRUE),
(18, 'Riya', 'Bose', 'Kolkata', 'West Bengal', 23, 'Female', 'Regular', '2024-03-28', TRUE),
(19, 'Nikhil', 'Bansal', 'Gurgaon', 'Haryana', 37, 'Male', 'Premium', '2023-01-16', TRUE),
(20, 'Simran', 'Kaur', 'Amritsar', 'Punjab', 32, 'Female', 'Regular', '2022-11-05', FALSE),
(21, 'Yash', 'Chopra', 'Pune', 'Maharashtra', 21, 'Male', 'Regular', '2024-05-10', TRUE),
(22, 'Divya', 'Menon', 'Chennai', 'Tamil Nadu', 38, 'Female', 'Premium', '2021-09-13', TRUE),
(23, 'Varun', 'Sethi', 'Delhi', 'Delhi', 44, 'Male', 'Regular', '2022-02-25', TRUE),
(24, 'Tanvi', 'Kulkarni', 'Nagpur', 'Maharashtra', 29, 'Female', 'Premium', '2023-06-18', TRUE),
(25, 'Mohit', 'Tiwari', 'Lucknow', 'Uttar Pradesh', 35, 'Male', 'Regular', '2023-10-27', FALSE);



CREATE OR REPLACE TABLE ORDERS (
    ORDER_ID NUMBER,
    CUSTOMER_ID NUMBER,
    ORDER_DATE DATE,
    PRODUCT_NAME VARCHAR(100),
    CATEGORY VARCHAR(50),
    QUANTITY NUMBER,
    UNIT_PRICE NUMBER(10,2),
    ORDER_AMOUNT NUMBER(10,2),
    PAYMENT_METHOD VARCHAR(30),
    ORDER_STATUS VARCHAR(30)
);

INSERT INTO ORDERS
(ORDER_ID, CUSTOMER_ID, ORDER_DATE, PRODUCT_NAME, CATEGORY, QUANTITY, UNIT_PRICE, ORDER_AMOUNT, PAYMENT_METHOD, ORDER_STATUS)
VALUES
(1001, 1, '2024-05-01', 'Laptop', 'Electronics', 1, 75000, 75000, 'Credit Card', 'Delivered'),

(1002, 2, '2024-05-03', 'Headphones', 'Electronics', 2, 3500, 7000, 'UPI', 'Delivered'),

(1003, 4, '2024-05-05', 'Office Chair', 'Furniture', 1, 12000, 12000, 'Debit Card', 'Shipped'),

(1004, 7, '2024-05-07', 'Smartphone', 'Electronics', 1, 55000, 55000, 'Credit Card', 'Delivered'),

(1005, 8, '2024-05-10', 'Keyboard', 'Accessories', 1, 2500, 2500, 'UPI', 'Cancelled'),

(1006, 11, '2024-05-12', 'Monitor', 'Electronics', 2, 18000, 36000, 'Net Banking', 'Delivered'),

(1007, 13, '2024-05-15', 'Backpack', 'Accessories', 3, 1800, 5400, 'UPI', 'Pending'),

(1008, 14, '2024-05-18', 'Tablet', 'Electronics', 1, 28000, 28000, 'Credit Card', 'Shipped'),

(1009, 17, '2024-05-20', 'Desk', 'Furniture', 1, 15000, 15000, 'Debit Card', 'Delivered'),

(1010, 21, '2024-05-22', 'Mouse', 'Accessories', 2, 1200, 2400, 'UPI', 'Pending');
