# 📘 Python Variable Scope and Scope Resolution

## 🔹 What is Variable Scope?

* **Scope** defines **where a variable can be accessed** in the program.
* Python uses **LEGB rule** to resolve variable names:

| Scope             | Description                                                           |
| ----------------- | --------------------------------------------------------------------- |
| **L – Local**     | Variables defined inside a function or block.                         |
| **E – Enclosing** | Variables in enclosing (outer) functions when using nested functions. |
| **G – Global**    | Variables defined at the top-level of a module or declared `global`.  |
| **B – Built-in**  | Names pre-defined in Python (e.g., `len`, `print`).                   |

---

## 🔹 Local Scope

Variables defined inside a function are **local** to that function.

```python
def my_func():
    x = 10  # Local variable
    print(x)

my_func()    # 10
# print(x)  # ❌ Error: x not defined
```

---

## 🔹 Enclosing Scope (Nested Functions)

```python
def outer():
    x = "outer variable"
    def inner():
        print(x)  # Accesses x from enclosing scope
    inner()

outer()  # Output: outer variable
```

---

## 🔹 Global Scope

* Variables defined outside any function are **global**.

```python
x = 50  # Global variable

def print_x():
    print(x)

print_x()  # 50
```

* To **modify** a global variable inside a function, use `global`.

```python
count = 0

def increment():
    global count
    count += 1

increment()
print(count)  # 1
```

---

## 🔹 Built-in Scope

* Python has built-in functions and constants like `len()`, `min()`, `True`.
* These are accessible anywhere:

```python
print(len([1,2,3]))  # 3
```

---

## 🔹 Nonlocal Variables

* `nonlocal` lets you modify a variable in the **enclosing function** (not global).

```python
def outer():
    x = 5
    def inner():
        nonlocal x
        x += 1
        print("Inner:", x)
    inner()
    print("Outer:", x)

outer()
```

✅ Output:

```
Inner: 6
Outer: 6
```

* Without `nonlocal`, `inner` would create a **new local `x`**, leaving the outer `x` unchanged.

---

## 🔹 LEGB Rule in Action

```python
x = "global"

def outer():
    x = "enclosing"
    def inner():
        x = "local"
        print(x)
    inner()

outer()  # Output: local
print(x) # Output: global
```

* Python searches for a variable in **L → E → G → B** order.

---

## 🔹 Best Practices

1. Avoid modifying globals unless necessary.
2. Prefer **local variables** for functions.
3. Use `nonlocal` for nested functions when needed.
4. Understand LEGB to avoid name conflicts.

---

# 📝 Exercises: Variable Scope

1. Write a function that defines a **local variable** `x = 10` and prints it. Try printing `x` outside the function (what happens?).

2. Define a **global variable** `count = 0` and create a function that increments it using `global`.

3. Create a nested function where the inner function prints a variable from the **enclosing scope**.

4. Modify a variable in the enclosing scope using `nonlocal`.

5. Predict the output:

```python
x = "global"

def outer():
    x = "outer"
    def inner():
        x = "inner"
        print(x)
    inner()
    print(x)

outer()
print(x)
```

---
