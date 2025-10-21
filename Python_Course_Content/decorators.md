## 🧩 What Is a Decorator?

A **decorator** in Python is a function that **wraps another function or method** to extend or modify its behavior — **without changing its code**.

Think of it like gift wrapping 🎁:
You take an existing function, “wrap” it with extra functionality, and still get the original function inside.

---

## ⚙️ Basic Syntax

A decorator is applied using the `@` symbol above a function definition.

Example:

```python
def my_decorator(func):
    def wrapper():
        print("Something happens *before* the function runs.")
        func()
        print("Something happens *after* the function runs.")
    return wrapper

@my_decorator
def say_hello():
    print("Hello!")

say_hello()
```

### 🧠 Output:

```
Something happens *before* the function runs.
Hello!
Something happens *after* the function runs.
```

✅ **What happened?**

* `@my_decorator` means `say_hello = my_decorator(say_hello)`
* The decorator wraps the original function inside another function (`wrapper`), adding behavior before and after the call.

---

## 🔁 Decorators with Arguments

If your decorated function takes arguments, you must let the wrapper accept them too.

```python
def log_arguments(func):
    def wrapper(*args, **kwargs):
        print(f"Calling {func.__name__} with {args} and {kwargs}")
        return func(*args, **kwargs)
    return wrapper

@log_arguments
def add(a, b):
    return a + b

print(add(3, 5))
```

🧠 Output:

```
Calling add with (3, 5) and {}
8
```

---

## 🧱 Real-World Uses of Decorators

| Use Case                    | Example                               |
| --------------------------- | ------------------------------------- |
| ✅ **Logging**               | Log when a function is called         |
| ⏱️ **Timing**               | Measure how long a function takes     |
| 🔒 **Access Control**       | Check user permissions                |
| 🧪 **Validation**           | Validate arguments before running     |
| ⚙️ **Flask/Django Routing** | `@app.route('/home')` is a decorator! |

---

## ⏱️ Example: Timing a Function

```python
import time

def timer(func):
    def wrapper(*args, **kwargs):
        start = time.time()
        result = func(*args, **kwargs)
        end = time.time()
        print(f"{func.__name__} ran in {end - start:.3f} seconds.")
        return result
    return wrapper

@timer
def slow_function():
    time.sleep(2)

slow_function()
```

Output:

```
slow_function ran in 2.002 seconds.
```

---

## 🧍‍♂️ Decorators with Classes (Method Decorators)

Decorators can also be used on **class methods**.

```python
def uppercase_output(func):
    def wrapper(self):
        result = func(self)
        return result.upper()
    return wrapper

class Greeter:
    def __init__(self, name):
        self.name = name

    @uppercase_output
    def greet(self):
        return f"Hello {self.name}"

g = Greeter("David")
print(g.greet())  # Output: HELLO DAVID
```

---

## 🧩 Built-In Decorators

Python includes several built-in decorators for classes:

| Decorator       | Use                                                              | Example                                 |
| --------------- | ---------------------------------------------------------------- | --------------------------------------- |
| `@staticmethod` | Defines a method that doesn’t access instance or class variables | Used for helper methods                 |
| `@classmethod`  | Takes the class (`cls`) as the first argument instead of `self`  | Used to create alternative constructors |
| `@property`     | Turns a method into a read-only attribute                        | Used for computed attributes            |

Example:

```python
class Circle:
    def __init__(self, radius):
        self._radius = radius

    @property
    def area(self):
        return 3.14 * self._radius ** 2

c = Circle(5)
print(c.area)   # Access like attribute, no parentheses
```

---

## 🧠 Stacking Multiple Decorators

You can stack more than one decorator.
They apply **from bottom to top**.

```python
@decorator1
@decorator2
def func():
    pass
```

is equivalent to:

```python
func = decorator1(decorator2(func))
```

---

## ✅ Summary

| Concept          | Description                                                  | Example                               |
| ---------------- | ------------------------------------------------------------ | ------------------------------------- |
| **Definition**   | Function that takes another function and returns a new one   | `def decorator(func): return wrapper` |
| **Applied with** | `@decorator_name`                                            | `@my_decorator`                       |
| **Common Uses**  | Logging, timing, validation, caching, access control         | `@app.route`, `@property`             |
| **For methods**  | Often used with `@staticmethod`, `@classmethod`, `@property` |                                       |
| **Stackable**    | Multiple decorators can wrap one function                    | `@dec1 @dec2`                         |

---

