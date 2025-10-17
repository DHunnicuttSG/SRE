# 🐍 Python Conditional Expressions

## 🔹 What is a Conditional Expression?

A **conditional expression** allows you to write an `if…else` statement **in a single line**.
It’s often called a **ternary operator** because it has **three parts**:

```python
value_if_true if condition else value_if_false
```

---

## 🔹 Basic Example

```python
age = 20
status = "Adult" if age >= 18 else "Minor"
print(status)
```

*Output:*

```
Adult
```

* If the condition (`age >= 18`) is True, `"Adult"` is assigned to `status`.
* Otherwise, `"Minor"` is assigned.

---

## 🔹 Examples

### Example 1: Simple Conditional Expression

```python
num = 10
result = "Even" if num % 2 == 0 else "Odd"
print(result)
```

*Output:*

```
Even
```

---

### Example 2: Conditional Expression with Input

```python
age = int(input("Enter your age: "))
message = "You can vote." if age >= 18 else "You cannot vote yet."
print(message)
```

---

### Example 3: Nested Conditional Expression

```python
score = 85
grade = "A" if score >= 90 else "B" if score >= 75 else "C"
print("Grade:", grade)
```

*Output:*

```
Grade: B
```

---

## 🔹 When to Use Conditional Expressions

* Short, simple decisions are perfect.
* Avoid very long or complex expressions — use regular `if…elif…else` statements for clarity.

---

## 📝 Exercises

### Exercise 1: Even or Odd

Ask the user for a number. Use a conditional expression to print `"Even"` or `"Odd"`.

---

### Exercise 2: Voting Eligibility

Ask the user for their age. Use a conditional expression to print:

* `"You can vote."` if age ≥ 18
* `"You cannot vote yet."` otherwise

---

### Exercise 3: Maximum of Two Numbers

Ask the user for two numbers. Use a conditional expression to find and print the **larger number**.

---

### Exercise 4: Nested Conditional Expression

Ask the user for a test score (0–100). Use a **nested conditional expression** to assign a grade:

* 90+ → `"A"`
* 75–89 → `"B"`
* 60–74 → `"C"`
* Below 60 → `"F"`

---

### Challenge Exercise 🎯

Ask the user for a number. Use a conditional expression to print:

* `"Positive"` if the number > 0
* `"Negative"` if the number < 0
* `"Zero"` if the number is 0

---
