# 📘 Python Membership Operators

## 🔹 What are Membership Operators?

Membership operators are used to check whether a value (element, character, or key) exists in a sequence (like a string, list, tuple, set, or dictionary).

Python has **two membership operators**:

1. **`in`** → Returns `True` if the value is present.
2. **`not in`** → Returns `True` if the value is **not** present.

---

## 🔹 Using `in` with Strings

```python
text = "Python is fun"

print("Python" in text)   # True
print("Java" in text)     # False
print("fun" not in text)  # False
```

---

## 🔹 Using `in` with Lists

```python
fruits = ["apple", "banana", "cherry"]

print("banana" in fruits)     # True
print("orange" not in fruits) # True
```

---

## 🔹 Using `in` with Tuples

```python
numbers = (1, 2, 3, 4, 5)

print(3 in numbers)       # True
print(6 not in numbers)   # True
```

---

## 🔹 Using `in` with Sets

```python
colors = {"red", "blue", "green"}

print("red" in colors)       # True
print("yellow" not in colors) # True
```

---

## 🔹 Using `in` with Dictionaries

* Membership checks **keys** by default.
* If you want to check values, use `.values()`.

```python
student = {"name": "Alice", "age": 20, "grade": "A"}

print("name" in student)         # True (key check)
print("Alice" in student.values()) # True (value check)
print("grade" not in student)    # False
```

---

## 🔹 Membership in Loops

```python
items = ["pen", "pencil", "eraser"]

if "pencil" in items:
    print("Found it!")

# Output: Found it!
```

---

# 📝 Exercises: Membership Operators

1. Check if `"dog"` is in the string `"hotdog stand"`.
2. Write a condition to test if `"grape"` is not in the list `["apple", "banana", "cherry"]`.
3. Given the tuple `(10, 20, 30, 40)`, check if `25` is a member.
4. Write a program that checks if `"blue"` exists in the set `{"red", "green", "blue"}`.
5. Given the dictionary:

   ```python
   capitals = {"France": "Paris", "Japan": "Tokyo", "Italy": "Rome"}
   ```

   * Check if `"Japan"` is a key.
   * Check if `"Rome"` is a value.

---
