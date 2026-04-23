# OOP practice
from xml.sax import make_parser


# class Dog:
#     def __init__(self, name, age):
#         self.name = name
#         self.age = age
#
#     def bark(self):
#         print(f"{self.name} says woof!")
#
#
# dog1 = Dog("Bingo", 3)
# dog2 = Dog("Buddy", 4)
# dog1.bark()
# dog2.bark()

# class Car:
#     def __init__(self, make, model, year):
#         self.make = make
#         self.model = model
#         self.year = year
#
#     def drive(self):
#         print(f"I drive a {self.year}, {self.make} {self.model}.")
#
# myCar = Car("Ford", "Mustang", 2019)
#
# myCar.drive()
# myCar.model = "Edge"
# print(myCar.model)
# myCar.drive()

# class BankAcct:
#     def __init__(self, owner, balance=0):
#         self.owner = owner
#         self.__balance = balance
#
#     def deposit(self, amount):
#         self.__balance += amount
#
#     def get_balance(self):
#         return self.__balance
#
# acct1 = BankAcct("Alice", 1000)
# acct1.deposit(500)
# print(acct1.get_balance())

# class Animal:
#     def __init__(self, name):
#         self.name = name
#
#     def speak(self):
#         print("This animal makes noise.")
#
# class Dog(Animal):
#     def speak(self):
#         print(f"{self.name} says WOOF!")
#
# # dog1 = Dog("Rex")
# # dog1.speak()
#
# class Cat(Animal):
#     def speak(self):
#         print(f"{self.name} says Meow!")
#
# animals = [Dog("Rex"), Cat("Whiskers")]
#
# for a in animals:
#     a.speak()

# class MathHelper:
#     @staticmethod
#     def add(x, y):
#         return x + y
#
#     @classmethod
#     def info(cls):
#         return f"This is the {cls.__name__)} class."
#
# print(MathHelper.add(5,7))
# print(MathHelper.info())

# try:
#     num = int(input("enter a number:"))
#     result = 10/num
#
# except ZeroDivisionError as e:
#     print("Error:", e)
# else:
#     print("Result is: ", result)
# finally:
#     print("App finished.")

def withdraw(balance, amount):
    if amount > balance:
        raise ValueError("Insufficient funds")
    return balance - amount

try:
    withdraw(100, 200)
except ValueError as e:
    print("Error:", e)