# functions

# def greet(name):
#     print("Hello,", name)
#
# greet('Anusha')

# def add(a, b):
#     return a + b
#
# result = add(7,8)
# print(result)

# def greet(name='friend'):
#      print("Hello,", name)
#
# greet()
# greet('Mazen')

# def get_stats(x,y):
#     return x+y,x*y
#
# mySum, myProduct = get_stats(5,5)
# print(mySum, myProduct)

# def intro(name, age=22, city='anywhere'):
#     print(f'My name is {name}, I am {age} years old, from {city}')
#
# intro('Jeremy', 25, 'Montreal')
# intro("Anna")

# def power(base, exp=2):
#     return base ** exp
#
# print(power(3))
# print(power(3,3))

# def add_item(item, container=[]):
#     container.append(item)
#     return container
#
# print(add_item('apple'))
# print(add_item('banana'))

# def add_item(item, container=None):
#     if container is None:
#         container=[]
#     container.append(item)
#     return container
#
# myList = add_item('orange')
# print(add_item('apple'))
# print(add_item('banana'))
# print(add_item('grapes', myList))

# def add_numbers(*args):
#     return sum(args)
#
# print(add_numbers(1,2,3,4,5,6,7))
# print(add_numbers(1,2))

# def print_info(**kwargs):
#     for key, value in kwargs.items():
#         print(f'{key} : {value}')
#
# print_info(name='Inah', age=24, country='Canada')

# def show_details(*args, **kwargs):
#     print('Positional args:', args)
#     print('Key Word Args:', kwargs)
#
# show_details(1,2,5,7,name='Josh', country='US')


# def exam(a, b, *args, c=10, **kwargs):
#     print(a, b)
#     print('args:', args)
#     print('c:', c)
#     print('kwargs:', kwargs)
#
# exam('a', 'b', 1,2,3, d=40, c=100, e=12)
# exam('a', 'b', d=40, c=100, e=12)

# nums = [1,2,3,4,5]
# iterator = iter(nums)
#
# print(next(iterator))
# print(next(iterator))
# print(next(iterator))
# print(next(iterator))
# print(next(iterator))

# built-in function for iterables
# len(), min(), max(), sum(), sorted(), zip()

# nums = [1,2,3,4,5]
# letters = ['a', 'b','c','d']
# mylist = ['apple', 'banana', 'orange']
#
# for n,l,m in zip(nums, letters, mylist):
#     print(n,l,m)

# nums = [1,2,3]
# letters = ['a', 'b','c']
# mylist = ['apple', 'banana', 'orange']
#
# zipped = list(zip(nums, letters, mylist))
# print(zipped)
#
# un_nums, un_letters, un_mylist = zip(*zipped)
# print(un_nums)
# print(un_letters)
# print(un_mylist)

# command = "stop"
#
# match command:
#     case "start":
#         print("Starting...")
#     case "stop":
#         print("Stopping...")
#     case _:
#         print("Unknown command")

# status = 302
#
# match status:
#     case 200 | 201:
#         print("Success")
#     case 400 | 404:
#         print("Client error")
#     case 500:
#         print("Server error")
#     case _:
#         print("Unknown status")

# point = (0, 4)
#
# match point:
#     case (0, 0):
#         print("Origin")
#     case (x, 0):
#         print(f"On X-axis at {x}")
#     case (0, y):
#         print(f"On Y-axis at {y}")
#     case (x, y):
#         print(f"Point at ({x}, {y})")

# data = ("Alice", 25)
#
# match data:
#     case (name, age):
#         print(f"Name: {name}, Age: {age}")
#     case _:
#         print("No match")

# num = 10
#
# match num:
#     case x if x > 0:
#         print("Positive")
#     case x if x < 0:
#         print("Negative")
#     case 0:
#         print("Zero")


import math
# # from math import pi, sqrt
# # from math import # not recommended
#
# print(math.sqrt(9))
# print(math.pi)

# print(dir(math))   # Access functions in a module

# import practice_myModules as x
#
# print(x.my_add(2,2))

# x.hello()

# import requests
#
# response = requests.get("https://google.com")
# print(response.status_code)

# def my_func():
#     x = 10
#     print(x)
#
# my_func()

# def outer():
#     x = 'outer var'
#     def inner():
#         print(x)
#     inner()
#
# outer()

# x = 50  # Global variable
#
# def print_x():
#     print(x)
#
# print_x()  # 50

# count = 0
# def increment():
#     global count
#     count += 1
#
# increment()
# increment()
# print(count)

# def outer():
#     x = 5
#     def inner():
#         nonlocal x
#         x += 1
#         print("Inner:", x)
#     inner()
#     print("outer:", x)
# outer()

# x = "global"
#
# def outer():
#     x = "outer"
#     def inner():
#         x = "inner"
#         print(x)
#     inner()
#     print(x)
#
# outer()
# print(x)

# myString = 'This is a test.'
#
# newString = myString[::-1]
#
# print(newString)

# text = "Python"
# reversed_text = "".join(reversed(text))
# print(reversed_text)

# Calculate the cost of widgets
# def calcCost(myCans):
#     total = 0.0
#     total = (myCans // 3) + (myCans % 3 * .65)
#     print(f'Your cost for {myCans} widgets is ${total:.2f}.')
#
# for i in range(1,13):
#     calcCost(i)

# Calculate factors of a number

# def getFactors(num):
#     factors = []
#     for i in range(1, num + 1):
#         if num % i == 0:
#             factors.append(i)
#     return factors
#
# print(getFactors(50))

# calcDigits
def digitSum(num):
    total = 0
    while num > 0:
        digit = num % 10
        total += digit
        num = num // 10
    return total

print(digitSum(223))
