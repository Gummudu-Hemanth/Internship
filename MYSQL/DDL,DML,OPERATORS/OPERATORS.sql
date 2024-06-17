-- Operators in MySQL are essential for performing operations on data, creating conditions in queries, 
-- and manipulating values.

# ARTHMETIC OPERATORS

-- Addition: Adds two numbers.
SELECT 10 + 5 AS Addition;  -- Result: 15
 
-- Subtraction  Subtracts the second number from the first.
SELECT 10 - 5 AS Subtraction;  -- Result: 5

-- Multiplication: Multiplies two numbers.
SELECT 10 * 5 AS Multiplication;  -- Result: 50

-- Division: Divides the first number by the second.
SELECT 10 / 5 AS Division;  -- Result: 2

-- Modulus : Returns the remainder of a division operation.
SELECT 10 % 3 AS Modulus;  -- Result: 1

# COMPARISON OPERATORS

-- Equal to: Checks if two values are equal.
SELECT * FROM Books WHERE Author = 'Harper Lee';

-- Not equal to (`!=`) Checks if two values are not equal.
SELECT * FROM Books WHERE PublishedYear <> 1960;

-- Greater than (`>`): Checks if the first value is greater than the second.
SELECT * FROM Books WHERE PublishedYear > 1950;


-- Less than (`<`): Checks if the first value is less than the second.
SELECT * FROM Books WHERE PublishedYear < 1960;

-- Greater than or equal to (`>=`): Checks if the first value is greater than or equal to the second.
 SELECT * FROM Books WHERE PublishedYear >= 1960;

-- Less than or equal to (`<=`): Checks if the first value is less than or equal to the second
SELECT * FROM Books WHERE PublishedYear <= 1960;

-- BETWEEN: Checks if a value is within a range.
SELECT * FROM Books WHERE PublishedYear BETWEEN 1950 AND 1960;


-- LIKE: Checks if a value matches a specified pattern.
SELECT * FROM Books WHERE Title LIKE '%Mockingbird%';


# LOGICAL OPERATORS

-- AND: Returns true if both conditions are true.
SELECT * FROM Books WHERE PublishedYear > 1950 AND Genre = 'Fiction';

-- OR: Returns true if either condition is true.
SELECT * FROM Books WHERE Author = 'Harper Lee' OR Genre = 'Classic Fiction';

-- NOT: Returns true if the condition is false.
SELECT * FROM Books WHERE NOT (Genre = 'Fiction');

# BITWISE OPERATORS
-- Bitwise AND (`&`): Performs a bitwise AND operation.
SELECT 5 & 3 AS BitwiseAND;  -- Result: 1 (0101 & 0011 = 0001)

-- Bitwise OR (`|`): Performs a bitwise OR operation.
SELECT 5 | 3 AS BitwiseOR;  -- Result: 7 (0101 | 0011 = 0111)

-- Bitwise XOR (`^`): Performs a bitwise XOR operation.
SELECT 5 ^ 3 AS BitwiseXOR;  -- Result: 6 (0101 ^ 0011 = 0110)

-- Bitwise NOT (`~`): Performs a bitwise NOT operation.
SELECT ~5 AS BitwiseNOT;  -- Result: -6 (inverting all bits of 0101 gives 1010 which is -6 in two's complement)

-- Bitwise shift left (`<<`): Shifts bits to the left.
SELECT 5 << 1 AS ShiftLeft;  -- Result: 10 (0101 becomes 1010)


-- Bitwise shift right (`>>`): Shifts bits to the right.
SELECT 5 >> 1 AS ShiftRight;  -- Result: 2 (0101 becomes 0010);

