use tcl;

/* 
TCL (Transaction Control Language)
TCL is used to manage transactions in a database. Transactions are sequences of one or more SQL operations executed as a single unit of work. TCL commands help ensure data integrity and consistency
TCL commands are used to manage transactions, maintain ACID properties, and control the flow of data modifications.
TCL commands ensure the consistency and durability of data in a database.

WHAT ARE TCL COMMANDS
START TRANSACTION: Begins a new transaction.
COMMIT: Saves all changes made during the current transaction permanently.
ROLLBACK: Undoes all changes made during the current transaction.
SAVEPOINT: Sets a savepoint within the current transaction.
ROLLBACK TO SAVEPOINT: Rolls back to a specific savepoint.
*/


-- Creating the products table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

-- Inserting the data into products table
INSERT INTO products (product_name, price)
 VALUES 
 ('Laptop', 1000.00),
 ('Smartphone', 500.00),
 ('Tablet', 300.00),
 ('Headphones', 390.00),
 ('watch', 90.00);
 
 # START TRANSACTION
--  A transaction begins with the START TRANSACTION statement. 
--  Changes made after this statement can be either committed (saved) or rolled back (undone).

-- command
--  # START THE TRANSACTION
START TRANSACTION;

-- Lets us upadte the price of the laptop
UPDATE products SET price = 900.00 WHERE product_name = 'Laptop';

-- Inserting a new product into the products table
INSERT INTO products (product_name, price) VALUES ('Ipad', 8200.00);

-- Right now the changes are not saved we can choose to commit or rollback the transaction

# COMMIT TRANSACTION
COMMIT;

-- With this command whatever changes we have made till now is saved permanently to the database.

# ROLL BACK THE TRANSACTION
-- lets take anither exampel to anither the rollback command.

-- Starting  a new transaction
START TRANSACTION;

-- Updating the price of the smartphone
UPDATE products SET price = 450.00 WHERE product_name = 'Smartphone';

-- Inserting another new product
INSERT INTO products (product_name, price) VALUES ('Headphones', 150.00);

-- Something went wrong, roll back the transaction
ROLLBACK;

/* 
So in the above example we didnt commit the changes. 
If you think that you have done something wrong then you can use rollback command and all the changes will be undone.alter
*/

# SAVEPOINT
-- A SAVEPOINT allows you to create a point within a transaction to which you can later roll back without affecting the entire transaction.

-- let us understand it will help of an exmaple

-- Starting a new transaction
START TRANSACTION;

-- Inserting a new product
INSERT INTO products (product_name, price) VALUES ('Monitor', 250.00);

-- Create a savepoint
SAVEPOINT sp1;

-- Insert another product
INSERT INTO products (product_name, price) VALUES ('Keyboard', 100.00);

-- Something went wrong, roll back to the savepoint
ROLLBACK TO sp1;

-- Commit the transaction
COMMIT;

-- In above exmaple the insertion of Monitor will be saved but the insertion of Keyboard will be undone when we rollback to the savepoint sp1.

/* TCL commands are crucial for maintaining data integrity and consistency, allowing you to manage and control transactions effectively.

-----------------------------------------------------------------------------------------------------------------------------------------------

/* 
What is Trigger
-- Triggers 

-- Trigger is a statement that a system executes automatically when there is any modification to the database
-- Triggers are used to specify certain integrity constraints and referential constraints that cannot be specified using the constraint mechanism of SQL

*/

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100),
    salary DECIMAL(10, 2)
);
INSERT INTO employees (name, position, salary) VALUES
('Alice Johnson', 'Manager', 75000.00),
('Bob Smith', 'Developer', 60000.00),
('Charlie Brown', 'Analyst', 55000.00);

# AFTER INSERT TRIGGER
-- Activated After Data is Inserted into the Table

-- Create a table for logging inserts
CREATE TABLE insert_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    log_message VARCHAR(255),
    log_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Creating an AFTER INSERT trigger
DELIMITER //

CREATE TRIGGER after_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO insert_logs (employee_id, log_message)
    VALUES (NEW.employee_id, CONCAT('Employee ', NEW.name, ' was added.'));
END; //

DELIMITER ;

-- Here when a new employee is inserted into the employees table, this trigger logs the insertion in the insert_logs table.

/* AFTER DELETE TRIGGER 
Activated After Data is Deleted/Removed from the Table
*/

-- Create a table for logging deletions
CREATE TABLE delete_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    log_message VARCHAR(255),
    log_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create an AFTER DELETE trigger
DELIMITER //

CREATE TRIGGER after_employee_delete
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO delete_logs (employee_id, log_message)
    VALUES (OLD.employee_id, CONCAT('Employee ', OLD.name, ' was deleted.'));
END; //

DELIMITER ;

-- Here when an employee is deleted from the employees table, this trigger logs the deletion in the delete_logs table.

/* 
BEFORE INSERT TRIGGER
Activated Before Data is Inserted into the Table
*/

-- Create a BEFORE INSERT trigger
DELIMITER //

CREATE TRIGGER before_employee_insert
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    -- Ensure the salary is not negative
    IF NEW.salary < 0 THEN
        SET NEW.salary = 0;
    END IF;
END; //

DELIMITER ;

-- Before a new employee is inserted into the employees table, this trigger 
-- ensures that the salary is not negative. If it is, the salary is set to 0.

/* BEFORE UPADTE TRIGGER 
Activated Before Data in the Table is Modified
*/

-- Create a BEFORE UPDATE trigger
DELIMITER //

CREATE TRIGGER before_employee_update
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    -- Ensure the new salary is not negative
    IF NEW.salary < 0 THEN
        SET NEW.salary = 0;
    END IF;
END; //

DELIMITER ;

-- Before an employee’s details are updated, this trigger ensures that the new salary is not negative.

/* BEFORE DELETE TRIGGER
Activated Before Data is Deleted/Removed from the Table */

-- Create a BEFORE DELETE trigger
DELIMITER //

CREATE TRIGGER before_employee_delete
BEFORE DELETE ON employees
FOR EACH ROW
BEGIN
    -- Check if the employee is a manager
    IF OLD.position = 'Manager' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Managers cannot be deleted.';
    END IF;
END; //

DELIMITER ;

-- Before an employee is deleted, this trigger checks if the employee is a manager. If so, it raises an error, preventing the deletion.

-- Each type of trigger can be used to enforce business rules, maintain data integrity, and automate processes within the database. 
-- The examples provided demonstrate how triggers can be employed to handle various scenarios effectively.

-------------------------------------------------------------------------------------------------------------------------------------------

# What is View
/* 
A view in MySQL is a virtual table that does not store data directly but derives its results from one or
 more underlying tables or other views. It is defined by a SELECT query, which acts as its "definition" or "view definition". 
*/

-- Suppose we have a table 'products' with columns 'product_id', 'product_name', 'category', 'price'
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Insert some sample data
INSERT INTO products (product_id, product_name, category, price) VALUES
(1, 'Laptop', 'Electronics', 1200.00),
(2, 'Smartphone', 'Electronics', 800.00),
(3, 'Chair', 'Furniture', 100.00),
(4, 'Desk', 'Furniture', 250.00),
(5, 'Bookshelf', 'Furniture', 150.00);

-- Creating View to show only electronic products.

CREATE VIEW electronics_products AS
SELECT product_id, product_name, price
FROM products
WHERE category = 'Electronics';

-- Selecting all records from the electronics_products view
SELECT * FROM electronics_products;

----------------------------------------------------------------------------------------------------------------------------------------------
