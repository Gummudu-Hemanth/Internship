'''Class and Object**
Class: A blueprint for creating objects that defines a set of attributes and methods.
Object:An instance of a class.'''

class Book:
    def __init__(self, title, author, year):
        self.title = title
        self.author = author
        self.year = year

    def description(self):
        return f"'{self.title}' by {self.author}, published in {self.year}"

# Creating an object
book1 = Book("1984", "George Orwell", 1949)
print(book1.description())

#In this example, `Book` is a class with attributes `title`, `author`, and `year`, and a method `description`. 
# `book1` is an object of the `Book` class.

'''Inheritance
Mechanism by which a new class (derived class) inherits attributes and methods from an existing class (base class).'''

class Device:
    def __init__(self, brand):
        self.brand = brand

    def info(self):
        return f"This is a device from {self.brand}"

class Smartphone(Device):
    def __init__(self, brand, model):
        super().__init__(brand)
        self.model = model

    def info(self):
        return f"This is a {self.model} smartphone from {self.brand}"

# Using inheritance
phone = Smartphone("Apple", "iPhone 13")
print(phone.info())

#In this example, `Smartphone` inherits from `Device`, and we extend its functionality with an additional attribute `model` 
# and an overridden method `info`.

'''Encapsulation
Bundling data and methods that operate on the data within one unit, e.g., a class, and restricting access to some of the object's components.'''

class Student:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def get_age(self):
        return self.age

    def set_age(self, age):
        if age > 0:
            self.age = age
        else:
            print("Age must be positive")

# Using encapsulation
student = Student("Alice", 21)
print(student.get_age())
student.set_age(22)
print(student.get_age())

# Here, the `Student` class encapsulates the `age` attribute, restricting direct access and providing methods to interact with it safely.

'''Polymorphism
The ability to use a unified interface to operate on objects of different types.'''

class Guitar:
    def play(self):
        return "Strumming the guitar"

class Drums:
    def play(self):
        return "Beating the drums"

def perform(instrument):
    print(instrument.play())

# Using polymorphism
guitar = Guitar()
drums = Drums()

perform(guitar)
perform(drums)

# In this example, `perform` is a function that works with any object that has a `play` method, demonstrating polymorphism.

'''Abstraction
Hiding the complex implementation details and showing only the necessary features of the object.'''

from abc import ABC, abstractmethod

class Payment(ABC):
    @abstractmethod
    def make_payment(self, amount):
        pass

class CreditCardPayment(Payment):
    def make_payment(self, amount):
        return f"Processing credit card payment of {amount} dollars"

class PayPalPayment(Payment):
    def make_payment(self, amount):
        return f"Processing PayPal payment of {amount} dollars"

# Using abstraction
payment1 = CreditCardPayment()
payment2 = PayPalPayment()

print(payment1.make_payment(100))
print(payment2.make_payment(150))

# Here, the `Payment` class is an abstract base class with an abstract method `make_payment`. `CreditCardPayment` and 
# `PayPalPayment` are concrete classes that implement the abstract method, hiding the specific payment process details.
