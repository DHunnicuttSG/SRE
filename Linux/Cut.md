Excellent — the `cut` command is one of those **small but mighty** Linux utilities every sysadmin and data wrangler should know. It’s perfect for **extracting specific columns, fields, or characters** from lines of text, CSV files, or command outputs.

Let’s go through a complete **lesson + examples + practice exercises** 👇

---

# ✂️ **Using the `cut` Command in Linux**

---

## 🧩 **Overview**

**`cut`** extracts specific parts of each line of text from a file or stream.
You can use it to select:

* **Characters** (`-c`)
* **Bytes** (`-b`)
* **Delimited fields** (`-d` + `-f`)

---

## 🧠 **Basic Syntax**

```bash
cut OPTION [FILE]
```

### Common options:

| Option         | Description                                                          |
| -------------- | -------------------------------------------------------------------- |
| `-c`           | Select specific **characters**                                       |
| `-b`           | Select specific **bytes**                                            |
| `-d`           | Set the **delimiter** (e.g., comma, colon, space)                    |
| `-f`           | Select **fields** (columns) based on the delimiter                   |
| `--complement` | Invert the selection (show everything *except* the specified fields) |

---

## 📁 **Example File (`data.txt`):**

```
Name,Age,City
Alice,30,New York
Bob,25,Chicago
Carol,27,San Francisco
```

---

## 🧮 **1. Cut by Field (`-d` and `-f`)**

### Example: Extract the 1st field (Name)

```bash
cut -d',' -f1 data.txt
```

**Output:**

```
Name
Alice
Bob
Carol
```

### Example: Extract the 2nd and 3rd fields

```bash
cut -d',' -f2,3 data.txt
```

**Output:**

```
Age,City
30,New York
25,Chicago
27,San Francisco
```

### Example: Skip the header row

Combine with `tail -n +2`:

```bash
tail -n +2 data.txt | cut -d',' -f1
```

**Output:**

```
Alice
Bob
Carol
```

---

## 💻 **2. Cut by Character Position (`-c`)**

### Example: Show only the first 4 characters of each line

```bash
cut -c1-4 data.txt
```

**Output:**

```
Name
Alic
Bob,
Caro
```

---

## 🧰 **3. Use with Pipes**

You can pass command output through `cut`:

```bash
ps aux | cut -c1-20
```

👉 Displays only the first 20 characters of each process line.

---

## ⚙️ **4. Cut by Field with System Files**

Example: Extract usernames from `/etc/passwd`
(`:` is the field delimiter)

```bash
cut -d':' -f1 /etc/passwd
```

**Output:**

```
root
daemon
bin
sys
...
```

---

## 🎯 **5. Using `--complement`**

Show all fields *except* the first:

```bash
cut -d',' -f1 --complement data.txt
```

**Output:**

```
Age,City
30,New York
25,Chicago
27,San Francisco
```

---

## 🔬 **6. Combine with `sort`, `uniq`, or `grep`**

### Example: List unique cities

```bash
cut -d',' -f3 data.txt | tail -n +2 | sort | uniq
```

**Output:**

```
Chicago
New York
San Francisco
```

---

## 🎓 **Classroom Activities**

### 🧩 **Activity 1 — Extract Fields**

Given a file `students.csv`:

```
ID,Name,Grade,Email
1,Alice,90,alice@mail.com
2,Bob,85,bob@mail.com
3,Carol,88,carol@mail.com
```

👉 **Tasks:**

1. Extract the names only.
2. Extract names and grades.
3. Show only the emails (without headers).

---

### 🧩 **Activity 2 — Combine Commands**

Extract the **usernames** of logged-in users (skip header):

```bash
who | cut -d' ' -f1 | sort | uniq
```

---

### 🧩 **Activity 3 — Challenge**

Create a one-liner that prints only the **process names** from `ps aux` (skip headers).

💡 *Hint:* use a combination of `awk '{print $11}'` or try `cut -d' ' -f11` (but watch for extra spaces!).

---

## ✅ **Quick Summary Table**

| Option           | Description            | Example            |          |
| ---------------- | ---------------------- | ------------------ | -------- |
| `-d`             | Specify delimiter      | `-d','`            |          |
| `-f`             | Choose field(s)        | `-f1,3`            |          |
| `-c`             | Choose character range | `-c1-10`           |          |
| `--complement`   | Invert selection       | `--complement -f1` |          |
| Works with pipes | Filter text            | `cat file          | cut ...` |

---

Would you like me to add a **Mermaid flowchart** showing how `cut` processes input text (line → delimiter split → field extraction → output)? It’s a nice visual aid for learners.
