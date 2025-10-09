## 🟢 **Beginner Projects (Core Bash Skills)**

Focus: commands, variables, input/output, loops, and conditionals.

| # | Project                  | Description                                             | Key Skills                         |
| - | ------------------------ | ------------------------------------------------------- | ---------------------------------- |
| 1 | **Hello User Script**    | Greet the current user and show the system date/time.   | Variables, `echo`, `date`, `$USER` |
| 2 | **System Info Reporter** | Display hostname, uptime, memory, and disk usage.       | `df`, `free`, `uptime`, formatting |
| 3 | **Simple Calculator**    | Read two numbers and perform +, -, *, / operations.     | `read`, arithmetic, `bc`           |
| 4 | **File Counter**         | Count how many `.txt` files are in a directory.         | Loops, `find`, `wc`                |
| 5 | **Backup Script**        | Copy files to a backup folder and timestamp them.       | `cp`, `mkdir`, `date`              |
| 6 | **Log Cleaner**          | Archive or delete logs older than X days.               | `find`, `tar`, `rm`, conditionals  |
| 7 | **User Greeter**         | Print a different message depending on the time of day. | `date +%H`, `if/else`              |

🧩 *Extension idea:* Schedule the backup or log cleaner with **cron**.

---

## 🟡 **Intermediate Projects (Automation & System Admin)**

Focus: loops, conditions, functions, file parsing, cron jobs.

| #  | Project                  | Description                                                                    | Key Skills                        |
| -- | ------------------------ | ------------------------------------------------------------------------------ | --------------------------------- |
| 8  | **Disk Space Monitor**   | Alert when disk usage passes a threshold.                                      | `df`, `awk`, comparisons, logging |
| 9  | **User Account Manager** | Create, disable, and delete Linux users interactively.                         | `useradd`, `usermod`, `userdel`   |
| 10 | **Network Checker**      | Ping a list of servers and log which ones are up/down.                         | `ping`, `for` loops, `grep`       |
| 11 | **Service Monitor**      | Check if critical services (e.g., nginx, sshd) are running and restart if not. | `systemctl`, `grep`, email alert  |
| 12 | **File Organizer**       | Automatically move images, docs, and videos into folders.                      | `mv`, wildcards, `case`           |
| 13 | **Process Logger**       | Save running processes (`ps aux`) to a daily log.                              | `ps`, `awk`, redirection          |
| 14 | **Simple To-Do CLI App** | Add, list, and delete tasks stored in a text file.                             | `case`, file I/O, `grep`, `sed`   |

🧩 *Extension idea:* Add command-line arguments for `--add`, `--list`, and `--delete`.

---

## 🔵 **Advanced Projects (DevOps / Cloud / Security Focus)**

Focus: automation, parsing, monitoring, error handling, APIs, or system orchestration.

| #  | Project                     | Description                                                                             | Key Skills                            |
| -- | --------------------------- | --------------------------------------------------------------------------------------- | ------------------------------------- |
| 15 | **Server Health Dashboard** | Collect and summarize system metrics (CPU, RAM, Disk) in a report.                      | `top`, `free`, `awk`, `tee`, cron     |
| 16 | **Automated Backup to S3**  | Compress and upload backups to AWS S3.                                                  | `tar`, AWS CLI, cron, error handling  |
| 17 | **Log Analyzer**            | Parse `/var/log/auth.log` or `/var/log/syslog` for login failures and summarize counts. | `grep`, `awk`, regular expressions    |
| 18 | **Website Uptime Checker**  | Curl multiple websites and send alerts for downtime.                                    | `curl`, loops, exit codes, email      |
| 19 | **Package Updater**         | Automatically update installed packages and log results.                                | `apt`, `yum`, redirection, scheduling |
| 20 | **EC2 Instance Inventory**  | List all EC2 instances and save metadata using AWS CLI.                                 | AWS CLI, JSON parsing, `jq`           |
| 21 | **Firewall Rule Auditor**   | List iptables rules and detect missing security ports.                                  | `iptables`, `grep`, conditionals      |
| 22 | **Config File Watcher**     | Detect changes in `/etc` config files and log differences.                              | `diff`, `inotifywait`, backup logic   |

🧩 *Extension idea:* Integrate with Slack or email to send alerts when thresholds or events occur.

---

## 🧠 **Bonus: Creative or Fun Bash Projects**

| #  | Project                          | Description                                           |
| -- | -------------------------------- | ----------------------------------------------------- |
| 23 | **Bash Quiz Game**               | Ask random trivia questions and keep score.           |
| 24 | **Text-Based Adventure Game**    | Create a small story with choices and loops.          |
| 25 | **Motivational Quote Generator** | Display a random quote from a text file each login.   |
| 26 | **Weather CLI App**              | Fetch and display weather using a web API and `curl`. |
| 27 | **Password Generator**           | Randomly generate secure passwords.                   |
| 28 | **Pomodoro Timer**               | A timer script with `sleep` and countdown messages.   |
| 29 | **Hangman Game**               | Show spaces for available letters and ASCII art for displays   |
| 30 | **Encrypt/Decrypt Message App**               | Create app to encrypt/decrypt messages, logs, etc.   |



---

## 🧩 **Project Tips**

✅ Start small — even a script that automates 3 manual steps is valuable.
✅ Always include **logging** and **error checking** (`if [ $? -ne 0 ] ...`).
✅ Use **functions** and **case statements** to make scripts modular.
✅ Add **cron jobs** or **systemd timers** for recurring automation.
✅ Store configuration in a separate `.conf` file to make it reusable.

---
