# 📘 Python Iterables

## 🔹 What is an Iterable?

* An **iterable** is any Python object that can return its elements **one at a time**.
* You can loop over an iterable using a `for` loop.
* Common iterables:

  * Strings (`"hello"`)
  * Lists (`[1, 2, 3]`)
  * Tuples (`(1, 2, 3)`)
  * Sets (`{1, 2, 3}`)
  * Dictionaries (`{"a": 1, "b": 2}`)

---

## 🔹 Iterables vs Iterators

* An **iterable** is something you can loop over.
* An **iterator** is an object that produces items one at a time when you call `next()` on it.
* You can create an iterator from an iterable using the `iter()` function.

```python
numbers = [1, 2, 3]
iterator = iter(numbers)

print(next(iterator))  # 1
print(next(iterator))  # 2
print(next(iterator))  # 3
# print(next(iterator))  # ❌ StopIteration
```

---

## 🔹 Using Iterables in Loops

```python
for char in "Python":
    print(char)
```

✅ Output:

```
P
y
t
h
o
n
```

---

## 🔹 Checking if an Object is Iterable

Use `collections.abc.Iterable` to check:

```python
from collections.abc import Iterable

print(isinstance([1, 2, 3], Iterable))  # True
print(isinstance(42, Iterable))         # False
```

---

## 🔹 Built-in Functions that Work on Iterables

* `len()` – number of items
* `min()`, `max()` – smallest/largest
* `sum()` – sum of items
* `sorted()` – returns a sorted list
* `enumerate()` – gives index + value pairs
* `zip()` – pairs items from multiple iterables

```python
numbers = [10, 20, 30]
letters = ["a", "b", "c"]

for n, l in zip(numbers, letters):
    print(n, l)
```

✅ Output:

```
10 a
20 b
30 c
```

---

## 🔹 Iterables in Action: Dictionary Iteration

```python
person = {"name": "Alice", "age": 25, "city": "Paris"}

for key, value in person.items():
    print(key, ":", value)
```

✅ Output:

```
name : Alice
age : 25
city : Paris
```

---

# 📝 Exercises: Iterables

1. Write a loop to print each character in `"Hello, World!"`.
2. Convert the list `[2, 4, 6, 8]` into an iterator using `iter()` and print values with `next()`.
3. Write a loop that prints both the index and value of `[10, 20, 30, 40]` using `enumerate()`.
4. Use `zip()` to combine `["Alice", "Bob", "Charlie"]` with `[85, 90, 78]` and print name + score.
5. Write a loop to print all the keys in a dictionary and then another to print all the values.

---
