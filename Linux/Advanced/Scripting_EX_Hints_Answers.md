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

### 📝 Step-by-Step Instructions

1.  Create a script file:

```bash
nano sysinfo.sh
```

2.  Add the following:

```bash
#!/bin/bash

HOSTNAME=$(hostname)
DATE=$(date)
UPTIME=$(uptime -p)

echo "System Report"
echo "-------------"
echo "Hostname: $HOSTNAME"
echo "Date: $DATE"
echo "Uptime: $UPTIME"
```

3.  Save and exit (`CTRL+O`, `ENTER`, `CTRL+X`)

4.  Make the script executable:

```bash
chmod +x sysinfo.sh
```

5.  Run it:

```bash
./sysinfo.sh
```

***

### ✅ Expected Output

    System Report
    -------------
    Hostname: ip-172-31-...
    Date: Fri May ...
    Uptime: up 2 hours, 15 minutes

***

### 🚀 Stretch Goal

Add:

*   Disk usage (`df -h`)
*   Memory usage (`free -h`)

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

### 📝 Step-by-Step Instructions

1.  Create a test directory:

```bash
mkdir ~/file_test && cd ~/file_test
touch file1.txt file2.log image.jpg script.sh
```

2.  Create a script:

```bash
nano organizer.sh
```

3.  Add:

```bash
#!/bin/bash

for FILE in *; do
  if [[ -f "$FILE" ]]; then
    case "$FILE" in
      *.txt)
        mkdir -p text
        mv "$FILE" text/
        ;;
      *.log)
        mkdir -p logs
        mv "$FILE" logs/
        ;;
      *.jpg)
        mkdir -p images
        mv "$FILE" images/
        ;;
      *.sh)
        mkdir -p scripts
        mv "$FILE" scripts/
        ;;
    esac
  fi
done

echo "Files organized."
```

4.  Run:

```bash
chmod +x organizer.sh
./organizer.sh
```

***

### ✅ Expected Output

Directories:

    text/
    logs/
    images/
    scripts/

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

### 📝 Step-by-Step Instructions

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

3.  Add:

```bash
#!/bin/bash

LOGFILE="app.log"

ERROR_COUNT=$(grep -c "ERROR" "$LOGFILE")
INFO_COUNT=$(grep -c "INFO" "$LOGFILE")

echo "Log Summary"
echo "-----------"
echo "Errors: $ERROR_COUNT"
echo "Info messages: $INFO_COUNT"
```

4.  Run:

```bash
chmod +x log_analyzer.sh
./log_analyzer.sh
```

***

### ✅ Expected Output

    Errors: 2
    Info messages: 2

***

### 🚀 Stretch Goal

Show the **actual lines** containing errors:

```bash
grep "ERROR" app.log
```

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

### 📝 Step-by-Step Instructions

1.  Create a directory:

```bash
mkdir ~/data
touch ~/data/file{1..3}.txt
```

2.  Create script:

```bash
nano backup.sh
```

3.  Add:

```bash
#!/bin/bash

backup_dir="$HOME/backups"
source_dir="$1"

create_backup() {
  timestamp=$(date +"%Y%m%d_%H%M%S")
  backup_file="$backup_dir/backup_$timestamp.tar.gz"

  mkdir -p "$backup_dir"
  tar -czf "$backup_file" "$source_dir"

  echo "Backup created: $backup_file"
}

if [[ -d "$source_dir" ]]; then
  create_backup
else
  echo "Error: Directory not found."
  exit 1
fi
```

4.  Run:

```bash
chmod +x backup.sh
./backup.sh ~/data
```

***

### ✅ Expected Output

A `.tar.gz` file created in:

    ~/backups/

***

### 🚀 Stretch Goal

Add automatic cleanup:

*   Delete backups older than 7 days:

```bash
find "$backup_dir" -type f -mtime +7 -delete
```

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

### 📝 Step-by-Step Instructions

1.  Create script:

```bash
nano monitor.sh
```

2.  Add:

```bash
#!/bin/bash

PROCESS_NAME="nginx"

while true; do
  if pgrep "$PROCESS_NAME" > /dev/null; then
    echo "$(date): $PROCESS_NAME is running"
  else
    echo "$(date): $PROCESS_NAME is NOT running"
  fi
  sleep 10
done
```

3.  Run:

```bash
chmod +x monitor.sh
./monitor.sh
```

***

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

### 📝 Step-by-Step Instructions

1.  Edit crontab:

```bash
crontab -e
```

2.  Add:

```bash
*/5 * * * * /home/ec2-user/backup.sh /home/ec2-user/data >> /home/ec2-user/backup.log 2>&1
```

3.  Save and exit

***

### ✅ Expected Output

*   Script runs every 5 minutes
*   Output written to:

<!---->

    backup.log

***

### 🚀 Stretch Goal

Send output only on errors:

```bash
2>> error.log
```

***

## Exercise 7: Robust Script with Error Handling

**Difficulty:** Advanced

### 🎯 Learning Objectives

*   Exit codes
*   Error handling (`set -e`, `trap`)
*   Defensive scripting

***

### 📘 Background

Professional scripts must handle failure cases gracefully.

***

### 📝 Step-by-Step Instructions

1.  Create script:

```bash
nano safe_backup.sh
```

2.  Add:

```bash
#!/bin/bash

set -e

trap 'echo "An error occurred. Exiting."' ERR

SOURCE="$1"
DEST="$HOME/backups"

if [[ -z "$SOURCE" ]]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

if [[ ! -d "$SOURCE" ]]; then
  echo "Directory does not exist!"
  exit 1
fi

mkdir -p "$DEST"

tar -czf "$DEST/backup_$(date +%F).tar.gz" "$SOURCE"

echo "Backup successful."
```

***

### ✅ Expected Output

*   Works normally when valid directory is provided
*   Shows error message if input is missing/wrong

***

### 🚀 Stretch Goal

*   Log all errors to a file

```bash
exec 2>>error.log
```

***
