## 🧩 **1️⃣ What `$` Means in Bash**

In Linux shells (like **bash**, **zsh**, etc.), the **`$`** symbol is used to **reference** or **expand** the *value* of a variable or command.

Think of it like saying:

> “Give me what’s *inside* this variable or command.”

---

## 🧠 **2️⃣ Creating and Using Variables**

### **Define a variable (no `$` when assigning)**

```bash
name="David"
age=30
```

> ❗ No spaces around `=` or it will cause an error.

---

### **Access the variable (use `$`)**

```bash
echo $name
echo $age
```

Output:

```
David
30
```

✅ The `$` tells the shell to *expand* the variable’s value.

---

### **You can also use braces for clarity**

```bash
echo "My name is ${name} and I am ${age} years old."
```

Braces `{}` are optional, but **help separate variable names** from other text:

```bash
echo "$name123"        # looks for variable "name123"
echo "${name}123"      # prints "David123"
```

---

## 🧮 **3️⃣ Variables in Arithmetic**

You can use `$(( ))` for math:

```bash
a=5
b=3
total=$((a + b))
echo $total
```

Output:

```
8
```

✅ The `$(( ))` syntax expands to the result of the arithmetic operation.

---

## ⚙️ **4️⃣ Command Substitution (Using `$()` or Backticks)**

You can store the *output of a command* into a variable:

```bash
current_date=$(date)
echo $current_date
```

Output:

```
Mon Oct  6 07:34:00 UTC 2025
```

> `$()` runs the command inside the parentheses and substitutes its output.

Example:

```bash
user_count=$(who | wc -l)
echo "There are $user_count users logged in."
```

---

## 🧾 **5️⃣ Environment Variables**

System-wide or session variables often start with `$`, e.g.:

| Variable | Description                               |
| -------- | ----------------------------------------- |
| `$USER`  | Current logged-in username                |
| `$HOME`  | User’s home directory                     |
| `$PWD`   | Current working directory                 |
| `$SHELL` | The shell being used                      |
| `$PATH`  | List of directories for executable lookup |

Example:

```bash
echo "You are $USER and your home directory is $HOME"
```

---

## 🧰 **6️⃣ Exporting Variables (for other scripts)**

If you want your variable to be available to **child processes**, you need to export it:

```bash
export TOKEN="abcd1234"
```

Now other scripts or commands can access `$TOKEN`.

---

## 💡 **7️⃣ Example Script: Using `$` in Action**

```bash
#!/bin/bash
# demo_variables.sh

name="Alice"
today=$(date +%A)
greeting="Hello $name! Today is $today."

echo $greeting
```

Run:

```bash
chmod +x demo_variables.sh
./demo_variables.sh
```

Output:

```
Hello Alice! Today is Monday.
```

---

## ✅ **Summary Table**

| Usage                  | Example      | Meaning                                |
| ---------------------- | ------------ | -------------------------------------- |
| `$var`                 | `$name`      | Get value of variable                  |
| `${var}`               | `${name}`    | Safe variable expansion                |
| `$((…))`               | `$((a + b))` | Arithmetic expansion                   |
| `$(…)`                 | `$(date)`    | Command substitution                   |
| `$#`                   | `$#`         | Number of arguments to a script        |
| `$1`, `$2`, etc.       | `$1`         | Positional parameters (1st, 2nd, etc.) |
| `$?`                   | `$?`         | Exit status of last command            |
| `$$`                   | `$$`         | Current process ID                     |
| `$USER`, `$HOME`, etc. | System vars  | Environment variables                  |

---

