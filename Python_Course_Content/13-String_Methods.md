# 🐍 Python String Methods

## 🔹 What Are String Methods?

String methods are **built-in functions** that you can use to manipulate and inspect strings in Python.
They make working with text easier and more powerful.

---

## 🔹 Common String Methods

### 1. Changing Case

```python
text = "hello world"

print(text.upper())   # "HELLO WORLD"
print(text.lower())   # "hello world"
print(text.title())   # "Hello World"
```

---

### 2. Removing Whitespace

```python
text = "   Python   "
print(text.strip())   # "Python" (removes spaces from both ends)
print(text.lstrip())  # "Python   " (removes left spaces)
print(text.rstrip())  # "   Python" (removes right spaces)
```

---

### 3. Searching & Replacing

```python
text = "I love Python"

print(text.replace("Python", "Java"))   # "I love Java"
print(text.find("Python"))              # 7 (index of first character)
print(text.count("o"))                  # 2 (number of occurrences)
```

---

### 4. Splitting & Joining

```python
text = "apple,banana,cherry"

fruits = text.split(",")   # ['apple', 'banana', 'cherry']
print(fruits)

joined = "-".join(fruits)  # "apple-banana-cherry"
print(joined)
```

---

### 5. Checking Content

```python
text = "Python123"

print(text.isalpha())   # False (contains numbers)
print(text.isdigit())   # False (contains letters)
print("123".isdigit())  # True
print(text.startswith("Py"))  # True
print(text.endswith("123"))   # True
```

---

### 6. String Formatting (f-strings)

```python
name = "Alice"
age = 25
print(f"My name is {name} and I am {age} years old.")  
# Output: My name is Alice and I am 25 years old.
```

---

## 📝 Exercises

### Exercise 1: Change Case

Ask the user for a sentence. Print the sentence in:

* Uppercase
* Lowercase
* Title case

---

### Exercise 2: Remove Whitespace

Ask the user for a string with extra spaces at the start and end. Print the **trimmed string**.

---

### Exercise 3: Search & Replace

Ask the user for a sentence. Replace all occurrences of `"Python"` with `"Java"`. Print the new sentence.

---

### Exercise 4: Split & Join

Ask the user for a list of words separated by commas.

* Split them into a list.
* Join them back using a hyphen `-`.
* Print the result.

---

### Exercise 5: Check Content

Ask the user to enter a string. Print whether the string:

* Contains only letters (`isalpha`)
* Contains only digits (`isdigit`)
* Starts with `"Hello"`
* Ends with `"!"`

---

### Challenge Exercise 🎯

Ask the user for their full name.

* Print their **initials** (first letters of each name).
* Example: `"John Doe"` → `"JD"`

---
