# 📘 Module: File Input and Output in Python

**Audience:** Intro to Intermediate Python students  
**Duration:** \~1–1.5 hours  
**Tools:** Any Python interpreter (IDLE, VS Code, Jupyter, etc.)

***

# 1. 🎯 Learning Objectives

By the end of this module, students will be able to:

1.  Explain what files are and why programs read/write them
2.  Use Python to:
    *   Open, read, write, and append to text files
    *   Differentiate file access modes (`r`, `w`, `a`, `r+`, etc.)
    *   Marshal (serialize) Python data structures into text files
    *   Unmarshal (deserialize) them back into Python objects
3.  Use the `with` statement to safely handle files

***

# 2. 📂 Introduction to Files in Python

Files allow programs to **store data permanently**, beyond the end of execution. Python provides simple, powerful tools for reading and writing files using the built‑in `open()` function.

***

# 3. 🔧 The `open()` Function

```python
file = open("filename.txt", "mode")
```

### Common File Modes

| Mode | Meaning             | Creates File? | Overwrites Existing? |
| ---- | ------------------- | ------------- | -------------------- |
| `r`  | Read-only (default) | ❌             | ❌                    |
| `w`  | Write-only          | ✔️            | ✔️                   |
| `a`  | Append-only         | ✔️            | ❌                    |
| `r+` | Read & write        | ❌             | ❌                    |
| `w+` | Write & read        | ✔️            | ✔️                   |
| `a+` | Append & read       | ✔️            | ❌                    |

***

# 4. 📖 Reading From Files

## 4.1 Read entire file

```python
with open("example.txt", "r") as f:
    contents = f.read()
    print(contents)
```

## 4.2 Read line by line

```python
with open("example.txt", "r") as f:
    for line in f:
        print(line.strip())
```

## 4.3 Read into a list of lines

```python
with open("example.txt", "r") as f:
    lines = f.readlines()
```

***

# 5. ✍️ Writing To Files

## 5.1 Overwrite write (`w`)

```python
with open("output.txt", "w") as f:
    f.write("Hello, world!\n")
```

## 5.2 Append (`a`)

```python
with open("output.txt", "a") as f:
    f.write("Adding another line.\n")
```

***

# 6. 🔄 Why Use `with`?

`with` ensures files are properly closed—even when errors occur.

```python
with open("file.txt") as f:
    pass  # file automatically closes
```

Without `with`, you’d have to remember `file.close()`, which is error‑prone.

***

# 7. 📦 Marshalling and Unmarshalling Data

**Marshalling** = converting Python objects into a text format  
**Unmarshalling** = reconstructing objects from text

Students often confuse this with file I/O alone—this section shows how they work together.

***

# 8. 📝 Marshalling to Text Files

### 8.1 Marshalling using plain text

```python
data = ["Alice", "Bob", "Charlie"]

with open("names.txt", "w") as f:
    for name in data:
        f.write(name + "\n")
```

### 8.2 Unmarshalling plain text back to Python list

```python
with open("names.txt", "r") as f:
    data = [line.strip() for line in f]
```

***

# 9. 🧱 Marshalling Using JSON (Recommended)

Python’s `json` module is perfect for storing dictionaries/lists.

### 9.1 Marshal Python → JSON text

```python
import json

person = {
    "name": "David",
    "age": 34,
    "courses": ["Python", "Databases"]
}

with open("person.json", "w") as f:
    json.dump(person, f, indent=4)
```

### 9.2 Unmarshal JSON → Python object

```python
import json

with open("person.json", "r") as f:
    person = json.load(f)

print(person["courses"])
```

***
# 10. 🧪 Practice Exercises

### **Exercise 1: Read & Print File**

Write a file called `fruits.txt` with 5 fruits and then read/print them line by line.

***

### **Exercise 2: Write a Log File**

Append timestamped messages to a file named `log.txt`.

***

### **Exercise 3: JSON Marshalling**

Store a list of 3 dictionaries (students with name, grade) as JSON, then read it back.

***

### **Exercise 4: Custom File Mode Demo**

Write a program that:

1.  Writes a line using `w`
2.  Adds a line using `a`
3.  Reads the file using `r`

***

# 12. 🧠 Summary

Students should now understand:

*   How to open, read, write, and append files in Python
*   Differences between file modes
*   Why `with` is the standard practice
*   How to marshal/unmarshal data:
    *   Text
    *   JSON

***
