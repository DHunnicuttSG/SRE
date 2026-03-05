# **Linux Lesson: Using cron to Schedule a Shell Script Every Minute**

## **Overview**

In this lesson, you will learn how to:

1.  **Install `cron`** (or `cronie`, depending on distro)
2.  **Start and enable the cron service**
3.  **Create a shell script (`.sh`) that writes to a log file**
4.  **Schedule the script to run every minute using `crontab`**

***

# **1. Installing cron**

### **Debian/Ubuntu**

```bash
sudo apt update
sudo apt install cron
```

### **CentOS/RHEL/Fedora**

```bash
sudo dnf install cronie
```

To confirm cron is installed:

```bash
crontab -V
```

***

# **2. Starting and Enabling the cron Service**

### **Debian/Ubuntu**

```bash
sudo systemctl start cron
sudo systemctl enable cron
```

### **CentOS/RHEL/Fedora**

```bash
sudo systemctl start crond
sudo systemctl enable crond
```

Check service status:

```bash
systemctl status cron    # Debian/Ubuntu
systemctl status crond   # CentOS/RHEL/Fedora
```

***

# **3. Creating the Shell Script**

1.  Create a script file:

```bash
nano ~/log_update.sh
```

2.  Add the following code:

```bash
#!/bin/bash
echo "Log updated at $(date)" >> ~/cron_log.txt
```

3.  Save and exit (`CTRL + O`, `ENTER`, then `CTRL + X`).

4.  Make the script executable:

```bash
chmod +x ~/log_update.sh
```

***

# **4. Scheduling the Script with cron**

Open the user’s crontab:

```bash
crontab -e
```

Add the following line to run the script *every minute*:

```bash
* * * * * /home/$USER/log_update.sh
```

Save and exit the editor.

***

# **5. Verifying the cron Job Is Running**

Wait 1–2 minutes, then check the log file:

```bash
cat ~/cron_log.txt
```

You should see timestamp entries such as:

    Log updated at Thu Mar 5 15:42:01 CST 2026
    Log updated at Thu Mar 5 15:43:01 CST 2026

***

# **6. Troubleshooting Tips**

### **Check cron logs**

Ubuntu/Debian:

```bash
grep CRON /var/log/syslog
```

CentOS/RHEL/Fedora:

```bash
sudo journalctl -u crond --since "5 minutes ago"
```

### **Check environment paths**

Cron runs with a minimal PATH.  
If your script uses commands that need full paths, specify them (e.g., `/usr/bin/date`).

***
