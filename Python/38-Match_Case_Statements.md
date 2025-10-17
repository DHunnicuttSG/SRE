# 📘 Python `match` / `case` Statements

## 🔹 What is `match` / `case`?

* Introduced in **Python 3.10**.
* Similar to `switch` statements in other languages, but **much more powerful**.
* Used for **pattern matching**: checking a value against multiple patterns.

---

## 🔹 Basic Syntax

```python
match variable:
    case pattern1:
        # action
    case pattern2:
        # action
    case _:
        # default action
```

* `_` is a **wildcard** (matches anything, like “default”).

---

## 🔹 Basic Example

```python
command = "start"

match command:
    case "start":
        print("Starting...")
    case "stop":
        print("Stopping...")
    case _:
        print("Unknown command")
```

✅ Output:

```
Starting...
```

---

## 🔹 Matching Multiple Values

```python
status = 404

match status:
    case 200 | 201:
        print("Success")
    case 400 | 404:
        print("Client error")
    case 500:
        print("Server error")
    case _:
        print("Unknown status")
```

✅ Output:

```
Client error
```

---

## 🔹 Using Variables in `case`

You can **capture values** from patterns:

```python
point = (3, 4)

match point:
    case (0, 0):
        print("Origin")
    case (x, 0):
        print(f"On X-axis at {x}")
    case (0, y):
        print(f"On Y-axis at {y}")
    case (x, y):
        print(f"Point at ({x}, {y})")
```

✅ Output:

```
Point at (3, 4)
```

---

## 🔹 Matching Data Structures

You can match lists, tuples, and dictionaries by structure.

```python
data = ["Alice", 25]

match data:
    case [name, age]:
        print(f"Name: {name}, Age: {age}")
    case _:
        print("No match")
```

✅ Output:

```
Name: Alice, Age: 25
```

---

## 🔹 Using Guards (`if` Conditions)

Add extra conditions with `if` (called a **guard**).

```python
num = 10

match num:
    case x if x > 0:
        print("Positive")
    case x if x < 0:
        print("Negative")
    case 0:
        print("Zero")
```

✅ Output:

```
Positive
```

---

## 🔹 Matching Classes (Advanced)

`match` can destructure class instances (if they use `__match_args__`).

```python
class Point:
    __match_args__ = ("x", "y")

    def __init__(self, x, y):
        self.x = x
        self.y = y

p = Point(1, 0)

match p:
    case Point(0, 0):
        print("Origin")
    case Point(x, 0):
        print(f"X-axis at {x}")
    case Point(0, y):
        print(f"Y-axis at {y}")
    case Point(x, y):
        print(f"Point at ({x}, {y})")
```

✅ Output:

```
X-axis at 1
```

---

## 🔹 Why Use `match` / `case`?

✔ Cleaner than long `if/elif/else` chains
✔ More powerful than `switch` (supports patterns, destructuring, guards)
✔ Great for **parsing structured data**

---

# 📝 Exercises: `match` / `case`

1. Write a `match` statement that prints:

   * `"Hello"` if the variable is `"hi"`
   * `"Goodbye"` if it is `"bye"`
   * `"Unknown"` otherwise.

2. Use `match` to check an integer grade:

   * `90–100 → "A"`
   * `80–89 → "B"`
   * `70–79 → "C"`
   * Below `70 → "Fail"`

3. Given a tuple `(x, y)`, use `match` to print whether the point is:

   * Origin `(0, 0)`
   * On X-axis
   * On Y-axis
   * General point `(x, y)`

4. Use `match` with a list of length 2:

   * If it’s `[name, age]`, print `"Name: <name>, Age: <age>"`.
   * Otherwise, print `"Invalid data"`.

5. Create a `match` that checks a dictionary with keys `"type"` and `"value"`.

   * If `"type" == "circle"`, print the radius (`value`).
   * If `"type" == "square"`, print the side length (`value`).
   * Otherwise, print `"Unknown shape"`.

---
