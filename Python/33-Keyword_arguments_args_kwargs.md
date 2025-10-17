# 📘 Python Keyword Arguments (and `*args`, `**kwargs`)

## 🔹 What are Keyword Arguments?

* A **keyword argument** is when you call a function and specify the parameter name.
* This makes your code **clearer** and lets you change the order of arguments.

```python
def greet(name, age):
    print(f"Hello {name}, you are {age} years old.")

greet(name="Alice", age=25)  
greet(age=25, name="Alice")  # order doesn’t matter
```

✅ Both give:

```
Hello Alice, you are 25 years old.
```

---

## 🔹 Positional vs. Keyword Arguments

* **Positional arguments**: matched by order.
* **Keyword arguments**: matched by name.

👉 Positional arguments must come **before** keyword arguments.

```python
def display_info(name, country):
    print(f"{name} is from {country}.")

display_info("Bob", country="USA")   # ✅ Works
# display_info(name="Bob", "USA")    # ❌ Error
```

---

## 🔹 Default Arguments with Keywords

You can combine keyword arguments with default values:

```python
def introduce(name, age=18, city="Unknown"):
    print(f"My name is {name}, I am {age}, from {city}.")

introduce("Charlie")                     # uses defaults
introduce("Diana", city="London")        # mix positional + keyword
introduce(name="Eve", city="Paris")      # fully keyword
```

---

## 🔹 Variable-Length Arguments (`*args`)

Sometimes you don’t know how many arguments will be passed.
Use `*args` to collect them into a tuple.

```python
def add_numbers(*args):
    return sum(args)

print(add_numbers(2, 4, 6))    # 12
print(add_numbers(1, 2, 3, 4)) # 10
```

👉 `*args` is for **any number of positional arguments**.

---

## 🔹 Arbitrary Keyword Arguments (`**kwargs`)

Use `**kwargs` to accept any number of **keyword arguments**, collected into a dictionary.

```python
def print_info(**kwargs):
    for key, value in kwargs.items():
        print(f"{key}: {value}")

print_info(name="Alice", age=30, country="USA")
```

✅ Output:

```
name: Alice
age: 30
country: USA
```

---

## 🔹 Mixing `*args` and `**kwargs`

You can use both in the same function:

```python
def show_details(*args, **kwargs):
    print("Positional args:", args)
    print("Keyword args:", kwargs)

show_details(1, 2, 3, name="Bob", age=20)
```

✅ Output:

```
Positional args: (1, 2, 3)
Keyword args: {'name': 'Bob', 'age': 20}
```

---

## 🔹 Order of Parameters in Functions

When defining a function, the order must be:

1. Regular positional arguments
2. `*args`
3. Default arguments (with `=`)
4. `**kwargs`

Example:

```python
def example(a, b, *args, c=10, **kwargs):
    print(a, b)
    print("args:", args)
    print("c:", c)
    print("kwargs:", kwargs)

example(1, 2, 3, 4, 5, c=20, x=99, y=100)
```

✅ Output:

```
1 2
args: (3, 4, 5)
c: 20
kwargs: {'x': 99, 'y': 100}
```

---

# 📝 Exercises

1. Write a function `book_info(title, author, year)` and call it using keyword arguments.
2. Write a function `multiply(*args)` that multiplies any number of numbers.
3. Write a function `student_profile(**kwargs)` that prints all keyword arguments given.
4. Write a function `car_description(make, model, **options)` where `make` and `model` are required, but options can include `color`, `year`, etc.
5. Write a function `order_pizza(size="medium", *toppings, **extras)` that prints the size, toppings, and extras (like `"extra_cheese=True"`).

---
