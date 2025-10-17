# 📘 Python List Comprehensions

## 🔹 What is a List Comprehension?

* A **list comprehension** is a concise way to create lists.
* It replaces the need for writing a `for` loop just to build a list.

**Syntax:**

```python
[expression for item in iterable if condition]
```

* `expression` → what you want to put in the list
* `item` → variable that takes each value from `iterable`
* `condition` (optional) → filter items

---

## 🔹 Basic Examples

### From a for loop → to a comprehension

```python
# Regular loop
numbers = []
for i in range(5):
    numbers.append(i)
print(numbers)  # [0, 1, 2, 3, 4]

# List comprehension
numbers = [i for i in range(5)]
print(numbers)  # [0, 1, 2, 3, 4]
```

---

### With a Condition

```python
# Even numbers from 0 to 10
evens = [i for i in range(11) if i % 2 == 0]
print(evens)  # [0, 2, 4, 6, 8, 10]
```

---

### With an Expression

```python
# Squares of numbers
squares = [i**2 for i in range(1, 6)]
print(squares)  # [1, 4, 9, 16, 25]
```

---

### Nested Comprehensions

```python
# Flatten a 2D list
matrix = [[1, 2], [3, 4], [5, 6]]
flattened = [num for row in matrix for num in row]
print(flattened)  # [1, 2, 3, 4, 5, 6]
```

---

### With String Operations

```python
words = ["hello", "world", "python"]
capitalized = [w.upper() for w in words]
print(capitalized)  # ['HELLO', 'WORLD', 'PYTHON']
```

---

### With Functions

```python
def square(n):
    return n * n

nums = [1, 2, 3, 4, 5]
squared = [square(x) for x in nums]
print(squared)  # [1, 4, 9, 16, 25]
```

---

## 🔹 Exercises: List Comprehensions

1. Create a list of all numbers from `1–20`.
2. Create a list of all odd numbers from `1–20`.
3. Generate a list of the cubes of numbers from `1–10`.
4. Given the list `names = ["Alice", "Bob", "Charlie"]`, make a new list with all names in lowercase.
5. Use a nested comprehension to build a list of pairs `(x, y)` where `x` is `1–3` and `y` is `1–2`.
6. Flatten this list of lists using a comprehension: `[[1, 2], [3, 4], [5, 6]]`.

---
