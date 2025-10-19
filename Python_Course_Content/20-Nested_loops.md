# 🐍 Python Nested Loops

## 🔹 What is a Nested Loop?

A **nested loop** is a loop inside another loop.

* The **inner loop** runs completely for **every iteration** of the outer loop.
* Useful for working with **matrices, tables, and patterns**.

**Syntax:**

```python
for outer_variable in outer_sequence:
    for inner_variable in inner_sequence:
        # code to execute
```

---

## 🔹 Basic Example: Multiplication Pairs

```python
for i in range(1, 4):      # Outer loop
    for j in range(1, 4):  # Inner loop
        print(i, j)
```

*Output:*

```
1 1
1 2
1 3
2 1
2 2
2 3
3 1
3 2
3 3
```

**Explanation:**

* For every value of `i`, the inner loop runs through all values of `j`.

---

## 🔹 Example: Multiplication Table

```python
for i in range(1, 6):
    for j in range(1, 6):
        print(f"{i*j:3}", end=" ")
    print()  # Move to next line after inner loop
```

*Output:*

```
  1   2   3   4   5
  2   4   6   8  10
  3   6   9  12  15
  4   8  12  16  20
  5  10  15  20  25
```

* `end=" "` keeps the output on the same line.
* `print()` after the inner loop moves to the next line.

---

## 🔹 Example: Pattern Printing

```python
rows = 5

for i in range(1, rows+1):
    for j in range(i):
        print("*", end="")
    print()
```

*Output:*

```
*
**
***
****
*****
```

---

## 🔹 Using `break` and `continue` in Nested Loops

```python
for i in range(1, 4):
    for j in range(1, 4):
        if j == 2:
            continue  # Skip inner loop value 2
        if i == 3 and j == 3:
            break     # Stop inner loop completely
        print(i, j)
```

*Output:*

```
1 1
1 3
2 1
2 3
3 1
3 3
```

---

## 📝 Exercises

### Exercise 1: Nested Loops Table

Use nested loops to print a **5x5 table** of numbers (rows × columns).

---

### Exercise 2: Star Pattern

Print this pattern using nested loops:

```
*
**
***
****
*****
```

---

### Exercise 3: Reverse Star Pattern

Print this pattern:

```
*****
****
***
**
*
```

---

### Exercise 4: Multiplication Table

Print the multiplication table for numbers 1 to 10 using nested loops.

---

### Challenge Exercise 🎯

Ask the user for a number `n` and print a **right-angled triangle** with numbers:

```
1
1 2
1 2 3
1 2 3 4
...
```

---
