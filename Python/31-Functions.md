# 📘 Python Functions

## 🔹 What is a Function?

* A **function** is a block of reusable code that performs a specific task.
* Functions help make code **organized**, **modular**, and **easier to maintain**.

---

## 🔹 Defining a Function

Use the **`def`** keyword:

```python
def greet():
    print("Hello, world!")
```

👉 Nothing happens until you **call** the function:

```python
greet()  
# Output: Hello, world!
```

---

## 🔹 Parameters (Inputs to a Function)

```python
def greet(name):
    print("Hello,", name)

greet("Alice")  
# Output: Hello, Alice
```

---

## 🔹 Return Values

```python
def add(a, b):
    return a + b

result = add(3, 5)
print(result)  
# Output: 8
```

⚡ Use `return` to send a value back to the caller.

---

## 🔹 Default Parameters

```python
def greet(name="friend"):
    print("Hello,", name)

greet()          # Hello, friend
greet("Bob")     # Hello, Bob
```

---

## 🔹 Multiple Return Values

Functions can return multiple values using tuples:

```python
def get_stats(x, y):
    return x + y, x * y

sum_val, product = get_stats(3, 4)
print(sum_val, product)  
# Output: 7 12
```

---

## 🔹 Functions and Scope

Variables inside functions are **local** by default:

```python
def my_func():
    x = 10  # local variable
    print(x)

my_func()
# print(x)  # ❌ Error: x not defined outside function
```

---

# 📝 Exercises: Functions

1. Write a function `say_hello()` that prints `"Hello, Python!"`.
2. Write a function `square(n)` that returns the square of a number.
3. Write a function `is_even(n)` that returns `True` if a number is even, else `False`.
4. Write a function `convert_temp(celsius)` that converts Celsius to Fahrenheit.

   * Formula: `F = (C × 9/5) + 32`.
5. Write a function `calculate_area(length, width)` that returns the area of a rectangle.
6. Write a function `min_max(numbers)` that takes a list of numbers and returns both the minimum and maximum values.

---
