# ⏰ **Using `cron` and Scheduling Jobs on AWS**

---

## 🧩 **Overview**

AWS offers multiple ways to schedule and automate recurring tasks.
You can:

* Use the **Linux cron service** inside an **EC2 instance** (traditional method)
* Use **Amazon EventBridge (CloudWatch Events)** to schedule **serverless cron jobs**
* Use **ECS Scheduled Tasks** to run **containerized cron jobs**

---

## 🧠 **Option 1: Using Cron on an EC2 Instance (Linux Cron)**

This is the closest to a traditional Linux setup.
When you **SSH into your EC2 instance**, you can manage cron jobs just like on any other Linux server.

---

### 🧩 **1️⃣ Connect to EC2**

```bash
ssh -i my-key.pem ec2-user@<your-ec2-public-ip>
```

---

### 🧩 **2️⃣ Open the Crontab**

```bash
crontab -e
```

---
```bash
# ┌───────────── minute (0 - 59)
# │ ┌───────────── hour (0 - 23)
# │ │ ┌───────────── day of month (1 - 31)
# │ │ │ ┌───────────── month (1 - 12)
# │ │ │ │ ┌───────────── day of week (0 - 7) (Sunday = 0 or 7)
# │ │ │ │ │
# * * * * * command_to_execute
```
---

### 🧩 **3️⃣ Add Your Cron Job**

Example: Run a backup script every night at 2 AM

```bash
0 2 * * * /home/ec2-user/scripts/backup.sh >> /var/log/backup.log 2>&1
```

✅ **Explanation:**

* `0 2 * * *` → runs at 2:00 AM daily
* `>> /var/log/backup.log 2>&1` → logs both output and errors
* Always use **absolute paths** on AWS (e.g., `/usr/bin/python3`, `/home/ec2-user/...`)

---

### 🧩 **4️⃣ Check That `cron` Is Running**

Amazon Linux 2 uses `crond`:

```bash
sudo systemctl status crond
```

If it’s not running:

```bash
sudo systemctl start crond
sudo systemctl enable crond
```

---

### 🧩 **5️⃣ Verify Job Execution**

You can check logs:

```bash
grep CRON /var/log/cron
```

Or on Ubuntu-based EC2:

```bash
grep CRON /var/log/syslog
```

---

## ⚙️ **Example EC2 Cron Jobs**

| Goal                      | Schedule       | Command                                                           |
| ------------------------- | -------------- | ----------------------------------------------------------------- |
| Run a system update daily | 3 AM           | `0 3 * * * sudo yum update -y`                                    |
| Backup to S3              | Every 12 hours | `0 */12 * * * aws s3 sync /home/ec2-user/backups s3://my-bucket/` |
| Monitor disk usage        | Every hour     | `0 * * * * df -h >> /home/ec2-user/disk.log`                      |

💡 Make sure the EC2 instance has an **IAM role** attached with **S3 permissions** for any `aws` CLI operations.

---

## 🧰 **Tip: Use CloudWatch Logs for Persistent Logging**

To automatically push your script logs to **Amazon CloudWatch Logs**, use:

```bash
sudo yum install -y awslogs
sudo systemctl start awslogsd
sudo systemctl enable awslogsd
```

Then configure `/etc/awslogs/awslogs.conf` to include `/var/log/cron` or your custom log files.

---

## 🧠 **Option 2: Serverless Cron with AWS EventBridge (CloudWatch Events)**

Instead of running cron on an EC2 instance, you can use **EventBridge** to schedule serverless jobs — perfect when you want **zero maintenance**.

---

### 🧩 **1️⃣ Define a Schedule Expression**

EventBridge uses **cron syntax** similar to Linux but slightly modified:

```
cron(Minutes Hours Day-of-month Month Day-of-week Year)
```

Example: Run every day at 3 AM UTC

```
cron(0 3 * * ? *)
```

---

### 🧩 **2️⃣ Create an EventBridge Rule**

You can do this via the AWS Console or CLI.

**Using AWS CLI:**

```bash
aws events put-rule \
  --name DailyBackup \
  --schedule-expression "cron(0 3 * * ? *)" \
  --state ENABLED
```

---

### 🧩 **3️⃣ Target a Lambda Function or ECS Task**

Example: Run a Lambda backup function:

```bash
aws events put-targets \
  --rule DailyBackup \
  --targets "Id"="1","Arn"="arn:aws:lambda:us-east-1:123456789012:function:BackupToS3"
```

✅ This runs **serverlessly**, no EC2 needed — AWS handles the scheduling and execution.

---

## 🧠 **Option 3: Cron-Like Scheduling in ECS (Fargate or EC2)**

If your workloads run in containers, AWS lets you schedule **ECS tasks** with cron expressions through **EventBridge**.

Example: Run a container every 15 minutes:

```
cron(0/15 * * * ? *)
```

---

## 📚 **Comparison Table**

| Approach             | Environment       | Best For                          | Pros                             | Cons                             |
| -------------------- | ----------------- | --------------------------------- | -------------------------------- | -------------------------------- |
| EC2 Cron             | Traditional Linux | Simple scripts, custom automation | Familiar, flexible               | Must manage instance uptime      |
| EventBridge + Lambda | Serverless        | Lightweight jobs                  | Scales automatically, no servers | Limited execution time (≤15 min) |
| ECS Scheduled Task   | Containers        | App or batch jobs                 | Integrates with Docker images    | Requires ECS setup               |

---

## 🧪 **Classroom Activities**

### 🧩 **Activity 1: EC2 Cron Job**

* Launch a **t2.micro Amazon Linux 2** instance.
* Write a script that logs CPU usage every 10 minutes:

  ```bash
  top -b -n1 | head -5 >> /home/ec2-user/cpu.log
  ```
* Add it to crontab.
* Verify it’s running using `grep CRON /var/log/cron`.

---

### 🧩 **Activity 2: Serverless Schedule**

* Create a **Lambda** function that prints a message to CloudWatch Logs.
* Schedule it via **EventBridge** to run every 5 minutes.
* Verify execution in **CloudWatch Logs**.

---

### 🧩 **Activity 3: Backup to S3**

* On EC2, write a cron job to back up `/var/log` to S3 daily.
* Ensure your instance role includes `s3:PutObject` permission.
* Verify files in your S3 bucket.

---

## ✅ **Summary**

| Command / Service       | Purpose                       | Example                              |
| ----------------------- | ----------------------------- | ------------------------------------ |
| `crontab -e`            | Edit cron jobs on EC2         | `0 2 * * * /home/ec2-user/backup.sh` |
| `systemctl start crond` | Start cron service            | On EC2                               |
| **EventBridge Rule**    | AWS-native scheduler          | `cron(0 3 * * ? *)`                  |
| **Lambda / ECS Target** | Executes scheduled job        | Cloud automation                     |
| **Logs**                | `/var/log/cron` or CloudWatch | Monitor job success                  |

---

