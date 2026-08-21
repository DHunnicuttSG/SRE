# print("Hi!");print("My Name is Tracy.");print("I enjoy traveling.")

'''
;alskdj;lksjg;lk
as;ldjkgh;lakfdg
a;sdjkgh;kadljfhg
as;dkgjhladkjgh
'''
from codecs import BOM_BE

x = 'This is a string'
y = 5.6 # float
z = 5 # integer
is_true = True

# __main__  These are dunders    thisIsAVariable  this_is_a_variable

# thisisavalidvariablenamealthoughitisverylong=5
# print(thisisavalidvariablenamealthoughitisverylong)

# var = int(input("enter in a number"))
# sqr = var * var
# print(sqr)

# name = "John"
# myNum = 2.445467
# print(f"My name is {name}.")
# print(f"gas costs ${myNum} a gallon.")
# print("%s says that gas costs $%.2f a gallon." %(name, myNum))
#
# x = 3.14159
# y = 345.456
# print(f"The value of x is {x:>10.2f}.")
# print(f"The value of x is {y:>10.2f}.")

# x = 5
# print(x)
# x += 2
# print(x)
#
# x = None
# print(x)

# age = int(input("Please enter your age"))

# if age > 21:
#     print("Have a drink")
# else:
#     print("Sorry, you are too young.")
#
# if age > 21:
#     print("Have a drink")
# elif age > 30:
#     print("Sorry, This is a college bar.")

# x = bool(x)
# print("Boolean:", x)
#
#
# y = bool(y)
# print("y: ", y)

# {} = set
# [] = list
# () = tuple

# fruits = ["banana", "apple", "cherry", "grapes", "strawberry"]
nums = [1,5,7,9,23,47,231,3, 475,5,100]
# print(fruits)
# print(fruits[0])
# print(fruits[-1])

# fruits.append( "orange")
# fruits.insert(1, "orange")

# fruits.remove("cherry")
#fruits.pop()
# fruits.sort()
# fruits.reverse()
# print(fruits)
#
# # nums.sort()
# # print(nums)
#
# print(len(fruits))

# fruits = ("banana", "apple", "cherry", "grapes", "strawberry", "apple")
# print(type(fruits))
# print(fruits.count("apple"))
# print(fruits[2])

# fruits = {"banana", "apple", "cherry", "grapes", "strawberry", "apple"}
# print(fruits)
#
# fruits.add("Orange")
# fruits.add("orange")
# fruits.remove("Orange")
# fruits.discard("Orange")
# print(fruits)
#
# A = {1, 2, 3}
# B = {4, 2, 6}
# print(A.union(B))
# print(A.intersection(B))
# print(A.difference(B))

'''
create a list with duplicates
Convert to a set
convert back to list print sorted list

list1 = [1,2,4,5,7,9,10]
list2 = [1,4,5,7,10,11,12]

remove duplicates from both lists
'''
# myList = [1,1,1,2,2,3,3,4,4,5]
# mySet = set(myList)
# print(mySet)
# myNewList = list(mySet)
# print(myNewList)

# list1 = [1,2,4,5,7,9,10]
# list2 = [1,4,5,7,10,11,12]
#
# newSet1 = set(list1)
# newSet2 = set(list2)
#
# finalSet1 = newSet1.difference(newSet2)
# print(finalSet1)
# finalSet2 = newSet2.difference(newSet1)
# print(finalSet2)
#
# finalList1 = list(finalSet1)
# finalList2 = list(finalSet2)
# print(finalList1, finalList2)

fruits = ["banana", "apple", "cherry", "grapes", "strawberry", "apple"]
list1 = [1,2,4,5,7,9,10]
list2 = [1,4,5,7,10,11,12]

# for fruit in fruits:
#     print("I like", fruit)

# myString = "I like Python"
#
# for letter in myString:
#     print(letter, end='')  # \n

# for i in range(10,21,5):
#     print(i)

# for i in range(1,4):
#     for j in range(1,4):
#         print(i,j)

# for i in range(1,10):
#     if i == 3:
#         continue
#     if i == 5:
#         continue
#     print(i)


#    *  *
#   **  **
#  ***  ***
# ****  ****

# **** ****
#  *** ***
#   ** **
#    * *

# While loops

# count = 1
# while count < 10:
#     print("count:", count)
#     count += 1

# while True:
#     name = input("Enter your name (type exit to quit): ")
#     if name.lower() == "exit":
#         break
#     print("Hello,", name)

# count = 1
# while count <= 3:
#     print(count)
#     count += 1
# else:
#     print("Loop finished!")

# old style formatting
# name = "Alice"
# age = 25
# height = 5.6
# print("My name is %s, I am %d years old, and my height is %.1f feet." % (name, age, height))
#
# # New style formatting
# print("My name is {}, I am {} years old, and my height is {:.2f} feet.".format(name, age, height))
# # Opinion:  Use the following formatting rather than former
# print(f"My name is {name}, I am {age} years old, and my height is {height:.2f} feet.")
#
# # Text alignment
# text = "Python"
# num = 42
#
# print(f"{text:<10} -> left aligned")   # Left align in 10 spaces
# print(f"{text:>10} -> right aligned")  # Right align in 10 spaces
# print(f"{num:05} -> padded with zeros") # 00042
#
# x = 7
# y = 3
# print(f"{x} + {y} = {x+y}")  # Can include calculations directly

# 2D collections
# matrix = [
#     (1,2,3),
#     ('This','That','The other thing'),
#     (7,8,9)
# ]
#
# matrix.append((7,7,7))
#
# # print(matrix[0])
# # print(matrix[0][2])
#
# for row in matrix:
#     for item in row:
#         print(item, end=' ')
#
# tuple_matrix = (
#     [1,2,3],
#     [4,5,6],
#     [7,8,9]
# )
# for row in tuple_matrix:
#     for item in row:
#         print(item, end=' ')

# set1 = frozenset({1,2,3})
# set2 = frozenset({4,5,6})
#
# set_matrix = {set1, set2}
#
# for row in set_matrix:
#     for item in row:
#         print(item, end=' ')

# List Comprehensions
# [expression for item in iterable if condition]

# numbers = [i for i in range(10)]
# print(numbers)

# fizzBuzz = [i for i in range(101) if i % 3 != 0 and i % 5 != 0]
# print(fizzBuzz)

# squares = [item**2 for item in range(1,11)]
# print(squares)
#
# words = ["hello", "world", "of", "python"]
# caps = [word.upper() for word in words]
# print(caps)

# def square(n):
#     return n * n
#
# myNums = [1,2,3,4,5,6,7,8,9]
# squared = [square(x) for x in myNums]
# print(squared)

empty_dict = {
    'name':'Kaseem',
    'age':22,
    'major':'computer science'
}

empty_dict['grad_year'] = 2025
empty_dict['name'] = 'Kaseem'

# del empty_dict['grad_year']
# empty_dict.pop('age')

# print(empty_dict.get("name"))

for key in empty_dict:
    print(key)

for value in empty_dict.values():
    print(value)

for key, value in empty_dict.items():
    print(key, ':', value)

# print(empty_dict.keys())
# print(empty_dict.values())

# empty_dict.clear()
# print(empty_dict)