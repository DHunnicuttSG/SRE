# Python Object-Oriented Programming (OOP)

Object-Oriented Programming (OOP) is a way of structuring code so that data and functionality are bundled into **objects**. An object is an instance of a **class**, which acts like a blueprint.

OOP makes your code more modular, reusable, and easier to maintain.

---

## 1. Classes and Objects

A **class** is like a blueprint for creating objects.
An **object** is an instance of a class.

```python
# Defining a simple class
class Dog:
    def __init__(self, name, age):  # constructor
        self.name = name
        self.age = age

    def bark(self):
        print(f"{self.name} says Woof!")

# Creating objects (instances of Dog)
dog1 = Dog("Buddy", 3)
dog2 = Dog("Bella", 5)

dog1.bark()
dog2.bark()
```

---

## 2. Attributes and Methods

* **Attributes**: Variables that belong to the object.
* **Methods**: Functions defined inside a class that describe behavior.

```python
class Car:
    def __init__(self, brand, year):
        self.brand = brand      # attribute
        self.year = year        # attribute

    def drive(self):            # method
        print(f"{self.brand} is driving!")

my_car = Car("Toyota", 2022)
print(my_car.brand)
my_car.drive()
```

---

## 3. Encapsulation

Encapsulation hides implementation details from the user.
You can use **private attributes** (by convention, prefix with `_` or `__`).

```python
class BankAccount:
    def __init__(self, owner, balance=0):
        self.owner = owner
        self.__balance = balance  # private attribute

    def deposit(self, amount):
        self.__balance += amount

    def get_balance(self):
        return self.__balance

account = BankAccount("Alice", 1000)
account.deposit(500)
print(account.get_balance())  # 1500
```

---

## 4. Inheritance

Inheritance lets a class derive (inherit) properties and methods from another class.

```python
class Animal:
    def __init__(self, name):
        self.name = name

    def speak(self):
        print("This animal makes a sound.")

class Dog(Animal):  # Dog inherits from Animal
    def speak(self):
        print(f"{self.name} says Woof!")

dog = Dog("Rex")
dog.speak()
```

---

## 5. Polymorphism

Polymorphism allows different classes to define methods with the same name but different behaviors.

```python
class Cat(Animal):
    def speak(self):
        print(f"{self.name} says Meow!")

animals = [Dog("Rex"), Cat("Whiskers")]

for a in animals:
    a.speak()
```

---

## 6. Class Methods and Static Methods

* **Class methods** work with the class itself.
* **Static methods** don’t depend on the class or instance.

```python
class MathHelper:
    @staticmethod
    def add(x, y):
        return x + y

    @classmethod
    def info(cls):
        return f"This is the {cls.__name__} class."

print(MathHelper.add(5, 7))
print(MathHelper.info())
```

---

## Exercises

1. Create a `Person` class with attributes `name` and `age`, and a method `introduce()` that prints a greeting.
2. Create a `Rectangle` class with attributes `width` and `height`. Add a method `area()` that returns the area.
3. Create a `Student` class that inherits from `Person`. Add a `grade` attribute and override `introduce()` to also include the grade.
4. Build a `Library` class that keeps a list of books. Add methods to `add_book(title)` and `list_books()`.
5. Create a `Calculator` class with:

   * a static method for multiplication,
   * a class method to print info about the class.

---
