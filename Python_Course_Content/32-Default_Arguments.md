# 📘 Python Default Arguments

## 🔹 What are Default Arguments?

* Default arguments let you **assign a default value** to a function parameter.
* If the caller does not provide that argument, the function uses the default.

**Syntax:**

```python
def function_name(param=value):
    # function body
```

---

## 🔹 Basic Example

```python
def greet(name="friend"):
    print("Hello,", name)

greet()          # Hello, friend
greet("Alice")   # Hello, Alice
```

👉 If no argument is passed, `"friend"` is used as the default.

---

## 🔹 Multiple Parameters with Defaults

```python
def introduce(name, age=18, city="Unknown"):
    print(f"My name is {name}, I am {age} years old, from {city}.")

introduce("Bob")  
# My name is Bob, I am 18 years old, from Unknown.

introduce("Alice", 25, "New York")  
# My name is Alice, I am 25 years old, from New York.
```

⚡ You can **mix required and default parameters**, but:
👉 All parameters with defaults must come **after** required ones.

```python
def wrong(age=20, name):  # ❌ ERROR
    pass
```

---

## 🔹 Default Arguments with Expressions

Defaults don’t have to be constants — they can be results of expressions:

```python
def power(base, exp=2):
    return base ** exp

print(power(3))      # 9  (exp defaults to 2)
print(power(3, 3))   # 27
```

---

## 🔹 ⚠️ The Mutable Default Argument Gotcha

A common **beginner mistake** is using a mutable object (like a list or dict) as a default.

```python
def add_item(item, container=[]):
    container.append(item)
    return container

print(add_item("apple"))   # ['apple']
print(add_item("banana"))  # ['apple', 'banana']  (⚠️ Unexpected!)
```

👉 The list is created **once** when the function is defined, not each time it’s called.

✅ Fix: Use `None` as the default, then create a new list inside the function.

```python
def add_item(item, container=None):
    if container is None:
        container = []
    container.append(item)
    return container

print(add_item("apple"))   # ['apple']
print(add_item("banana"))  # ['banana'] ✅ Works correctly
```

---

## 🔹 Mixing Positional and Default Arguments

```python
def describe_pet(name, animal="dog"):
    print(f"{name} is a {animal}.")

describe_pet("Charlie")         # Charlie is a dog.
describe_pet("Mittens", "cat")  # Mittens is a cat.
```

---

# 📝 Exercises: Default Arguments

1. Write a function `welcome_user(name="Guest")` that prints a welcome message.
2. Write a function `calculate_tax(price, tax_rate=0.07)` that returns the price after tax.
3. Write a function `repeat_word(word, times=3)` that repeats a word multiple times.

   * Example: `repeat_word("Hi")` → `"HiHiHi"`.
4. Fix this buggy function (mutable default problem):

   ```python
   def add_number(n, numbers=[]):
       numbers.append(n)
       return numbers
   ```
5. Write a function `make_profile(name, age=0, country="Unknown")` that returns a dictionary with that information.

---
