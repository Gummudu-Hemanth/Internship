use joinsnormalization;

-- Joins are used in SQL to combine rows from two or more tables based on a related column between them. 
-- Types of Joins:->
-- 1. Inner Join
-- 2. Left Join
-- 3. Right Join
-- 4. Full Join

-- Create the employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INT
);
-- Insert values into the employees table
INSERT INTO employees (employee_id, employee_name, department_id) VALUES
(1, 'Alice', 1),
(2, 'Bob', 2),
(3, 'Charlie', NULL),
(4, 'David', 1),
(5, 'Eve', 3);

-- Create the departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);
-- Insert values into the departments table
INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'Engineering'),
(3, 'Marketing');


# INNER JOIN
-- Returns only the rows that have matching values in both tables.
SELECT employees.employee_name, departments.department_name
FROM employees
INNER JOIN departments ON employees.department_id = departments.department_id;

# LEFT JOIN
-- Returns all rows from the left table, and the matched rows from the right table. 
-- If there is no match, NULL values are returned for columns from the right table.
SELECT employees.employee_name, departments.department_name
FROM employees
LEFT JOIN departments ON employees.department_id = departments.department_id;

# RIGHT JOIN
-- Returns all rows from the right table, and the matched rows from the left table. 
-- If there is no match, NULL values are returned for columns from the left table.
SELECT employees.employee_name, departments.department_name
FROM employees
RIGHT JOIN departments ON employees.department_id = departments.department_id;

# FULL JOIN
-- Returns all rows when there is a match in one of the tables. 
-- If there is no match, NULL values are returned for columns from the table without a match.
SELECT employees.employee_name, departments.department_name
FROM employees
FULL JOIN departments ON employees.department_id = departments.department_id;


-- NORMALIZATION
-- Normalization is a process in database design to organize data to minimize redundancy and improve data integrity. 
-- The goal is to divide large tables into smaller, related tables and define relationships between them. 
-- The different stages of normalization are called normal forms.

-- First Normal Form (1NF): Ensures that the table has no repeating groups and each column contains atomic values.
-- Second Normal Form (2NF): Achieves 1NF and ensures that every non-key column is fully functionally dependent on the primary key.
-- Third Normal Form (3NF): Achieves 2NF and ensures that no non-key column is transitively dependent on the primary key.

# 1NF
-- A table is in 1NF if:
-- Each column contains atomic (indivisible) values.
-- Each column contains values of a single type.
-- Each column has a unique name.
-- The order in which data is stored does not matter.

-- The Order table shown below is not in 1NF format because products column contains multiple values. 
--  OrderID  CustomerName    Products              OrderDate 

-- 1          Alice         Laptop, Smartphone    2023-01-01 
-- 2          Bob           Smartphone            2023-01-02 
-- 3         Alice          Tablet, Laptop        2023-01-03 

--  Changing the above table into suitable 1NF format.
-- Create the orders table in 1NF
CREATE TABLE orders (
    OrderID INT,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    OrderDate DATE,
    PRIMARY KEY (OrderID, Product)
);

-- Insert values into the orders table
INSERT INTO orders (OrderID, CustomerName, Product, OrderDate) VALUES
(1, 'Alice', 'Laptop', '2023-01-01'),
(1, 'Alice', 'Smartphone', '2023-01-01'),
(2, 'Bob', 'Smartphone', '2023-01-02'),
(3, 'Alice', 'Tablet', '2023-01-03'),
(3, 'Alice', 'Laptop', '2023-01-03');

-- The new table structure ensures that each column contains atomic values:
-- OrderID: Unique identifier for each order (part of the primary key).
-- CustomerName: Name of the customer who placed the order.
-- Product: Each product listed as a separate row (part of the primary key).
-- OrderDate: Date when the order was placed.

# 2NF
-- A table is in 2NF if:
-- It is in 1NF.
-- All non-key attributes are fully functionally dependent on the entire primary key.
-- This means that there should be no partial dependency of any column on the primary key. 
-- Partial dependency occurs when a non-key column is dependent on only a part of a composite primary key.

-- Table order_items is in 1NF but not in 2NF
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    order_date DATE,
    customer_name VARCHAR(50),
    product_name VARCHAR(50),
    product_price DECIMAL(10, 2),
    PRIMARY KEY (order_id, product_id)
);
-- order_id and product_id together form the composite primary key.
-- order_date and customer_name depend only on order_id.
-- product_name and product_price depend only on product_id.
-- Thus, the table has partial dependencies, which violates 2NF.

