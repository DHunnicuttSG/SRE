# 🧩 **How to Write Bash Scripts in Linux**

---

## 🧠 **What Is a Bash Script?**

A **Bash script** is simply a text file that contains a sequence of **commands** you’d normally type in the terminal — saved so they can be run automatically.

You can think of it as a **recipe** for Linux to follow.

---

# ⚙️ **1️⃣ Create a Script File**

Create a file named `myscript.sh`:

```bash
nano myscript.sh
```

---

# 🧾 **2️⃣ Add the Shebang Line**

The **first line** of any Bash script should tell Linux which interpreter to use:

```bash
#!/bin/bash
```

This is called the **shebang** (#!).
It tells the system: “Run this file using the Bash shell.”

---

# 🪶 **3️⃣ Add Commands**

Example:

```bash
#!/bin/bash
# My first Bash script

echo "Hello, World!"
echo "Today’s date is: $(date)"
echo "You are logged in as: $USER"
echo "Your current directory is: $(pwd)"
```

---

# 🔒 **4️⃣ Make It Executable**

Before you can run your script:

```bash
chmod +x myscript.sh
```

This gives the file **execute permission**.

---

# 🚀 **5️⃣ Run Your Script**

Run it in one of two ways:

**Option 1:**

```bash
./myscript.sh
```

**Option 2 (no execute bit needed):**

```bash
bash myscript.sh
```

---

# 🧩 **6️⃣ Use Variables**

You can store and use variables inside your script.

Example:

```bash
#!/bin/bash

name="David"
greeting="Hello, $name!"
echo $greeting
```

Output:

```
Hello, David!
```

---

# 🧮 **7️⃣ Use Command Substitution**

Command substitution lets you run a command and use its output in a variable:

```bash
#!/bin/bash

current_date=$(date)
echo "Script ran on: $current_date"
```

---

# 🧠 **8️⃣ Use Conditional Statements (if / else)**

```bash
#!/bin/bash

echo "Enter a number:"
read num

if [ $num -gt 10 ]; then
  echo "That’s greater than 10"
else
  echo "That’s 10 or less"
fi
```

---

# 🔁 **9️⃣ Use Loops**

### **For Loop**

```bash
#!/bin/bash

for i in 1 2 3 4 5
do
  echo "Number: $i"
done
```

### **While Loop**

```bash
#!/bin/bash

count=1
while [ $count -le 5 ]
do
  echo "Loop $count"
  ((count++))
done
```

---

# 🧩 **🔟 Pass Arguments to Your Script**

When you run a script, you can pass **arguments** like this:

```bash
./myscript.sh hello world
```

Inside the script:

```bash
#!/bin/bash

echo "First argument: $1"
echo "Second argument: $2"
echo "Total arguments: $#"
```

Output:

```
First argument: hello
Second argument: world
Total arguments: 2
```

---

# 🧰 **11️⃣ Write Functions**

Functions make scripts modular and reusable:

```bash
#!/bin/bash

say_hello() {
  echo "Hello, $1!"
}

say_hello "David"
say_hello "Linux Learner"
```

---

# 📜 **12️⃣ Logging Output**

Redirect output to a log file:

```bash
#!/bin/bash

echo "Starting script..." >> script.log
date >> script.log
echo "Done!" >> script.log
```

---

# 🧩 **13️⃣ Common Operators and Syntax**

| Type        | Operator | Example             | Meaning             |
| ----------- | -------- | ------------------- | ------------------- |
| Comparison  | `-eq`    | `[ $a -eq $b ]`     | Equal               |
| Comparison  | `-gt`    | `[ $a -gt $b ]`     | Greater than        |
| String      | `=`      | `[ "$a" = "$b" ]`   | Strings are equal   |
| File exists | `-e`     | `[ -e file.txt ]`   | File exists         |
| Directory   | `-d`     | `[ -d /tmp ]`       | Is a directory      |
| Negation    | `!`      | `[ ! -f file.txt ]` | File does not exist |

---

# 🧪 **14️⃣ Example Script — System Info**

```bash
#!/bin/bash
# Display system information

echo "System Information for $(hostname)"
echo "-----------------------------------"
echo "Date: $(date)"
echo "Uptime: $(uptime -p)"
echo "Disk Usage:"
df -h | grep -v tmpfs
```

Run it:

```bash
./myscript.sh
```

---

# 🧠 **15️⃣ Troubleshooting**

| Issue                        | Fix                                                                  |
| ---------------------------- | -------------------------------------------------------------------- |
| `Permission denied`          | Run `chmod +x script.sh`                                             |
| `Command not found`          | Make sure the command exists and PATH is set                         |
| `Syntax error`               | Check for missing spaces in `[ ]`, missing quotes, or unclosed loops |
| Script doesn’t run with cron | Use absolute paths for commands (e.g. `/usr/bin/df`)                 |

---

# 🧩 **Classroom Practice Activities**

1. **Hello Script** — Print a greeting with your name and date.
2. **Calculator Script** — Read two numbers and add/subtract them.
3. **Backup Script** — Copy files from one directory to another and log the action.
4. **Monitor Script** — Print system uptime and save it to a log every minute using cron.
5. **Loop Challenge** — Write a loop that prints numbers 1–20 but skips 10.

---
