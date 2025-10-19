# 📘 Python List Comprehensions

## 🔹 What is a List Comprehension?

* A **list comprehension** is a concise way to create lists in Python.
* It combines **loops** and **conditions** into a single line.
* Syntax:

```python
[expression for item in iterable if condition]
```

---

## 🔹 Basic Example

```python
numbers = [1, 2, 3, 4, 5]
squares = [n ** 2 for n in numbers]

print(squares)  
# Output: [1, 4, 9, 16, 25]
```

👉 This replaces:

```python
squares = []
for n in numbers:
    squares.append(n ** 2)
```

---

## 🔹 With a Condition

```python
numbers = [1, 2, 3, 4, 5, 6]
evens = [n for n in numbers if n % 2 == 0]

print(evens)  
# Output: [2, 4, 6]
```

---

## 🔹 With an Else Clause

```python
nums = [1, 2, 3, 4, 5]
labels = ["even" if n % 2 == 0 else "odd" for n in nums]

print(labels)  
# Output: ['odd', 'even', 'odd', 'even', 'odd']
```

---

## 🔹 Nested Loops in List Comprehensions

You can use multiple loops inside a list comprehension.

```python
pairs = [(x, y) for x in [1, 2, 3] for y in [10, 20]]
print(pairs)
# Output: [(1, 10), (1, 20), (2, 10), (2, 20), (3, 10), (3, 20)]
```

---

## 🔹 Flattening a 2D List

```python
matrix = [[1, 2], [3, 4], [5, 6]]
flat = [num for row in matrix for num in row]

print(flat)  
# Output: [1, 2, 3, 4, 5, 6]
```

---

## 🔹 Using Functions in List Comprehensions

```python
def square(x):
    return x * x

numbers = [1, 2, 3, 4, 5]
result = [square(n) for n in numbers]

print(result)  
# Output: [1, 4, 9, 16, 25]
```

---

## 🔹 Dictionary & Set Comprehensions (Bonus)

Similar syntax works for other collections:

```python
# Set comprehension
unique_squares = {n ** 2 for n in [1, 2, 2, 3]}
print(unique_squares)  # {1, 4, 9}

# Dictionary comprehension
squares_dict = {n: n ** 2 for n in range(5)}
print(squares_dict)  # {0: 0, 1: 1, 2: 4, 3: 9, 4: 16}
```

---

# 📝 Exercises: List Comprehensions

1. Create a list of squares for numbers from `1 to 10`.
2. Create a list of even numbers from `0 to 20`.
3. Given a list `["apple", "banana", "cherry"]`, create a new list containing only the first letters.
4. Flatten the list `[[1, 2], [3, 4], [5, 6]]` into `[1, 2, 3, 4, 5, 6]`.
5. Use a list comprehension with an `if/else` to label numbers `1–5` as `"even"` or `"odd"`.
6. Generate a list of all `(x, y)` coordinate pairs where `x` is in `[1, 2, 3]` and `y` is in `[4, 5]`.

---
