-------------------------------------------------------------------------------------------------------------------------------------------
-- Data Definition Language (DDL)
-- DDL commands are used to define and manage database objects such as tables, indexes, and views. They deal with the schema and 
-- structure of the database.
-- DDL COMMANDS :->
-- CREATE: This command creates a new table, database, index, or view.
-- ALTER: This command modifies an existing database object, such as a table.
-- DROP: This command deletes a database object.
-- TRUNCATE: This command removes all records from a table, but the table structure remains.


CREATE DATABASE library;
use library;

# CREATE COMMAND
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    Published_Year INT,
    Genre VARCHAR(100)
);

# ALTER COMMAND
ALTER TABLE Books ADD Rating float;  -- adds another record to the table Books.

# DROP TABLE
DROP TABLE Books; -- It drops the table Books

# TRUNCATE TABLE
TRUNCATE TABLE Books; -- It drops all the records from Books table but does not delete the structure of the table.

------------------------------------------------------------------------------------------------------------------------------------------

-- Data Manipulation Language (DML)
-- DML commands are used for managing data within schema objects. They are used for inserting, updating, deleting, and selecting 
-- data in the database.

-- INSERT: This command inserts new records into a table.
-- UPDATE: This command updates existing records in a table.
-- DELETE: This command deletes existing records from a table.
-- SELECT: This command retrieves data from one or more tables.

# We are going to use same database and the tables that we have used for DDL commands.

# INSERT COMMAND
INSERT INTO Books (Title, Author, PublishedYear, Genre, Rating)
VALUES 
('The Catcher in the Rye', 'J.D. Salinger', 1951, 'Fiction',4.2),
('To Kill a Mockingbird', 'Harper Lee', 1960, 'Fiction', 3.6),
('Power Of Your Subconcious Mind' ,'Joseph Murphy' , 2012 , 'Self Development' , 4.9);

# SELECT COMMAND
SELECT * FROM Books; -- It retrives all the record from table Books.

# UPDATE COMMAND
UPDATE Books
SET Genre = 'Classic Fiction'
WHERE Title = 'To Kill a Mockingbird'; -- updating the genre of 'To Kill a Mockingbird' from 'Fiction' -> 'Classic Fiction'.

# DELETE COMMAND
DELETE FROM Books
WHERE Title = 'The Catcher in the Rye'; --  deleting the record 'The Catcher in the Rye'.

