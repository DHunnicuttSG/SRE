# 🐍 Python User Input

## 🔹 What is User Input?

So far, we’ve written programs that use information we typed directly into the code. But often, we want the program to ask the **user** for information while it’s running.

In Python, this is done with the **`input()`** function.

---

## 🔹 Basic Example

```python
name = input("What is your name? ")
print("Hello", name)
```

👉 When you run this, Python will pause and wait for the user to type something.
If the user types `Alice`, the output will be:

```
What is your name? Alice
Hello Alice
```

---

## 🔹 Important: Input is Always a String

```python
age = input("How old are you? ")
print("You are", age, "years old.")
```

Even if you type `25`, Python treats it as `"25"` (a string).
To use it as a number, you need **type casting**:

```python
age = int(input("How old are you? "))
print("Next year, you will be", age + 1)
```

---

## 🔹 Examples

```python
# Asking for two numbers and adding them
num1 = int(input("Enter a number: "))
num2 = int(input("Enter another number: "))
print("The sum is:", num1 + num2)

# Asking for a favorite color
color = input("What is your favorite color? ")
print("Nice! I like", color, "too.")
```

---

## 📝 Exercises

### Exercise 1: Simple Greeting

Ask the user for their name and print a message:

```
Hello [name], welcome to Python!
```

---

### Exercise 2: Favorite Things

Ask the user for their favorite movie and favorite food. Print a sentence using both.

Example:

```
Your favorite movie is Inception and your favorite food is pizza.
```

---

### Exercise 3: Simple Math

Ask the user for two numbers. Convert them to integers and print their sum, product, and difference.

---

### Exercise 4: Age Calculator

Ask the user for the year they were born. Convert it to an integer and calculate their age (assume current year = 2025). Print the result.

---

### Challenge Exercise 🎯

Ask the user for:

* Their first name
* Their last name
* Their favorite programming language

Then print:

```
Nice to meet you, [first] [last]! I see you like [language].
```

---
