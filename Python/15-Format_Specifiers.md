# 🐍 Python Format Specifiers

## 🔹 What Are Format Specifiers?

Format specifiers allow you to **control how values are displayed** when printing. They are commonly used for **numbers, strings, and alignment**.

In Python, we can use **old-style formatting** (`%`) and **new-style formatting** (`format()` and f-strings\`).

---

## 🔹 Old-Style Formatting (`%`)

```python
name = "Alice"
age = 25
height = 5.6

print("My name is %s, I am %d years old, and my height is %.1f feet." % (name, age, height))
```

* `%s` → String
* `%d` → Integer
* `%f` → Floating-point number
* `%.1f` → Float with **1 decimal place**

*Output:*

```
My name is Alice, I am 25 years old, and my height is 5.6 feet.
```

---

## 🔹 New-Style Formatting (`format()`)

```python
name = "Bob"
age = 30
height = 6.1

print("My name is {}, I am {} years old, and my height is {:.2f} feet.".format(name, age, height))
```

* `{}` → Placeholder
* `:.2f` → Format float with **2 decimal places**

---

## 🔹 f-Strings (Python 3.6+)

```python
name = "Charlie"
age = 22
height = 5.75

print(f"My name is {name}, I am {age} years old, and my height is {height:.2f} feet.")
```

* Prefix the string with `f`
* Use `{}` to insert variables
* Can include **formatting inside `{}`**

---

## 🔹 Alignment and Padding

```python
text = "Python"
num = 42

print(f"{text:<10} -> left aligned")   # Left align in 10 spaces
print(f"{text:>10} -> right aligned")  # Right align in 10 spaces
print(f"{num:05} -> padded with zeros") # 00042
```

---

## 🔹 Combining with Expressions

```python
x = 7
y = 3
print(f"{x} + {y} = {x+y}")  # Can include calculations directly
```

*Output:*

```
7 + 3 = 10
```

---

## 📝 Exercises

### Exercise 1: Old-Style Formatting

Ask the user for their name and age. Print:

```
Hello [name], you are [age] years old.
```

Use `%` formatting.

---

### Exercise 2: New-Style Formatting

Ask the user for a product name, price, and quantity. Print:

```
You bought [quantity] [product](s) for $[price] each.
```

Use `format()` formatting.

---

### Exercise 3: f-Strings

Ask the user for their name and GPA. Print:

```
[name], your GPA is [GPA].
```

* Format the GPA to **2 decimal places** using f-strings.

---

### Exercise 4: Alignment

Print a table of 3 products with **name**, **quantity**, and **price**, aligned neatly in columns.

---

### Challenge Exercise 🎯

Ask the user for 3 numbers.

* Print them **right-aligned in 5 spaces**, and also show their **sum** at the bottom.

---
