# 🐍 Python Type Casting

## 🔹 What is Type Casting?

**Type casting** means converting a value from one data type to another.
In Python, you can easily change between numbers, strings, and other basic types using built-in functions.

---

## 🔹 Common Type Casting Functions

| Function   | Converts To                     |
| ---------- | ------------------------------- |
| `int(x)`   | Integer (whole number)          |
| `float(x)` | Floating-point number (decimal) |
| `str(x)`   | String (text)                   |
| `bool(x)`  | Boolean (`True` or `False`)     |

---

## 🔹 Examples

```python
# Convert float to int (decimal part is removed, not rounded)
x = 5.9
y = int(x)
print(y)   # Output: 5

# Convert int to float
a = 10
b = float(a)
print(b)   # Output: 10.0

# Convert number to string
age = 25
age_str = str(age)
print("I am " + age_str + " years old.")  # Works because both are strings now

# Convert string to number
num_str = "42"
num = int(num_str)
print(num + 8)  # Output: 50

# Convert to boolean
print(bool(0))     # False
print(bool(5))     # True
print(bool(""))    # False
print(bool("hi"))  # True
```

---

## 📝 Exercises

### Exercise 1: Integer to Float

Create an integer variable and convert it to a float. Print both versions.

---

### Exercise 2: String to Integer

Write code that takes the string `"100"` and converts it into an integer, then adds `50` to it. Print the result.

---

### Exercise 3: Mixing Numbers and Strings

Fix the following code so it runs correctly:

```python
age = 30
print("I am " + age + " years old")
```

---

### Exercise 4: Boolean Casting

Try casting the following values to booleans and note the results:

* `0`
* `1`
* `""` (empty string)
* `"Python"`

---

### Challenge Exercise 🎯

Write a program that asks the user for their birth year (as a string from input).

* Convert it to an integer.
* Calculate their age (assume current year = 2025).
* Print a message like:

  ```
  You are 20 years old.
  ```

---
