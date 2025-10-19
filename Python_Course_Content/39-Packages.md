# 📘 Python Packages

## 🔹 What is a Package?

* A **package** is a **collection of Python modules** organized in a **directory**.
* Packages help you **organize large projects** and avoid naming conflicts.
* Every package directory contains a special file: `__init__.py`.

---

## 🔹 The `__init__.py` File

* Can be empty, but it **tells Python that this directory is a package**.
* Can also **execute package initialization code** or define `__all__` to control imports.

Example:

```
mypackage/
    __init__.py
    mathutils.py
    stringutils.py
```

**mypackage/**init**.py:**

```python
# Optional initialization code
print("mypackage loaded")
```

---

## 🔹 Importing Modules from a Package

```python
# Import entire module
import mypackage.mathutils

result = mypackage.mathutils.add(5, 3)
print(result)
```

```python
# Import a specific function
from mypackage.mathutils import add

print(add(10, 20))
```

```python
# Import everything (not recommended)
from mypackage.mathutils import *
```

---

## 🔹 Nested Packages

You can have packages inside packages:

```
myproject/
    __init__.py
    utils/
        __init__.py
        mathutils.py
        stringutils.py
```

```python
from utils.mathutils import add
print(add(2, 3))
```

---

## 🔹 Using `__all__` in `__init__.py`

Controls what is imported with `from package import *`.

**mypackage/**init**.py:**

```python
__all__ = ["mathutils"]  # Only mathutils will be imported with *
```

```python
from mypackage import *
# Now mathutils is available, stringutils is not
```

---

## 🔹 Relative Imports in Packages

Inside a package, you can import using relative paths:

```python
# utils/stringutils.py
from .mathutils import add  # Import from same package
```

* `.` → current package
* `..` → parent package

---

## 🔹 Why Use Packages?

✔ Organizes large projects into **manageable modules**
✔ Avoids naming conflicts
✔ Allows **reusable code** across projects
✔ Supports **modular design** for testing and maintenance

---

# 📝 Exercises: Python Packages

1. Create a package `mypackage` with modules `mathutils.py` and `stringutils.py`.

   * `mathutils.py` should have `add(a, b)` and `subtract(a, b)`.
   * `stringutils.py` should have `uppercase(s)` and `lowercase(s)`.

2. In a separate script, import `mypackage.mathutils` and call `add` and `subtract`.

3. Import only the `uppercase` function from `mypackage.stringutils` and test it.

4. Create a nested package:

```
mypackage/
    __init__.py
    utils/
        __init__.py
        mathutils.py
        stringutils.py
```

* Use a relative import inside `stringutils.py` to access a function from `mathutils.py`.

5. Add `__all__` to the `mypackage/__init__.py` so that only `mathutils` is imported with `from mypackage import *`.

---
