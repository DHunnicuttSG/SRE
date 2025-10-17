# 📘 Python Modules

## 🔹 What is a Module?

* A **module** is a file that contains Python code (functions, variables, classes).
* It helps you **organize code** into smaller, reusable pieces.
* Python has:

  * **Built-in modules** (already included, e.g., `math`, `random`, `os`).
  * **User-defined modules** (your own `.py` files).
  * **Third-party modules** (installed using `pip`, e.g., `requests`, `numpy`).

---

## 🔹 Importing Modules

```python
import math

print(math.sqrt(16))   # 4.0
print(math.pi)         # 3.141592653589793
```

---

## 🔹 Import with an Alias

```python
import math as m

print(m.sqrt(25))  # 5.0
```

---

## 🔹 Import Specific Functions

```python
from math import sqrt, pi

print(sqrt(9))   # 3.0
print(pi)        # 3.141592653589793
```

---

## 🔹 Import Everything (⚠ not recommended)

```python
from math import *

print(sin(pi/2))   # 1.0
```

⚡ This can cause **naming conflicts**. Best practice: **import only what you need**.

---

## 🔹 User-Defined Modules

You can create your own module!

1. Create a file **`mymath.py`**:

```python
def add(a, b):
    return a + b

def subtract(a, b):
    return a - b
```

2. Use it in another file:

```python
import mymath

print(mymath.add(5, 3))       # 8
print(mymath.subtract(10, 4)) # 6
```

---

## 🔹 The `dir()` Function

Lists all functions, classes, and variables in a module:

```python
import math
print(dir(math))
```

---

## 🔹 The `__name__ == "__main__"` Trick

When a module is run directly, its `__name__` is `"__main__"`.
When imported, it’s the module’s name.

```python
# mymodule.py
def hello():
    print("Hello from mymodule!")

if __name__ == "__main__":
    print("Running directly")
else:
    print("Imported as a module")
```

```bash
$ python mymodule.py
Running directly
$ python
>>> import mymodule
Imported as a module
```

---

## 🔹 Built-in vs. Third-Party Modules

* **Built-in examples**: `math`, `random`, `os`, `sys`, `datetime`.
* **Third-party**: Installed with `pip`.

```bash
pip install requests
```

```python
import requests

response = requests.get("https://api.github.com")
print(response.status_code)  # 200
```

---

## 🔹 Organizing Large Projects with Packages

A **package** is a collection of modules inside a folder with a special `__init__.py` file.

Example structure:

```
mypackage/
    __init__.py
    mathutils.py
    stringutils.py
```

Then use:

```python
import mypackage.mathutils
```

---

# 📝 Exercises: Modules

1. Import the `math` module and print:

   * The square root of 49.
   * The value of `pi`.

2. From the `random` module, import `choice` and use it to pick a random fruit from `["apple", "banana", "cherry"]`.

3. Create a file **`greetings.py`** with a function `say_hello(name)`.
   Import it in another file and call the function.

4. Write a program that:

   * Uses the `os` module to print the current working directory.
   * Uses the `sys` module to print the list of module search paths.

5. Install the **`requests`** module (if available) and fetch the text from `https://example.com`.

---
