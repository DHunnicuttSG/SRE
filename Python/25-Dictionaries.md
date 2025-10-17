# 📘 Python Dictionaries (Deep Dive)

## 🔹 What is a Dictionary?

* A **dictionary** in Python is a **collection of key–value pairs**.
* Keys must be **unique** and **immutable** (like strings, numbers, or tuples).
* Values can be **anything** (lists, other dictionaries, etc.).

✅ Think of a dictionary like a real-world dictionary:

* You look up a **word** (the key),
* and you get its **definition** (the value).

---

## 🔹 Creating Dictionaries

```python
# Empty dictionary
empty_dict = {}

# Dictionary with values
student = {
    "name": "Alice",
    "age": 21,
    "major": "Computer Science"
}

print(student)  
# {'name': 'Alice', 'age': 21, 'major': 'Computer Science'}
```

---

## 🔹 Accessing Dictionary Values

```python
print(student["name"])   # Alice
print(student["age"])    # 21

# Using get() (prevents errors if key doesn’t exist)
print(student.get("major"))       # Computer Science
print(student.get("gpa", "N/A"))  # N/A (default value)
```

---

## 🔹 Adding and Updating Items

```python
student["gpa"] = 3.8         # add new key-value
student["age"] = 22          # update existing key
print(student)
# {'name': 'Alice', 'age': 22, 'major': 'Computer Science', 'gpa': 3.8}
```

---

## 🔹 Removing Items

```python
del student["major"]          # delete by key
print(student)

gpa = student.pop("gpa")      # remove and return value
print(gpa)                    # 3.8
print(student)

student.clear()               # remove all items
print(student)                # {}
```

---

## 🔹 Looping Through a Dictionary

```python
person = {"name": "Bob", "age": 30, "city": "New York"}

# Loop through keys
for key in person:
    print(key)

# Loop through values
for value in person.values():
    print(value)

# Loop through key-value pairs
for key, value in person.items():
    print(key, ":", value)
```

---

## 🔹 Checking for Keys

```python
print("name" in person)   # True
print("gpa" in person)    # False
```

---

## 🔹 Nested Dictionaries

Dictionaries can hold other dictionaries!

```python
students = {
    "s1": {"name": "Alice", "age": 21},
    "s2": {"name": "Bob", "age": 22},
}

print(students["s1"]["name"])  # Alice
```

---

## 🔹 Dictionary Methods

```python
car = {"brand": "Toyota", "year": 2020}

print(car.keys())     # dict_keys(['brand', 'year'])
print(car.values())   # dict_values(['Toyota', 2020])
print(car.items())    # dict_items([('brand', 'Toyota'), ('year', 2020)])

car.update({"color": "blue"})  
print(car)  # {'brand': 'Toyota', 'year': 2020, 'color': 'blue'}
```

---

## 🔹 Dictionary Comprehension

Just like list comprehensions, you can build dictionaries quickly.

```python
# Squares of numbers
squares = {x: x**2 for x in range(1, 6)}
print(squares)  
# {1: 1, 2: 4, 3: 9, 4: 16, 5: 25}

# Flip keys and values
original = {"a": 1, "b": 2, "c": 3}
flipped = {v: k for k, v in original.items()}
print(flipped)  
# {1: 'a', 2: 'b', 3: 'c'}
```

---

# 📝 Exercises: Dictionaries

1. Create a dictionary called `book` with keys: `"title"`, `"author"`, and `"year"`.

   * Print the title.
   * Update the year.

2. Create a dictionary `grades` with student names as keys and scores as values.

   * Add a new student.
   * Remove one student.
   * Loop through and print each student’s grade.

3. Use a dictionary comprehension to build a dictionary of numbers `1–10` with their cubes as values.

4. Create a **nested dictionary** of 2 employees with `"name"`, `"position"`, and `"salary"`.

   * Print one employee’s salary.
   * Update another employee’s position.

---
