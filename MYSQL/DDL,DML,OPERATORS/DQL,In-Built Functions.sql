# DQL COMMANDS
-- DQL commands (SELECT statements) in MySQL are essential for retrieving and querying data from tables. 
-- They allow you to specify which columns to fetch, filter rows based on conditions (WHERE clause), sort results 
-- (ORDER BY clause), limit the number of rows returned (LIMIT clause), perform calculations using aggregate functions, 
-- and group data (GROUP BY clause) for analysis. 

use project;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

INSERT INTO products (product_name, price) VALUES
    ('Keyboard', 49.99),
    ('Mouse', 19.99),
    ('Monitor', 199.99),
    ('Headphones', 99.50),
    ('Printer', 149.00);

-- Basic SELECT Statement
-- Retrieve all columns from the products table:
SELECT * FROM products;

-- Selecting Specific Columns
-- Retrieve only the product_name and price columns:
SELECT product_name, price FROM products;

-- Using WHERE Clause
-- Retrieve products with a specific condition, e.g., products with a price greater than 50:
SELECT * FROM products
WHERE price > 50;

-- Using ORDER BY Clause
-- Retrieve products sorted by price in descending order:
SELECT * FROM products
ORDER BY price DESC;

-- Using LIMIT Clause
-- Retrieve only the first 5 products:
SELECT * FROM products
LIMIT 5;

-- Using Aggregate Functions
-- Calculate the average price of all products:
SELECT AVG(price) AS average_price FROM products;

 -- Using GROUP BY Clause
-- Count the number of products in each price range (e.g., count products grouped by price ranges):
SELECT CASE
           WHEN price < 50 THEN 'Under 50'
           WHEN price BETWEEN 50 AND 100 THEN '50-100'
           ELSE 'Over 100'
       END AS price_range,
       COUNT(*) AS product_count
FROM products
GROUP BY price_range;


# MySQL in-built Operatons
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    hire_date DATE NOT NULL
);
INSERT INTO employees (name, salary, hire_date) VALUES
('John Doe', 50000.00, '2020-01-15'),
('Jane Smith', 60000.50, '2019-05-20'),
('Michael Johnson', 75000.75, '2021-03-10'),
('Emily Davis', 55000.25, '2022-02-28');

-- The LEFT() function returns the leftmost characters from a string.
SELECT name, LEFT(name, 4) AS first_four_characters
FROM employees;

T-- he ROUND() function rounds a number to a specified number of decimal places.
SELECT name, salary, ROUND(salary, 2) AS rounded_salary
FROM employees;

-- The DATEDIFF() function returns the number of days between two dates.
SELECT name, hire_date, DATEDIFF(CURDATE(), hire_date) AS days_since_hire
FROM employees;

-- The SUM() function calculates the sum of a numeric column.
SELECT SUM(salary) AS total_salary
FROM employees;

-- The CASE statement evaluates conditions and returns a value when the first condition is met.
SELECT name, 
       CASE 
           WHEN salary >= 70000 THEN 'High'
           WHEN salary >= 60000 THEN 'Medium'
           ELSE 'Low'
       END AS salary_category
FROM employees;
