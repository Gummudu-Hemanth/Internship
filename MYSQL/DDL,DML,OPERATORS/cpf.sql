USE cpf;

-- Let us first Create table insert values into it and then we can deep  into the concepts of 
-- Stored Procedure
-- Function
-- Cursors

-- Creating Table 
CREATE TABLE unique_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_type VARCHAR(100) NOT NULL,
    book_name VARCHAR(100) NOT NULL,
    rarity_level VARCHAR(50),
    acquisition_date DATE,
    estimated_value DECIMAL(10, 2)
);

-- Inserting values into the table
INSERT INTO unique_data (book_type, book_name, rarity_level, acquisition_date, estimated_value)
VALUES
('Comic Book', 'Action Comics #1', 'Legendary', '1938-06-01', 3200000.00),
('Stamp', 'Penny Black', 'Rare', '1840-05-01', 500000.00),
('Coin', '1794 Flowing Hair Dollar', 'Legendary', '1794-10-15', 10000000.00),
('Trading Card', 'Mickey Mantle Rookie Card', 'Epic', '1952-09-01', 5000000.00),
('Painting', 'Mona Lisa', 'Priceless', '1503-10-01', 850000000.00);

------------------------------------------------------------------------------------------------------------------------------------------
# What is Stored Procedure?
-- A stored procedure is a set of SQL statements that can be stored in the database and reused. 
-- It allows you to encapsulate complex SQL logic in a reusable and maintainable way.

-- Features:
-- Encapsulation of Logic: Group multiple SQL statements into a single unit.
-- Reusability: Can be called multiple times within the database.
-- Security: Access can be controlled to prevent unauthorized use.
-- Performance: Precompiled and optimized by the database server.

-- Syntax
CREATE PROCEDURE procedure_name (parameters)
BEGIN
    -- SQL statements
END;

-- EXAMPLE 1:
-- Is to get collectibles by Value Range.

-- Creating Procedure

DELIMITER //
CREATE PROCEDURE GetCollectiblesByValueRange (IN min_Value DECIMAL(10, 2), IN max_Value DECIMAL(10, 2))
BEGIN
    SELECT * FROM unique_data
    WHERE estimated_value BETWEEN min_Value AND max_Value;
END //
DELIMITER ;

-- Calling the procedure
CALL GetCollectiblesByValueRange(500000.00, 10000000.00);

-- EXAMPLE 2
-- Is to count collectibles by rarity

-- Creating Procedure
DELIMITER //
CREATE PROCEDURE CountCollectiblesByRarity (IN rarityLevel VARCHAR(50), OUT collectibleCount INT)
BEGIN
    SELECT COUNT(*) INTO collectibleCount
    FROM unique_data
    WHERE rarity_level = rarityLevel;
END //
DELIMITER ;

-- calling the procedure
SET @count = 0;
CALL CountCollectiblesByRarity('Legendary', @count);
SELECT @count;

-- Example 3: Update Collectible Rarity
-- Scenario: We want to create a stored procedure that updates the rarity level of a collectible based on its ID.

-- Creating Procedure
DELIMITER //

CREATE PROCEDURE UpdateCollectibleRarity (IN collectibleID INT, IN newRarityLevel VARCHAR(50))
BEGIN
    UPDATE unique_data
    SET rarity_level = newRarityLevel
    WHERE id = collectibleID;
END //

DELIMITER ;

-- calling the procedure

CALL UpdateCollectibleRarity(3, 'Mythic');

-- This will update the rarity level of the collectible with ID 3 to 'Mythic'.

-------------------------------------------------------------------------------------------------------------------------------------------

# What is Functions?
-- A function is similar to a stored procedure but is designed to return a single value. 
-- Functions are used to encapsulate logic that can be used in SQL statements like SELECT, INSERT, UPDATE, etc.

-- Features:
-- Return Value: Always returns a single value.
-- Usage in Queries: Can be used directly in SQL queries.
-- Parameter Types: Supports input parameters.

-- Syntax
CREATE FUNCTION function_name (parameters) RETURNS return_datatype
BEGIN
    -- SQL statements
    RETURN return_value;
END;


