# 🧩 Python Exception Handling: Catching Exceptions

---

## 🔹 What Are Exceptions?

An **exception** is an error that occurs during program execution, which interrupts the normal flow of the program.

For example:

```python
print(10 / 0)
```

💥 Raises:

```
ZeroDivisionError: division by zero
```

If you don’t handle it, the program **crashes**.
That’s where **`try` and `except`** come in.

---

## 🔹 Basic Exception Handling

You can **catch** exceptions using a `try` and `except` block.

```python
try:
    num = int(input("Enter a number: "))
    print(10 / num)
except ZeroDivisionError:
    print("You can't divide by zero!")
except ValueError:
    print("That’s not a valid number.")
```

✅ **Explanation:**

* Code in the `try` block is executed first.
* If an exception occurs, Python jumps to the matching `except` block.
* If no exception occurs, the `except` blocks are skipped.

---

## 🔹 Catching Multiple Exceptions Together

You can handle multiple exceptions in a single line by grouping them in parentheses:

```python
try:
    result = 10 / int(input("Enter a number: "))
except (ValueError, ZeroDivisionError):
    print("Invalid input or division by zero.")
```

---

## 🔹 Catching All Exceptions (Not Recommended for Production)

Sometimes, you might not know which exceptions could occur.
You can use a **generic `except`** to catch any exception:

```python
try:
    x = int("abc")
except:
    print("Something went wrong!")
```

⚠️ **Warning:** Avoid this in production code.
It hides useful error details and makes debugging harder.

---

## 🔹 Getting Exception Details

Use the `as` keyword to access the exception object:

```python
try:
    print(10 / 0)
except ZeroDivisionError as e:
    print("Error:", e)
```

Output:

```
Error: division by zero
```

---

## 🔹 Using `else` and `finally`

Python’s `try` block can also include `else` and `finally` clauses:

```python
try:
    num = int(input("Enter a number: "))
    result = 10 / num
except ZeroDivisionError:
    print("Cannot divide by zero.")
else:
    print("Result is:", result)
finally:
    print("Program finished.")
```

✅ **How it works:**

* `try` → Run code.
* `except` → Handle errors.
* `else` → Runs **only if no exception** occurs.
* `finally` → Runs **always**, even if an error happens.

---

## 🔹 Raising Exceptions Manually

You can use `raise` to trigger exceptions yourself:

```python
def withdraw(balance, amount):
    if amount > balance:
        raise ValueError("Insufficient funds")
    return balance - amount

try:
    withdraw(100, 200)
except ValueError as e:
    print("Error:", e)
```

---

## 🧠 Common Built-in Exceptions

| Exception           | Description                                     |
| ------------------- | ----------------------------------------------- |
| `ValueError`        | Wrong value (e.g. converting "abc" to int)      |
| `TypeError`         | Operation on incompatible types                 |
| `IndexError`        | Index out of range in list or tuple             |
| `KeyError`          | Accessing non-existent dict key                 |
| `ZeroDivisionError` | Division by zero                                |
| `FileNotFoundError` | File operation fails because file doesn’t exist |
| `ImportError`       | Cannot import a module                          |
| `RuntimeError`      | Generic runtime error                           |

---

## 💡 Best Practices

✅ Catch **specific exceptions** (not `except:`).
✅ Use `finally` for cleanup (e.g. closing files).
✅ Avoid swallowing errors silently.
✅ Log or print errors for debugging.

---

## 🧩 Exercises

1. Write code that asks the user for two numbers and divides them.
   Catch:

   * `ValueError` (if input isn’t a number)
   * `ZeroDivisionError` (if denominator is zero)

2. Modify a file-reading program to catch `FileNotFoundError` and print a friendly message.

3. Write a function that raises a `ValueError` if an age is less than 0 or greater than 120.

4. Use `try`/`except`/`else`/`finally` in a program that converts a string to an integer and prints whether conversion succeeded.

---

## ✅ Example Solution

```python
try:
    num1 = int(input("Enter numerator: "))
    num2 = int(input("Enter denominator: "))
    result = num1 / num2
except ValueError:
    print("Please enter valid integers.")
except ZeroDivisionError:
    print("Denominator cannot be zero.")
else:
    print(f"Result = {result}")
finally:
    print("Execution complete.")
```

---
