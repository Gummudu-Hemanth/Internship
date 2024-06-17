# Exmaple 1
# Exception Handling
try:
    num1 = int(input("Enter a number: "))
    num2 = int(input("Enter another number: "))
    result = num1 / num2
    print(f"The result is: {result}")
except ValueError:
    print("Invalid input. Please enter a number.")
except ZeroDivisionError:
    print("Cannot divide by zero.")
except Exception as e:
    print(f"An error occurred: {e}")
    
'TYPES OF EXCEPTION HANDLING'

# 1.ValueError: Raised when a function receives an argument of the correct type but an inappropriate value.
try:
    age = int("hello")  # Trying to convert a non-numeric string to an integer
except ValueError:
    print("Invalid input. Please enter a number.")
    
# 2 TypeError: Raised when an operation or function is applied to an object of an inappropriate type.
try:
    result = "hello" + 42  # Trying to concatenate a string and an integer
except TypeError:
    print("Cannot concatenate string and integer.")
    
# 3 ZeroDivisionError: Raised when attempting to divide a number by zero.
try:
    result = 10 / 0  # Division by zero
except ZeroDivisionError:
    print("Cannot divide by zero.")
    
# 4 IndexError: Raised when attempting to access an index that is out of range for a sequence (e.g., list, string, tuple).
my_list = [1, 2, 3]
try:
    print(my_list[3])  # Trying to access an index out of range
except IndexError:
    print("Index out of range.")
    
# 5 KeyError: Raised when attempting to access a non-existent key in a dictionary.
my_dict = {"name": "Alice", "age": 25}
try:
    print(my_dict["city"])  # Trying to access a non-existent key
except KeyError:
    print("Key not found in the dictionary.")
    
# 6 FileNotFoundError: Raised when attempting to open a file that does not exist.
try:
    file = open("non_existent.txt", "r")  # Trying to open a non-existent file
except FileNotFoundError:
    print("File not found.")
    
# 7 ImportError: Raised when an imported module or package cannot be found or loaded.
try:
    pass
    # import non_existent_module  # Trying to import a non-existent module
except ImportError:
    print("Module not found.")

# 8 Exception: You can catch all exceptions using the base Exception class if you don't want to handle specific exceptions individually.
try:
    result = 10 / 0  # Division by zero
except Exception as e:
    print(f"An error occurred: {e}")
    
# 9 You can also use multiple except blocks to handle different types of exceptions separately, 
# and an optional else block to specify code that should be executed if no exceptions occur.
try:
    num1 = int(input("Enter a number: "))
    num2 = int(input("Enter another number: "))
    result = num1 / num2
except ValueError:
    print("Invalid input. Please enter a number.")
except ZeroDivisionError:
    print("Cannot divide by zero.")
else:
    print(f"The result is: {result}")