# EXAMPLE 1
-- IS to calculate the collectble age.

-- Creating a function
DELIMITER //
CREATE FUNCTION CalculateCollectibleAge (collectibleID INT) RETURNS INT
BEGIN
    DECLARE age INT;
    SELECT YEAR(CURDATE()) - YEAR(acquisition_date) INTO age
    FROM unique_data WHERE id = collectibleID;
    RETURN age;
END //
DELIMITER ;

-- Calling a function
SELECT CalculateCollectibleAge(1);


-- EXAMPLE 2
-- Is to get collectible age.

-- Creating a function GetCollectibleName 
CREATE FUNCTION GetCollectibleName (collectibleID INT) RETURNS VARCHAR(100)
DELIMITER //
CREATE FUNCTION GetCollectibleName (collectibleID INT) RETURNS VARCHAR(100)
BEGIN
    DECLARE name VARCHAR(100);
    SELECT collectible_name INTO name
    FROM unique_data WHERE id = collectibleID;
    RETURN name;
END //
DELIMITER ;

-- Callinf the function
SELECT GetCollectibleName(2);

-- Example 3: Calculate Appreciation Rate
-- Scenario: We want to create a function that calculates the annual appreciation rate of a 
-- collectible based on its acquisition date and estimated value.

-- Creating a function

DELIMITER //

CREATE FUNCTION CalculateAppreciationRate (collectibleID INT) RETURNS DECIMAL(5, 2)
BEGIN
    DECLARE appreciation_rate DECIMAL(5, 2);
    DECLARE years_owned INT;
    DECLARE initial_value DECIMAL(10, 2);
    DECLARE current_value DECIMAL(10, 2);
    
    SELECT YEAR(CURDATE()) - YEAR(acquisition_date), estimated_value INTO years_owned, current_value
    FROM unique_data
    WHERE id = collectibleID;

    SET initial_value = current_value / POWER(1.05, years_owned);
    SET appreciation_rate = ((current_value - initial_value) / initial_value) * 100 / years_owned;

    RETURN appreciation_rate;
END //

DELIMITER ;

-- Calling the function
SELECT CalculateAppreciationRate(2);

-- This function calculates and returns the annual appreciation rate of the collectible with ID 2.

-------------------------------------------------------------------------------------------------------------------------------------------

# What do you mean by Cursors in MySql
-- A cursor is a database object used to retrieve, manipulate, and navigate through a result set row by row.
-- It is often used in stored procedures to handle query results in a controlled manner.

-- Features:
-- Row-by-Row Processing: Allows for processing individual rows in a result set.
-- Control Over Data: Provides the ability to fetch, update, and delete rows from a result set.
-- State Management: Cursors can be opened, fetched, and closed.

-- Syntax
DECLARE cursor_name CURSOR FOR select_statement;

OPEN cursor_name;
FETCH cursor_name INTO variables;
CLOSE cursor_name;


# EXAMPLE 1
-- Is to calculate the Total values
DELIMITER //

CREATE PROCEDURE CalculateTotalValue()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE c_value DECIMAL(10, 2);
    DECLARE total_value DECIMAL(10, 2) DEFAULT 0.00;
    DECLARE cur CURSOR FOR SELECT estimated_value FROM unique_data;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO c_value;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SET total_value = total_value + c_value;
    END LOOP;
    CLOSE cur;

    SELECT total_value AS TotalValue;
END //
DELIMITER ;

CALL CalculateTotalValue();

# EXAMPLE 2

-- Using a Cursor to Generate a Report of Collectibles
-- Scenario: We want to create a stored procedure that iterates over each collectible and generates a report showing the 
-- collectible's name and its estimated value in a formatted way.

DELIMITER //

CREATE PROCEDURE GenerateCollectiblesReport()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE c_name VARCHAR(100);
    DECLARE c_value DECIMAL(10, 2);
    DECLARE cur CURSOR FOR SELECT collectible_name, estimated_value FROM unique_data;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO c_name, c_value;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT CONCAT('Collectible: ', c_name, ', Estimated Value: $', FORMAT(c_value, 2)) AS Report;
    END LOOP;
    CLOSE cur;
END //

DELIMITER ;

