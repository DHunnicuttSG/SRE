# 🐍 Python Variables

## 🔹 What is a Variable?

A **variable** is like a container that stores data. You give the container a name, and you can use that name to access or change the data later.

In Python:

* You don’t need to declare the type of a variable (Python figures it out automatically).
* Variable names must start with a letter or `_`, and can contain letters, numbers, and underscores.

---

## 🔹 Creating Variables

```python
# Assigning values to variables
name = "Alice"       # string
age = 25             # integer
height = 5.6         # float (decimal number)
is_student = True    # boolean (True/False)
```

---

## 🔹 Using Variables

```python
# Printing variables
print(name)       # Output: Alice
print(age)        # Output: 25

# Using variables in sentences
print("My name is", name, "and I am", age, "years old.")

# Doing math with variables
x = 10
y = 3
result = x + y
print(result)     # Output: 13
```

---

## 🔹 Updating Variables

```python
counter = 0
print(counter)   # Output: 0

counter = counter + 1
print(counter)   # Output: 1

# Shortcut
counter += 1
print(counter)   # Output: 2
```

---

## 🔹 Rules for Variable Names

✅ Allowed: `age`, `first_name`, `height2`
❌ Not allowed: `2cool`, `my-name`, `class` (because `class` is a reserved keyword)

---

## 📝 Exercises

### Exercise 1: Create Variables

1. Create variables for your name, your age, and your favorite color.
2. Print them in a sentence like:

   ```
   My name is Sam, I am 20 years old, and my favorite color is blue.
   ```

---

### Exercise 2: Math with Variables

1. Create two variables, `num1` and `num2`.
2. Store their sum, difference, product, and quotient in new variables.
3. Print out all the results.

Example output:

```
Sum: 15
Difference: 5
Product: 50
Quotient: 2.0
```

---

### Exercise 3: Updating Values

1. Create a variable `score` and set it to 0.
2. Add 10 points to it, then 5 more points.
3. Print the final score.

---

### Challenge Exercise 🎯

Write a small program that asks the user for:

* Their name
* Their favorite food

Then print:

```
Hello [name], I heard your favorite food is [food]!
```

(Hint: use the `input()` function)

---
