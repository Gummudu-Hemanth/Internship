# Exmaple 1

class Animal:
    def __init__(self, name):
        self.name = name

    def speak(self):
        print("The animal speaks")

class Dog(Animal):
    def __init__(self, name, breed):
        super().__init__(name)
        self.breed = breed

    def bark(self):
        print("The dog barks")

my_dog = Dog("Buddy", "Labrador")
my_dog.speak()  # Output: The animal speaks
my_dog.bark()   # Output: The dog barks

# Exmaple 2

class Vehicle:
    def __init__(self, make, model):
        self.make = make
        self.model = model

    def start(self):
        print("Starting the vehicle")

class Car(Vehicle):
    def __init__(self, make, model, year):
        super().__init__(make, model)
        self.year = year

    def drive(self):
        print("Driving the car")

my_car = Car("Toyota", "Camry", 2022)
my_car.start()   # Output: Starting the vehicle
my_car.drive()   # Output: Driving the car