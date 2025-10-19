# 🐍 Python String Indexing

## 🔹 What is String Indexing?

In Python, a **string** is a sequence of characters. Each character has an **index** (position) that starts at **0** for the first character.

You can use **indexing** to access individual characters in a string.

---

## 🔹 Basic Indexing

```python
text = "Python"

print(text[0])  # 'P' (first character)
print(text[1])  # 'y'
print(text[5])  # 'n' (last character)
```

* **Index starts at 0**.
* Using an index **larger than the string length** will cause an error.

---

## 🔹 Negative Indexing

* Python also supports **negative indexing**, which starts from the **end of the string**.

```python
text = "Python"

print(text[-1])  # 'n' (last character)
print(text[-2])  # 'o' (second to last)
print(text[-6])  # 'P' (first character)
```

---

## 🔹 String Slicing

* You can access a **range of characters** using slicing:

```python
text = "Python"

print(text[0:4])  # 'Pyth' (start at index 0, up to but not including 4)
print(text[2:])   # 'thon' (from index 2 to end)
print(text[:4])   # 'Pyth' (from start to index 3)
print(text[-4:-1])# 'tho' (from -4 to -2)
```

* **Syntax:** `string[start:end]`
* **Optional step:** `string[start:end:step]`

```python
text = "Python"
print(text[0:6:2])  # 'Pto' (every 2nd character)
```

---

## 🔹 Common Operations

```python
text = "Python"

print(len(text))     # 6 (length of string)
print(text[0].upper()) # 'P' (can use string methods on individual characters)
```

---

## 📝 Exercises

### Exercise 1: Access Characters

Ask the user for a word and print:

* The first character
* The last character
* The second-to-last character

---

### Exercise 2: Slicing

Ask the user for a word and print:

* The first three characters
* The last three characters
* The middle part (excluding first and last character)

---

### Exercise 3: Step Slicing

Ask the user for a word and print every **second character**.

---

### Exercise 4: Reverse String

Ask the user for a word and **print it backwards** using slicing.

---

### Challenge Exercise 🎯

Ask the user for a sentence.

* Print a new string containing only the **first letter of each word** (like initials).

---
