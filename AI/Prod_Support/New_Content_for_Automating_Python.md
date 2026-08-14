# Python Automation for Production Support: Course Topics & Examples

These topics are commonly found in **Python Automation for Production Support, SRE, DevOps, and System Administration** courses. The emphasis is on automating repetitive operational tasks rather than developing full-scale software applications.

---

# 1. Working with Files & Directories in Python

## Concepts
- Reading files
- Writing files
- Creating directories
- Moving, copying, and deleting files
- Traversing folder structures

## Example Exercise

```python
from pathlib import Path

log_dir = Path("/var/log")

for file in log_dir.glob("*.log"):
    print(file.name)
```

*# Real-World Tasks
- Archive log f*les older than 30 days
- Move comp*eted reports to archive folders
- *enerate file inventory reports

--*

# 2. Reading & Parsing Log Files*
## Concepts
- Open large log file*
- Search for errors
- Extract tim*stamps
- Count occurrences

## Exa*ple Exercise

```python
with open(*application.log") as log:
    for *ine in log:
        if "ERROR" in *ine:
            print(line)
```

*# Real-World Tasks
- Find failed l*gin attempts
- Generate daily erro* reports
- Identify application ou*ages

---

# 3. Running System Com*ands from Python

## Concepts
- Ex*cute Linux commands
- Capture comm*nd output
- Process command result*

## Example Exercise

```python
i*port subprocess

result = subproce*s.run(
    ["df", "-h"],
    captu*e_output=True,
    text=True
)

pr*nt(result.stdout)
```

## Real-Wor*d Tasks
- Check disk utilization
-*Restart services
- Gather server h*alth information

---

# 4. Workin* with Environment Variables

## Co*cepts
- Reading environment settin*s
- Storing credentials securely
-*Configuring applications

## Examp*e Exercise

```python
import os

a*i_key = os.getenv("API_KEY")
print*api_key)
```

## Real-World Tasks
* Store API tokens
- Configure envi*onments
- Separate development and*production settings

---

# 5. Fil* & Directory Watching (Automation)*
## Concepts
- Monitor directories*- Trigger actions when files appea*
- Build automation workflows

## *xample Exercise

```python
from wa*chdog.observers import Observer
fr*m watchdog.events import FileSyste*EventHandler
```

## Real-World Ta*ks
- Process files uploaded by use*s
- Automatically import reports
-*Trigger ETL jobs

---

# 6. Workin* with JSON & YAML (Configuration F*les)

## Concepts
- Read configura*ion files
- Modify settings
- Crea*e configuration templates

## Exam*le JSON

```json
{
  "server": "pr*duction",
  "port": 443
}
```

## *ython Example

```python
import js*n

with open("config.json") as f:
*   config = json.load(f)

print(co*fig["server"])
```

## Real-World *asks
- Kubernetes manifests
- Appl*cation settings
- CI/CD configurat*ons

---

# 7. Automating Network *asks

## Concepts
- Ping hosts
- C*eck ports
- Query DNS
- SSH automa*ion

## Example Exercise

```pytho*
import socket

host = "google.com*

ip = socket.gethostbyname(host)
*print(ip)
```

## Real-World Tasks*- Server connectivity checks
- Net*ork diagnostics
- Automated VPN mo*itoring

---

# 8. Automating Serv*ce Management

## Concepts
- Start*services
- Stop services
- Restart*services
- Check service status

#* Example Exercise

```python
impor* subprocess

subprocess.run(
    ["systemctl", "status", "nginx"]
)
`*`

## Real-World Tasks
- Restart f*iled applications
- Verify service* after deployment
- Build automate* recovery scripts

---

# 9. Sched*ling Python Scripts (Cron & System*)

## Concepts
- Cron jobs
- Syste*d timers
- Scheduled automation ta*ks

## Example Cron Entry

```bash*0 * * * * /usr/bin/python3 healthc*eck.py
```

## Real-World Tasks
- *aily reports
- Server health check*
- Log archiving

---

# 10. Worki*g with Databases (Automation Loggi*g)

## Concepts
- Connect to datab*ses
- Insert records
- Query infor*ation
- Store automation results

*# Example Exercise

```python
impo*t sqlite3

conn = sqlite3.connect(*automation.db")

cursor = conn.cur*or()

cursor.execute("""
CREATE TA*LE IF NOT EXISTS runs(
    id INTE*ER PRIMARY KEY,
    status TEXT
)
*"")
```

## Real-World Tasks
- Sto*e script execution history
- Log i*cidents
- Track server metrics

--*

# 11. Sending Alerts & Notificat*ons

## Concepts
- Email alerts
- *icrosoft Teams notifications
- Sla*k messages
- SMS alerts

## Exampl* Exercise

```python
import smtpli*
```

## Real-World Scenarios

Whe*:
- Disk space exceeds 90%
- A ser*ice is down
- A backup job fails

*end:
- Email notification
- Micros*ft Teams webhook message
- Slack a*ert

---

# 12. Error Handling & L*gging in Python

## Concepts
- Exc*ption handling
- Retry logic
- App*ication logging

## Example Exerci*e

```python
import logging

loggi*g.basicConfig(
    filename="app.l*g",
    level=logging.INFO
)

try:*    x = 10 / 0
except Exception as*e:
    logging.error(e)
```

## Re*l-World Tasks
- Prevent script cra*hes
- Collect diagnostics
- Mainta*n audit trails

---

# 13. Python *or Automation: Production Support *cripts

Many courses culminate in *nd-to-end automation examples.

##*Example 1: Linux Health Check

Che*ks:
- CPU usage
- Memory utilizati*n
- Disk usage
- Service status

O*tputs:
- HTML report
- Email alert*
---

## Example 2: Log Monitoring*Tool

Reads:

```text
app.log
```
*Searches for:

```text
ERROR
FATAL*CRITICAL
```

Sends alerts when er*or thresholds are exceeded.

---

## Example 3: Automated Incident Response

### Workflow

```text
Service Down
      ↓
Detect Failure
      ↓
Restart Service
      ↓
Verify Recovery
      ↓
Log Result
      ↓
Send Notification
```

---

# 14. File and Log Processing Project

## Typical Capstone Workflow

1. Watch a directory
2. Detect an incoming log file
3. Parse the file
4. Extract errors
5. Save results to a database
6. Send a summary email

---

# 15. Interacting with REST APIs & Webhooks

## Concepts
- GET requests
- POST requests
- Authentication
- JSON processing

## Example Exercise

```python
import requests

response = requests.get(
    "https://jsonplaceholder.typicode.com/users"
)

print(response.json())
```

## Real-World Tasks

### ServiceNow Integration
- Create incidents automatically

### Jira Integration
- Open support tickets

### Microsoft Teams
- Send notifications via webhooks

### Cloud Platforms
- Azure API automation
- AWS API automation
- Google Cloud API automation

---

# Typical Final Project

A comprehensive final project for this type of course might be a **Production Support Automation Platform** that:

- Monitors application logs
- Checks server health
- Calls REST APIs
- Stores results in a database
- Sends Teams and email alerts
- Runs automatically via Cron or Systemd
- Produces daily operational reports

---

# Who Benefits from This Course?

This type of course is especially useful for:

- Production Support Engineers
- DevOps Engineers
- Site Reliability Engineers (SREs)
- Linux Administrators
- System Administrators
- IT Operations Teams
- Cloud Operations Engineers

These roles regularly automate operational tasks to improve reliability, reduce manual effort, and respond more quickly to production issues.