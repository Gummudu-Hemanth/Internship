use amazon;

CREATE TABLE departments(
	dept_id int auto_increment primary key,
    dept_name varchar(50)
);

CREATE TABLE employees(
	emp_id int auto_increment primary key,
    emp_name varchar(50),
    dept_id int,
    foreign key(dept_id) references  departments (dept_id)
);

CREATE TABLE salaries (
	salary_id int auto_increment primary key,
    emp_id int,
    salary decimal(10,2),
    foreign key (emp_id) references employees(emp_id)
);

INSERT INTO departments (dept_name)
VALUES
('HR'),
('Engineering'),
('Finance');

INSERT INTO employees(emp_name , dept_id)
VALUES
('Hemanth' , 1),
('Arreyan' , 2),
('Surya' , 3),
('Muskan' , 1),
('Subah' , 3);

INSERT INTO salaries(emp_id , salary)
VALUES
(1,60000),
(2,3000),
(3,90000),
(4,9000),
(5,23000);
# WHAT IS SUBQUERY
-- A subquery is a query within another query
-- Subqueries can be used in various SQL clauses including SELECT, FROM, WHERE, and HAVING.

-- Types of Subqueries
-- Single-Row Subquery: Returns zero or one row.
-- Multiple-Row Subquery: Returns one or more rows.
-- Multiple-Column Subquery: Returns one or more columns.
-- Correlated Subquery: A subquery that references columns from the outer query

# SINGLE ROW SUBQUERY
-- It return zero or one row
-- Find the employee with the highest salary

SELECT emp_name
from employees
where emp_id = (SELECT emp_id FROM salaries ORDER BY salary DESC LIMIT 1);

# MULTIPLE ROW SUBQUERY
-- It returns the 1 or more rows
-- Find employees who work in the 'Finance' department:

SELECT emp_name
from employees
where dept_id = (SELECT dept_id FROM departments WHERE dept_name = "Finance");

# MULTI COLUMN SUBQUERY
-- It return one or more columns
-- Get the department name and the highest salary in that department:
SELECT d.dept_name, MAX(s.salaries)
FROM departments d
JOIN employees e ON d.dept_id = e.dept_id
JOIN salaries s ON e.emp_id = s.emp_id
GROUP BY d.dept_name;

# CORELATED SUBQUERY
-- Subquery that takes the reference from outer query
SELECT e.emp_name, s.salary
FROM employees e
JOIN salaries s ON e.emp_id = s.emp_id
WHERE s.salary > (
    SELECT AVG(salary)
    FROM salaries
    WHERE emp_id IN (
        SELECT emp_id
        FROM employees
        WHERE dept_id = e.department_id
    )
);

# JOINS
-- we are using the above to created tables to explain the concept of MYSql Joins
 
-- Joins are used to combine rows from two or more tables based on a related column between them
-- Types of Joins

# 1. Inner Join
-- Combines rows from two tables based on a related column.
-- Only returns rows where there is a match in both tables.

SELECT e.employee_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

# LEFT JOIN
-- Returns all rows from the left table and matched rows from the right table.
-- Non-matching rows from the right table will have NULL values.

SELECT e.employee_name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;

# RIGHT JOIN
--  Returns all records from the right table, and the matched records from the left table. 
--  The result is NULL from the left side if there is no match.

SELECT e.employee_name, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id;

# FULL OUTER JOIN
-- Returns all rows when there is a match in either table.
-- This is achieved using UNION of LEFT JOIN and RIGHT JOIN .

SELECT e.employee_name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
UNION
SELECT e.employee_name, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id;

# CROSS JOIN
-- Returns the Cartesian product of both tables.
-- This means every row in the first table is paired with every row in the second table.

SELECT e.employee_name, d.department_name
FROM employees e
CROSS JOIN departments d;

# SELF JOIN
-- Joins a table with itself.
-- Useful for comparisons within the same table, like finding employees working in the same department.

SELECT e1.employee_name AS Employee1, e2.employee_name AS Employee2
FROM employees e1, employees e2
WHERE e1.department_id = e2.department_id AND e1.employee_id < e2.employee_id;

CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(255) NOT NULL,
    sale_amount DECIMAL(10, 2),
    sale_date DATE
);

-- Inserting values into the sales table
INSERT INTO sales (employee_name, sale_amount, sale_date) VALUES 
('hemanth', 1000.00, '2023-01-01'),
('arreyan', 1500.00, '2023-01-02'),
('surya', 800.00, '2023-01-03'),
('hemanth', 1200.00, '2023-01-04'),
('arreyan', 700.00, '2023-01-05'),
('surya', 1600.00, '2023-01-06'),
('hemanth', 2000.00, '2023-01-07'),
('arreyan', 1800.00, '2023-01-08'),
('surya', 1400.00, '2023-01-09');



# ADVANCED FUNCTIONS

# RANK
-- Assigns a rank to each row within the result set.
-- Rows with the same value receive the same rank.
-- Leaves gaps in the ranking for ties.
SELECT 
    employee_name, 
    sale_amount, 
    RANK() OVER (ORDER BY sale_amount DESC) sales_rank
FROM sales;

# DENSE RANK
-- Similar to RANK(), but does not leave gaps in the ranking for ties.

SELECT 
    employee_name, 
    sale_amount, 
    DENSE_RANK() OVER (ORDER BY sale_amount DESC) AS sales_rank
FROM sales;


# ROW_NUMBER
-- assigns a unique number to each row, even if there are ties.

SELECT 
    employee_name, 
    sale_amount, 
    ROW_NUMBER() OVER (ORDER BY sale_amount DESC) AS row_numbers
FROM sales;

# CUME_DIST():
-- Calculates the cumulative distribution of a value in the result set.
-- It represents the relative position of a value.

SELECT 
    employee_name, 
    sale_amount, 
    CUME_DIST() OVER (ORDER BY sale_amount DESC) AS cume_dists
FROM sales;

# LAG():
-- Accesses data from a previous row in the same result set.
-- Useful for comparisons and calculations based on previous rows.

SELECT 
    employee_name, 
    sale_amount, 
    LAG(sale_amount, 1) OVER (ORDER BY sale_date) AS previous_sale_amount
FROM sales;

# LEAD()
-- Accesses data from a subsequent row in the same result set.
-- Useful for comparisons and calculations based on future rows.

SELECT 
    employee_name, 
    sale_amount, 
    LEAD(sale_amount, 1) OVER (ORDER BY sale_date) AS next_sale_amount
FROM sales;
