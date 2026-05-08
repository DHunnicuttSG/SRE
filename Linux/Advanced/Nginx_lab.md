# 🧪 Nginx Hands-On Lab: Deploy, Customize, and Monitor a Web Server

**Skill Level:** Beginner → Intermediate\
**Estimated Time:** 60–90 minutes

***

# 🎯 Learning Objectives

By the end of this lab, you will:

*   Install and manage Nginx as a service
*   Serve a custom web page
*   Modify configuration files
*   Understand basic web server behavior
*   Use logs to troubleshoot
*   Connect this with process monitoring and bash skills

***

# 🧰 Lab Setup Requirements

*   AWS EC2 Linux instance (Amazon Linux or Ubuntu)
*   Security group allows:
    *   **HTTP (port 80)**

***

# 🔧 Part 1: Install and Start Nginx

### Step 1: Install Nginx

**Amazon Linux:**

```bash
sudo yum install nginx -y
```

**Ubuntu:**

```bash
sudo apt install nginx -y
```

***

### Step 2: Start the service

```bash
sudo systemctl start nginx
```

***

### Step 3: Enable at boot

```bash
sudo systemctl enable nginx
```

***

### Step 4: Verify status

```bash
systemctl status nginx
```

✅ You should see:

    active (running)

***

### ✅ Success Check

Open a browser and visit:

    http://<your-ec2-public-ip>

You should see the **Nginx welcome page**

***

# 🌐 Part 2: Serve a Custom Web Page

### Step 1: Navigate to web root

```bash
cd /usr/share/nginx/html
```

***

### Step 2: Edit the default page

```bash
sudo nano index.html
```

Replace contents with:



***

### Step 3: Save and refresh browser

✅ You should see your custom message

***

### ✅ Success Criteria

Your custom text appears in your browser

***

# ⚙️ Part 3: Explore Nginx Configuration

### Step 1: Open config file

```bash
sudo nano /etc/nginx/nginx.conf
```

***

### Step 2: Identify key sections

Look for:

*   `worker_processes`
*   `http { ... }`
*   `server { ... }`

***

### Step 3: Test config

```bash
sudo nginx -t
```

✅ Output:

    syntax is ok
    test is successful

***

# 🔄 Part 4: Restart and Reload

### Restart Nginx

```bash
sudo systemctl restart nginx
```

### Reload (no downtime)

```bash
sudo systemctl reload nginx
```

***

### ✅ Success Criteria

No errors when restarting or reloading

***

# 📜 Part 5: View Logs (Critical Skill)

### Access logs

```bash
sudo journalctl -u nginx -n 20
```

***

### Access error log file

```bash
sudo cat /var/log/nginx/error.log
```

***

### Access access log

```bash
sudo cat /var/log/nginx/access.log
```

***

### ✅ Success Criteria

You can see:

*   Incoming requests
*   Any errors

***

# 🧪 Part 6: Break and Fix Nginx (Best Learning Step)

### Step 1: Introduce an error

```bash
sudo nano /etc/nginx/nginx.conf
```

Add a random typo (example):

    bad_directive;

***

### Step 2: Test config

```bash
sudo nginx -t
```

❌ You should see an error

***

### Step 3: Fix the file

Remove the bad line

Run:

```bash
sudo nginx -t
```

✅ Should pass now

***

### ✅ Learning Outcome

*   You now know how to debug config issues

***

# 🔄 Part 7: Combine with Bash (Mini Automation)

### Create a monitoring script

```bash
nano nginx_check.sh
```

Add:

```bash
#!/bin/bash

if systemctl is-active --quiet nginx; then
  echo "$(date): Nginx is running"
else
  echo "$(date): Nginx is NOT running - restarting"
  sudo systemctl start nginx
fi
```

***

### Run it:

```bash
chmod +x nginx_check.sh
./nginx_check.sh
```

***

### ✅ Success Criteria

*   Script reports status
*   Starts nginx if stopped

***

# ⏰ Part 8: Automate with Cron

### Edit crontab

```bash
crontab -e
```

Add:

```bash
*/5 * * * * /home/ec2-user/nginx_check.sh >> /home/ec2-user/nginx.log 2>&1
```

***

### ✅ Success Criteria

*   Script runs every 5 minutes
*   Log file is updated

***

# 🚀 Stretch Challenges (Great for Advanced Students)

### 🔹 1. Create a second website (virtual host)

*   Serve different content on another port

***

### 🔹 2. Restrict access by IP

Block all but your IP in config

***

### 🔹 3. Create a "maintenance mode" script

*   Replace webpage temporarily with “Maintenance” message

***

### 🔹 4. Analyze logs with bash

Count total visitors:

```bash
grep -c "GET" /var/log/nginx/access.log
```

***

### 🔹 5. Alert on failure

Modify script:

*   Write to a separate error log
*   Send message when nginx stops

***

# 🧭 Instructor Notes (Optional Use)

This lab ties directly to:

*   Bash (automation)
*   Processes (`systemctl`)
*   Logs (`journalctl`, file logs)
*   Real-world DevOps workflows

***

# ✅ Final Outcome

By the end, students will have:

*   A running web server
*   Hands-on config experience
*   Debugging skills
*   Automation using bash + cron

