# 🐍 Python For Loops

## 🔹 What is a For Loop?

A **for loop** is used to **iterate over a sequence** (like a list, string, or range) and execute a block of code for each item.

**Syntax:**

```python
for variable in sequence:
    # code to execute
```

---

## 🔹 Basic Example: Iterating Over a List

```python
fruits = ["apple", "banana", "cherry"]

for fruit in fruits:
    print("I like", fruit)
```

*Output:*

```
I like apple
I like banana
I like cherry
```

---

## 🔹 Iterating Over a String

```python
word = "Python"

for letter in word:
    print(letter)    
```

*Output:*

```
P
y
t
h
o
n
```

*Now try this:*

```python
word = "Python"

for letter in word:
    print(letter, end=" ") 

# What does the output look like?
```

## 🔹 Using `range()`

* `range()` generates a sequence of numbers, commonly used in for loops.

```python
for i in range(5):  # 0 to 4
    print(i)

for i in range(1, 6):  # 1 to 5
    print(i)

for i in range(0, 10, 2):  # 0, 2, 4, 6, 8 (step = 2)
    print(i)
```

---

## 🔹 Nested For Loops

```python
for i in range(1, 4):
    for j in range(1, 4):
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

---

## 🔹 Using `break` and `continue`

```python
for i in range(1, 6):
    if i == 3:
        continue  # Skip 3
    if i == 5:
        break     # Stop the loop
    print(i)
```

*Output:*

```
1
2
4
```

---

## 📝 Exercises

### Exercise 1: Iterating Over a List

Create a list of your favorite fruits and print each one using a for loop.

---

### Exercise 2: Iterating Over a String

Ask the user for a word and print each letter on a separate line.

---

### Exercise 3: Using `range()`

Print all even numbers from 2 to 20 using a for loop and `range()`.

---

### Exercise 4: Nested Loops

Print a **multiplication table** from 1 to 5 using nested for loops.

---

### Exercise 5: Using `break` and `continue`

* Print numbers from 1 to 10
* Skip multiples of 3
* Stop printing if the number is greater than 8

---

### Challenge Exercise 🎯

Ask the user for a number `n` and print a **right-angled triangle** of stars with `n` rows:

```
*
**
***
****
...
```

---

I can also create a **solutions section with code answers** for for loops, so students can check their work after attempting the exercises.

Do you want me to create that next?

****************************************************

Absolutely! Let’s enhance the **for loops** section by adding clear examples of the **`continue`** and **`break`** keywords so students can see them in action. I’ll integrate them into the previous lesson content.

---

## 🔹 Using `continue` and `break` in For Loops

### **1. `continue`** – Skip the Current Iteration

The `continue` keyword **skips the rest of the current loop iteration** and moves to the next one.

```python
print("Skipping multiples of 3:")

for i in range(1, 11):
    if i % 3 == 0:
        continue  # Skip numbers divisible by 3
    print(i)
```

*Output:*

```
1
2
4
5
7
8
10
```

**Explanation:**

* Numbers divisible by 3 (3, 6, 9) are skipped.

---

### **2. `break`** – Stop the Loop Completely

The `break` keyword **stops the loop immediately**, even if the loop condition hasn’t finished.

```python
print("Stop loop when number is greater than 7:")

for i in range(1, 11):
    if i > 7:
        break  # Exit loop
    print(i)
```

*Output:*

```
1
2
3
4
5
6
7
```

**Explanation:**

* When `i` becomes 8, the loop stops entirely.

---

### **3. Combining `continue` and `break`**

```python
print("Skip 3, stop after 8:")

for i in range(1, 11):
    if i == 3:
        continue  # Skip number 3
    if i > 8:
        break     # Stop loop if number > 8
    print(i)
```

*Output:*

```
1
2
4
5
6
7
8
```

---

✅ **Tip for Students:**

* Use `continue` when you want to **skip certain values**.
* Use `break` when you want to **exit the loop early**.

---
