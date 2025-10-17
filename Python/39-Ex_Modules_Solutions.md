# 📘 Solutions: Python Modules Exercises

### **Exercise 1: Import `math` and print square root and pi**

```python
import math

print(math.sqrt(49))  # Output: 7.0
print(math.pi)        # Output: 3.141592653589793
```

---

### **Exercise 2: Import `choice` from `random`**

```python
from random import choice

fruits = ["apple", "banana", "cherry"]
selected_fruit = choice(fruits)
print(selected_fruit)  # Output: Randomly chosen fruit
```

---

### **Exercise 3: Create a module `greetings.py` and use it**

**greetings.py:**

```python
def say_hello(name):
    print(f"Hello, {name}!")
```

**main.py:**

```python
import greetings

greetings.say_hello("Alice")  # Output: Hello, Alice!
```

---

### **Exercise 4: Using `os` and `sys`**

```python
import os
import sys

# Print current working directory
print("Current working directory:", os.getcwd())

# Print Python module search paths
print("Module search paths:", sys.path)
```

---

### **Exercise 5: Using `requests` to fetch webpage**

```python
import requests

response = requests.get("https://example.com")
print("Status Code:", response.status_code)
print("Content Preview:", response.text[:200])  # Print first 200 characters
```

> ⚠ Note: Make sure `requests` is installed using:

```bash
pip install requests
```

---
