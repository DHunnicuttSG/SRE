# Lab: EC2 Server Audit and Recovery

## Scenario

You are a newly hired Junior Linux Administrator supporting a web application hosted on an AWS EC2 Linux server.

The development team has finished building their application and is preparing for production deployment. Before the application can be approved for launch, your manager requires an audit of the server environment.

Your task is to organize application files, review logs, create backups, collect system information, secure sensitive data, and document your findings in a single report.

The report will be automatically graded, so follow all instructions carefully.

---

# Objectives

You must:

1. Create and organize an application workspace.
2. Populate application files with realistic content.
3. Review application logs and identify issues.
4. Create backups of important files.
5. Gather system information from the EC2 instance.
6. Secure sensitive user data.
7. Export your command history.
8. Produce a final server audit report.

---

# Part 1: Application Workspace Setup

Create a new application workspace named:

```text
~/company_app
```

Within this workspace, create an organized directory structure that includes locations for:

- Application logs
- Application configuration files
- Application data
- Application backups

Create the following files within the workspace:

```text
access.log
application.log
app.conf
users.txt
```

Populate each file with realistic sample content.

The file containing user information should reside in the application data area when your work is complete.

---

# Part 2: Log Investigation

Management suspects that application startup generated several issues.

Add the following log entries somewhere within your log files:

```text
INFO Application Starting
INFO Database Connection Established
WARNING Slow Response Detected
ERROR Database Timeout
ERROR Failed User Authentication
```

Review the log files and determine:

- The total number of ERROR entries
- The total number of WARNING entries

These values must be included in your final report.

---

# Part 3: Backup Validation

Before production deployment, all critical files must be backed up.

Create an appropriate backup location within the application workspace.

Copy the following into the backup area:

- Configuration files
- Log files

Your report must include the following statement:

```text
Backup Status: Complete
```

---

# Part 4: System Information Collection

Collect information directly from your EC2 instance and include it in the report.

## Host Information

Collect:

- Hostname
- Current date and time

## Storage Information

Collect:

- Available disk space
- Size of the application workspace

## Network Information

Collect:

- IP address information for the server

---

# Part 5: Secure Sensitive Data

The `users.txt` file contains sensitive user information and must be protected.

Configure permissions so that:

- The owner can read and modify the file
- Members of the owner's group can read the file
- Other users cannot access the file

Record the final permission value in your report.

Example:

```text
Users File Permissions: 640
```

---

# Part 6: Command History

Export your command history to a file named:

```text
~/history.txt
```

Determine the total number of entries contained in the file and include that value in your report.

---

# Final Deliverable

Create the following file in your home directory:

```text
~/server_audit_report.txt
```

The report must use the following format and section order.

```text
===== SERVER AUDIT REPORT =====

Hostname:
<Date and Time>

Application Directory:
<Path>

Error Count:
Warning Count:

Backup Status:

Users File Permissions:

Available Disk Space:

Application Size:

IP Address Information:

History Entries:

===== END REPORT =====
```

---

# Automated Assessment Script

Save the following script as:

```text
grade_server_audit.py
```

```python
#!/usr/bin/env python3

import os

score = 0
possible = 100

home = os.path.expanduser("~")
report = os.path.join(home, "server_audit_report.txt")

print("\n===== Linux Server Audit Assessment =====\n")

# --------------------------------------------------
# Report Exists
# --------------------------------------------------

if os.path.isfile(report):
    score += 20
    print("[PASS] Report file exists")
else:
    print("[FAIL] Report file missing")
    print(f"\nFinal Score: {score}/{possible}")
    exit()

with open(report, "r") as f:
    contents = f.read()

# --------------------------------------------------
# Required Report Sections
# --------------------------------------------------

required_sections = [
    "Hostname:",
    "Application Directory:",
    "Error Count:",
    "Warning Count:",
    "Backup Status:",
    "Users File Permissions:",
    "Available Disk Space:",
    "Application Size:",
    "IP Address Information:",
    "History Entries:"
]

section_points = 0

for section in required_sections:
    if section in contents:
        section_points += 3

score += section_points

print(f"[INFO] Report Sections: {section_points}/30")

# --------------------------------------------------
# Application Directory Verification
# --------------------------------------------------

app_dir = os.path.expanduser("~/company_app")

if os.path.isdir(app_dir):
    score += 10
    print("[PASS] Application directory found")
else:
    print("[FAIL] Application directory missing")

# --------------------------------------------------
# Users File Permission Check
# --------------------------------------------------

users_file = None

for root, dirs, files in os.walk(app_dir):
    if "users.txt" in files:
        users_file = os.path.join(root, "users.txt")
        break

if users_file:
    perms = oct(os.stat(users_file).st_mode)[-3:]

    if perms == "640":
        score += 15
        print("[PASS] users.txt permissions are correct")
    else:
        print(f"[FAIL] users.txt permissions are {perms}")
else:
    print("[FAIL] users.txt not found")

# --------------------------------------------------
# Backup Verification
# --------------------------------------------------

backup_found = False

for root, dirs, files in os.walk(app_dir):
    if "backup" in root.lower():
        backup_found = True
        break

if backup_found:
    score += 15
    print("[PASS] Backup directory found")
else:
    print("[FAIL] Backup directory missing")

# --------------------------------------------------
# History Verification
# --------------------------------------------------

history_file = os.path.join(home, "history.txt")

if os.path.isfile(history_file):
    score += 10
    print("[PASS] History file exported")
else:
    print("[FAIL] History file missing")

# --------------------------------------------------
# Final Score
# --------------------------------------------------

print("\n================================")
print(f"Final Score: {score}/{possible}")
print("================================")
```

---

# Success Criteria

A successful submission will include:

- A correctly organized application workspace.
- Log files containing the required entries.
- A backup location containing copies of required files.
- Properly secured user data.
- An exported command history file.
- A completed audit report named `server_audit_report.txt`.
- A report containing all required sections and information.

Your final score will be determined by the automated assessment script.