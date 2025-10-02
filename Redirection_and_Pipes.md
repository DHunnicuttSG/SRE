# **Course Content: Redirection and Pipes in Linux**

---

## **1. Learning Objectives**

By the end of this lesson, students will be able to:

* Understand **output redirection** (`>`, `>>`, `>>>`) and how to write/append to files.
* Understand **input redirection** (`<`, `<<`, `<<<`) and how to feed input into commands.
* Use the pipe operator `|` to chain commands together.
* Apply redirection in real-world command-line tasks.

---

## **2. Output Redirection Operators**

These control where **command output** goes.

### **`>` (Overwrite Output)**

* Redirects stdout to a file (overwrites).

```bash
echo "Hello" > file.txt
```

👉 `file.txt` now contains only `"Hello"`.

---

### **`>>` (Append Output)**

* Appends stdout to the file instead of overwriting.

```bash
echo "World" >> file.txt
```

👉 Adds `"World"` to the end of `file.txt`.

---

### **`>>>` (Bash-Specific String Redirect)**

* Like `>`, but ensures the input is treated as a **string literal**.

```bash
echo foo >>> file.txt
```

👉 Writes `foo` safely into `file.txt`.

* Rarely used, but prevents word-splitting/globbing issues in scripts.

---

## **3. Input Redirection Operators**

These control where a **command gets its input** from.

### **`<` (Redirect Input from File)**

* Reads input for a command from a file instead of the keyboard.

```bash
sort < file.txt
```

👉 Feeds the contents of `file.txt` into `sort`.

---

### **`<<` (Here Document)**

* Lets you **feed multiple lines of input directly into a command** until a delimiter is reached.

```bash
cat << EOF
Line 1
Line 2
EOF
```

👉 `cat` receives two lines of input (`Line 1`, `Line 2`).

* Common in scripts for providing input blocks.

---

### **`<<<` (Here String)**

* Feeds a **single string** as input to a command.

```bash
grep "foo" <<< "foo bar baz"
```

👉 Passes `"foo bar baz"` as input to `grep`.

---

## **4. The Pipe Operator `|`**

* Sends the **output of one command as input** to another.

```bash
ls | grep ".txt"
```

👉 Filters `ls` output for `.txt` files.

---

## **5. Summary Table**

| Operator | Type   | Meaning                             | Example                               | Result                        |           |                           |
| -------- | ------ | ----------------------------------- | ------------------------------------- | ----------------------------- | --------- | ------------------------- |
| `>`      | Output | Overwrite file with command output  | `echo "Hi" > file.txt`                | File contains `"Hi"`          |           |                           |
| `>>`     | Output | Append output to file               | `echo "Bye" >> file.txt`              | File adds `"Bye"`             |           |                           |
| `>>>`    | Output | Bash string redirect (safe literal) | `echo foo >>> file.txt`               | File contains `"foo"`         |           |                           |
| `<`      | Input  | Redirect input from file            | `sort < names.txt`                    | Sorts contents of file        |           |                           |
| `<<`     | Input  | Here Document (multi-line input)    | `cat << EOF`                          | Feeds lines until `EOF`       |           |                           |
| `<<<`    | Input  | Here String (single string input)   | `grep "abc" <<< "abc def"`            | Feeds `"abc def"` into `grep` |           |                           |
| `        | `      | Pipe                                | Send output of one command to another | `ps aux                       | grep ssh` | Filters running processes |

---

## **6. Practice Exercises**

1. Use `>` to create a file `hello.txt` containing `"Hello Linux"`.
2. Use `>>` to append `"Learning redirection"` to `hello.txt`.
3. Use `<` to sort the contents of `/etc/passwd` by username.
4. Write a `cat << EOF` command that prints 3 custom lines of text.
5. Use `<<<` to pass the string `"quick brown fox"` into `wc -w` (count words).
6. Combine `|` and redirection: Count how many `.conf` files are in `/etc`:

   ```bash
   ls /etc | grep ".conf" | wc -l
   ```

---