-- CONVERTING TO 2NF
-- To convert this table to 2NF, we need to remove the partial dependencies by splitting the table into 
-- smaller tables where each non-key attribute depends on the entire primary key of its respective table.
-- Create the orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_name VARCHAR(50)
);

-- Create the products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    product_price DECIMAL(10, 2)
);

-- Create the order_items table 
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert values into the orders table
INSERT INTO orders (order_id, order_date, customer_name) VALUES
(1, '2023-01-01', 'Alice'),
(2, '2023-01-02', 'Bob'),
(3, '2023-01-03', 'Alice');

-- Insert values into the products table
INSERT INTO products (product_id, product_name, product_price) VALUES
(1, 'Laptop', 1000.00),
(2, 'Smartphone', 500.00),
(3, 'Tablet', 300.00);

-- Insert values into the order_items table
INSERT INTO order_items (order_id, product_id) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 3),
(3, 1);

-- By splitting the original table into these three tables, we have:
-- Eliminated partial dependencies.
-- Ensured that every non-key attribute is fully functionally dependent on the primary key.
-- Improved data integrity and reduced redundancy.

# 3NF
-- steps to Achieve 3NF
-- Step 1: First Normal Form (1NF)
-- Ensure atomicity and eliminate repeating groups:
-- Each table should have a primary key.
-- Columns should contain atomic values (no multivalued attributes).

-- Step 2: Second Normal Form (2NF)
-- Remove partial dependencies:
-- Ensure all non-key attributes are fully functionally dependent on the primary key.
-- If needed, split tables to avoid redundancy.

-- Step 3: Third Normal Form (3NF)
-- Remove transitive dependencies: Ensure that no non-key column is transitively dependent on the primary key.

-- creating table to explain 3NF
-- Create Authors table
CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100)
);

-- Insert values into Authors table
INSERT INTO Authors (author_id, author_name) VALUES
(1, 'J.K. Rowling'),
(2, 'George R.R. Martin'),
(3, 'Harper Lee');

-- Create Publishers table
CREATE TABLE Publishers (
    publisher_id INT PRIMARY KEY,
    publisher_name VARCHAR(100),
    country VARCHAR(50)
);

-- Insert values into Publishers table
INSERT INTO Publishers (publisher_id, publisher_name, country) VALUES
(1, 'Bloomsbury', 'UK'),
(2, 'Bantam Books', 'USA'),
(3, 'J.B. Lippincott & Co.', 'USA');

-- Create Books table
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(200),
    author_id INT,
    publisher_id INT,
    publish_year INT,
    isbn VARCHAR(20),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id),
    FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id)
);

-- Insert values into Books table
INSERT INTO Books (book_id, title, author_id, publisher_id, publish_year, isbn) VALUES
(1, 'Harry Potter and the Philosopher''s Stone', 1, 1, 1997, '9780747532743'),
(2, 'A Game of Thrones', 2, 2, 1996, '9780553103540'),
(3, 'To Kill a Mockingbird', 3, 3, 1960, '9780061120084');

-- Create BookCopies table
CREATE TABLE BookCopies (
    copy_id INT PRIMARY KEY,
    book_id INT,
    copy_number INT,
    availability_status VARCHAR(20),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Insert values into BookCopies table
INSERT INTO BookCopies (copy_id, book_id, copy_number, availability_status) VALUES
(1, 1, 1, 'available'),
(2, 1, 2, 'borrowed'),
(3, 2, 1, 'available'),
(4, 3, 1, 'available');

-- Create Transactions table
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    copy_id INT,
    transaction_date DATE,
    return_date DATE,
    borrower_name VARCHAR(100),
    FOREIGN KEY (copy_id) REFERENCES BookCopies(copy_id)
);

-- Insert values into Transactions table
INSERT INTO Transactions (transaction_id, copy_id, transaction_date, return_date, borrower_name) VALUES
(1, 1, '2023-01-05', NULL, 'Alice'),
(2, 2, '2023-01-10', '2023-01-20', 'Bob'),
(3, 3, '2023-02-15', NULL, 'Eve');
