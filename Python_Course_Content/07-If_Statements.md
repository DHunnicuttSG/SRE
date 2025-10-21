# 🐍 Python If Statements

## 🔹 What is an If Statement?

An **if statement** allows your program to make **decisions**. It runs a block of code **only if a certain condition is true**.

---

## 🔹 Basic Syntax

```python
if condition:
    # code to run if condition is True
```

* The **condition** is an expression that evaluates to `True` or `False`.
* Indentation is important in Python – the code inside the `if` must be indented.

---

## 🔹 Example 1: Simple If Statement

```python
age = 18

if age >= 18:
    print("You are an adult.")
```

*Output:*

```
You are an adult.
```

If `age` was less than 18, nothing would be printed.

---

## 🔹 If…Else Statement

Use **else** to run code when the condition is **False**:

```python
age = 16

if age >= 18:
    print("You are an adult.")
else:
    print("You are a minor.")
```

*Output:*

```
You are a minor.
```

---

## 🔹 If…Elif…Else Statement

Use **elif** (else if) to check multiple conditions:

```python
score = 85

if score >= 90:
    print("Grade: A")
elif score >= 75:
    print("Grade: B")
elif score >= 60:
    print("Grade: C")
else:
    print("Grade: F")
```

*Output:*

```
Grade: B
```

---

## 🔹 Comparison Operators

| Operator | Meaning          | Example  |
| -------- | ---------------- | -------- |
| `==`     | Equal to         | `x == y` |
| `!=`     | Not equal to     | `x != y` |
| `>`      | Greater than     | `x > y`  |
| `<`      | Less than        | `x < y`  |
| `>=`     | Greater or equal | `x >= y` |
| `<=`     | Less or equal    | `x <= y` |

---

## 🔹 Logical Operators

| Operator | Meaning              | Example            |
| -------- | -------------------- | ------------------ |
| `and`    | Both conditions True | `x > 5 and x < 10` |
| `or`     | At least one True    | `x < 5 or x > 10`  |
| `not`    | Negates the value    | `not(x > 5)`       |

---

## 📝 Exercises

### Exercise 1: Simple If

Ask the user for a number. If it’s greater than 10, print `"The number is big!"`.

---

### Exercise 2: If…Else

Ask the user for their age. If they are 18 or older, print `"You can vote!"`. Otherwise, print `"You are too young to vote."`

---

### Exercise 3: If…Elif…Else

Ask the user for a score between 0 and 100. Print the grade based on this scale:

* 90+ → `"A"`
* 75–89 → `"B"`
* 60–74 → `"C"`
* Below 60 → `"F"`

---

### Exercise 4: Logical Operators

Ask the user for a number. Print `"The number is between 10 and 20"` only if the number is **greater than 10 AND less than 20**.

---

### Challenge Exercise 🎯

Ask the user for the day of the week.

* If it’s `"Saturday"` or `"Sunday"`, print `"It’s the weekend!"`
* Otherwise, print `"Time to work!"`

---
