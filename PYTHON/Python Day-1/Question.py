# Question 1
'''Create a function Calculate_area(shape, dimensions) that takes the shape (e.g., "rectangle", "circle") and its dimensions as arguments.
The function should calculate the area based on the shape and return the result. Implement logic for handling different shapes (rectangle, circle) 
and their corresponding dimensions (length, width for rectangle; radius for circle).'''

import math

def Calculate_area(shape, dimensions):
    if shape.lower() == "rectangle":
        if len(dimensions) != 2:
            raise ValueError("For a rectangle, provide dimensions as (length, width).")
        length, width = dimensions
        area = length * width
    elif shape.lower() == "circle":
        if len(dimensions) != 1:
            raise ValueError("For a circle, provide dimensions as (radius,).")
        radius = dimensions[0]
        area = math.pi * (radius ** 2)
    else:
        raise ValueError("Unsupported shape. Use 'rectangle' or 'circle'.")
    
    return area

# Example usage:
rectangle_area = Calculate_area("rectangle", (5, 10))
print(f"Rectangle area: {rectangle_area}")

circle_area = Calculate_area("circle", (7,))
print(f"Circle area: {circle_area}")

# Question 2
'''Create a function reverse_words(text) that takes a string as input. The function should reverse the order of words in the 
string while maintaining the order of characters within each word. -Return the modified string.'''
def reverse_words(text):
    words = text.split()
    reversed_words = words[::-1]
    reversed_text = ' '.join(reversed_words)
    return reversed_text

input_text = input("Enter a string: ")
reversed_text = reverse_words(input_text)
print(f"Reversed words text: {reversed_text}")

# Question 3
'''Create a function analyze_list(numbers) that takes a list of numbers as input.
The function should calculate and return the following in a dictionary:
Minimum value in the list
Maximum value in the list
Average value in the list (use sum and division)
Use a dictionary to store and return the calculated statistics'''
def analyze_list(numbers):
    if not numbers:
        return {
            "min": None,
            "max": None,
            "average": None
        }

    min_value = min(numbers)
    max_value = max(numbers)
    average_value = sum(numbers) / len(numbers)

    return {
        "min": min_value,
        "max": max_value,
        "average": average_value
    }

# Example usage:
numbers = input("Enter a list of numbers separated by spaces: ")
numbers_list = list(map(float, numbers.split()))
statistics = analyze_list(numbers_list)
print(statistics)

# Question 4
'''Create a list of product names (strings).
Define a function filter_short_names(names, max_length) that takes the list of names and a maximum length as arguments.
Use filter with a lambda function to return a new list containing only names shorter than the provided max_length.'''
product_names = [
    "Laptop", 
    "Smartphone", 
    "Tablet", 
    "Headphones", 
    "Monitor", 
    "Mouse", 
    "Keyboard", 
    "Smartwatch", 
    "Camera", 
    "Speaker"
]

def filter_short_names(names, max_length):
    return list(filter(lambda name: len(name) < max_length, names))

# Example usage:
max_length = 8
short_names = filter_short_names(product_names, max_length)
print(f"Product names shorter than {max_length} characters: {short_names}")

# Question 5
'''Text Analyzer (Bonus Challenge):
Create a function analyze_text(text) that takes a block of text as input.
The function should:
Count the number of words in the text (split by whitespace).
Count the number of characters (excluding whitespaces).
Find the most frequent word (you can assume case-insensitive matching for simplicity).
Return a dictionary containing these counts and the most frequent word.'''
def analyze_text(text):
    # Count the number of words in the text
    words = text.split()
    num_words = len(words)
    
    # Count the number of characters (excluding whitespaces)
    num_characters = len(text) - text.count(' ')
    
    # Create a dictionary to store the word frequencies
    word_frequencies = {}
    for word in words:
        word = word.lower()  # Convert to lowercase for case-insensitive matching
        word_frequencies[word] = word_frequencies.get(word, 0) + 1
    
    # Find the most frequent word
    most_frequent_word = max(word_frequencies, key=word_frequencies.get)
    
    # Return the results in a dictionary
    analysis_results = {
        "num_words": num_words,
        "num_characters": num_characters,
        "most_frequent_word": most_frequent_word
    }
    return analysis_results

# Example usage:
text = "Hello Everyone , practice these question to make your concepts more clear and make yourself ready for placements."
analysis = analyze_text(text)
print(analysis)
