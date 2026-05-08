# 🧑‍💻 Bash Scripting Exercise Series (Beginner → Advanced)

***

## Exercise 1: Your First Script – System Info Reporter

**Difficulty:** Beginner

### 🎯 Learning Objectives

*   Create and run bash scripts
*   Use variables
*   Capture command output
*   Print formatted text

### 📘 Background / Context

A bash script is just a file containing commands. You can store command output into **variables** using `$()` and print using `echo`.

***

### 📝 Instructions

1.  Create a script file:

```bash
nano sysinfo.sh
```
2. Write code in your script to get the expected output

### ✅ Expected Output

    System Report
    -------------
    Hostname: ip-172-31-...
    Date: Fri May ...
    Uptime: up 2 hours, 15 minutes

***

### 🚀 Stretch Goal

Add:

*   Disk usage 
*   Memory usage 

***

## Exercise 2: File Organizer Script

**Difficulty:** Beginner → Intermediate

### 🎯 Learning Objectives

*   Conditionals (`if`)
*   File tests (`-f`, `-d`)
*   Basic scripting logic

### 📘 Background

Bash lets you check file types using test conditions. Useful for organizing files.

***

### 📝 Instructions

1.  Create a test directory structure with folders named text, logs, images, and scripts. create files in your home directory with extensions such as .txt, .log, .jpg, and .sh


2.  Create a script:

```bash
nano organizer.sh
```

3.  Add code to look at file types and move them into folders:

### ✅ Expected Output

Directories:

    text/
     - file1.txt
     - file2.txt
    logs/
     - sys.log
    images/
     - lion.jpg
    scripts/
     - calculator.sh

***

### 🚀 Stretch Goal

Handle unknown file types → move to `others/`

***

## Exercise 3: Log Analyzer with Loops

**Difficulty:** Intermediate

### 🎯 Learning Objectives

*   `for` and `while` loops
*   Parsing files
*   Using `grep`, `wc`

### 📘 Background

Logs are critical in real systems. You'll practice text parsing using command pipelines.

***

### 📝 Instructions

1.  Create a sample log:

```bash
nano app.log
```

Paste:

    INFO User login
    ERROR Database failed
    INFO User logout
    ERROR Timeout occurred

2.  Create script:

```bash
nano log_analyzer.sh
```

3.  Add code to the file to create the expected output:


### ✅ Expected Output

    Errors: 2
    Info messages: 2

***

### 🚀 Stretch Goal

Show the **actual lines** containing errors:

***

## Exercise 4: Backup Script with Functions

**Difficulty:** Intermediate

### 🎯 Learning Objectives

*   Functions
*   Arguments
*   File archiving (`tar`)

### 📘 Background

Functions allow reusable blocks of logic. Backups are a real-world automation task.

***

### 📝 Instructions

1.  Create a directory:

```bash
mkdir ~/data
touch ~/data/file{1..3}.txt
```

2.  Create script:

```bash
nano backup.sh
```

3.  Add code that will backup files to a backup folder:


### ✅ Expected Output

A `.tar.gz` file created in:

    ~/backups/

***

### 🚀 Stretch Goal

Add automatic cleanup:

*   Delete backups older than 7 days:


***

## Exercise 5: Process Monitor Script

**Difficulty:** Intermediate → Advanced

### 🎯 Learning Objectives

*   Process inspection (`ps`, `pgrep`)
*   Conditionals
*   Infinite loops

### 📘 Background

System monitoring is essential for production systems.

***

### 📝 Instructions

1.  Create script:

```bash
nano monitor.sh
```

2.  Add code to monitor a process and let you know if it is running or not:


### ✅ Expected Output

Every 10 seconds:

    Fri May ... nginx is running

***

### 🚀 Stretch Goal

Automatically restart the process if not running:

```bash
sudo systemctl start nginx
```

***

## Exercise 6: Automate with Cron

**Difficulty:** Advanced

### 🎯 Learning Objectives

*   Cron scheduling
*   Automation mindset

### 📘 Background

Cron allows scripts to run automatically at scheduled intervals.

***

### 📝 Instructions

1.  Edit crontab:

```bash
crontab -e
```

2.  Add code that will backup files from a folder and write to a log file.  Write any errors to the same log file:


### ✅ Expected Output

*   Script runs every 5 minutes
*   Output written to:

<!---->

    backup.log

***

### 🚀 Stretch Goal

Send output only on errors:

***

