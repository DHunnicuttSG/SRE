# Hands-On Lab: Deploying MySQL and Connecting with MySQL Workbench Using Docker on AWS EC2

## Lab Overview

In this lab, students will:

- Launch an AWS EC2 instance
- Install Docker
- Deploy a MySQL Database Server using Docker
- Configure AWS Security Groups
- Verify database operation
- Connect remotely using MySQL Workbench
- Perform basic database administration tasks
- Troubleshoot common connectivity issues

---

# Learning Objectives

By the end of this lab, students will be able to:

- Deploy a MySQL container using Docker
- Verify container health and status
- Access MySQL from inside a container
- Connect remotely using MySQL Workbench
- Perform basic SQL operations
- Troubleshoot production support issues involving databases and containers

---

# Lab Architecture

```text
MySQL Workbench (Student Laptop)
            │
            │ Port 3306
            ▼
AWS Security Group
            │
            ▼
EC2 Instance
            │
            ▼
Docker Engine
            │
            ▼
MySQL Container
```

---

# Prerequisites

Students should have:

- AWS account access
- EC2 launch permissions
- SSH key pair
- MySQL Workbench installed locally

Download:

https://dev.mysql.com/downloads/workbench/

---

# Section 1: Launch EC2 Instance

## Step 1: Create EC2 Instance

Launch:

```text
Amazon Linux 2023
```

Recommended Instance Type:

```text
t2.micro
or
t3.micro
```

---

## Step 2: Configure Security Group

Add the following inbound rules:

### SSH

```text
Port: 22
Source: Your IP
```

### MySQL

```text
Port: 3306
Source: Your IP
```

Example:

```text
22     TCP     My IP
3306   TCP     My IP
```

> Never expose MySQL to the entire internet (0.0.0.0/0) in production.

---

## Step 3: Connect to EC2

```bash
ssh -i mysql-lab.pem ec2-user@PUBLIC-IP
```

Verify connectivity.

---

# Section 2: Install Docker

## Update Packages

```bash
sudo yum update -y
```

---

## Install Docker

```bash
sudo yum install docker -y
```

---

## Start Docker

```bash
sudo systemctl start docker
```

---

## Enable Docker at Boot

```bash
sudo systemctl enable docker
```

---

## Verify Installation

```bash
docker --version
```

Expected:

```text
Docker version xx.x.x
```

---

## Add User to Docker Group

```bash
sudo usermod -aG docker ec2-user
```

Logout:

```bash
exit
```

Reconnect:

```bash
ssh -i mysql-lab.pem ec2-user@PUBLIC-IP
```

Verify:

```bash
docker ps
```

---

# Section 3: Deploy MySQL Container

## Pull MySQL Image

```bash
docker pull mysql:8.0
```

View image:

```bash
docker images
```

Expected:

```text
REPOSITORY   TAG
mysql        8.0
```

---

## Create MySQL Container

Run:

```bash
docker run -d \
--name mysql-server \
-p 3306:3306 \
-e MYSQL_ROOT_PASSWORD=Password123! \
mysql:8.0
```

---

## Understanding the Command

```text
-d                      Run in background

--name mysql-server     Container name

-p 3306:3306            Port mapping

MYSQL_ROOT_PASSWORD     Root password
```

---

# Section 4: Verify Deployment

## View Running Containers

```bash
docker ps
```

Expected:

```text
mysql-server
Up
0.0.0.0:3306->3306
```

---

## View Logs

MySQL may take several seconds to initialize.

```bash
docker logs mysql-server
```

Look for:

```text
ready for connections
```

---

## Follow Logs

```bash
docker logs -f mysql-server
```

Press:

```text
CTRL+C
```

when ready.

---

# Section 5: Connect to MySQL Inside the Container

## Access Container Shell

```bash
docker exec -it mysql-server bash
```

---

## Login as Root

```bash
mysql -u root -p
```

Enter:

```text
Password123!
```

---

## Verify Connection

Run:

```sql
SHOW DATABASES;
```

Expected:

```text
information_schema
mysql
performance_schema
sys
```

---

# Section 6: Create Sample Database

## Create Database

```sql
CREATE DATABASE prodsupport;
```

---

## Use Database

```sql
USE prodsupport;
```

---

## Create Table

```sql
CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50)
);
```

---

## Insert Records

```sql
INSERT INTO employees
(first_name,last_name,department)
VALUES
('John','Smith','IT'),
('Mary','Jones','Support'),
('David','Brown','Operations');
```

---

## Verify Data

```sql
SELECT * FROM employees;
```

Expected:

```text
+----+------------+-----------+------------+
| id | first_name | last_name | department |
+----+------------+-----------+------------+
```

---

## Exit MySQL

```sql
EXIT;
```

---

## Exit Container

```bash
exit
```

---

# Section 7: Configure Remote Connectivity

## Verify Port Mapping

```bash
docker ps
```

Expected:

```text
3306->3306
```

---

## Verify EC2 Public IP

Obtain from AWS Console.

Example:

```text
34.219.xxx.xxx
```

---

## Verify Security Group

Ensure:

```text
3306 inbound allowed
```

for your IP address.

---

# Section 8: Install and Configure MySQL Workbench

## Launch MySQL Workbench

Select:

```text
MySQL Connections
```

Click:

```text
+
```

for a new connection.

---

## Configure Connection

### Connection Name

```text
AWS Docker MySQL
```

### Hostname

```text
EC2 Public IP
```

Example:

```text
34.219.xxx.xxx
```

---

### Port

```text
3306
```

---

### Username

```text
root
```

---

### Password

```text
Store in Vault
```

Enter:

```text
Password123!
```

---

## Test Connection

Click:

```text
Test Connection
```

Expected:

```text
Successfully Connected
```

---

## Open Connection

Double-click connection.

Run:

```sql
SHOW DATABASES;
```

---

## Verify Sample Data

Run:

```sql
USE prodsupport;

SELECT * FROM employees;
```

Expected output:

```text
3 rows returned
```

---

# Section 9: Production Support Activities

These are common tasks support teams perform.

---

## Check Container Health

```bash
docker ps
```

---

## View Logs

```bash
docker logs mysql-server
```

---

## Monitor Resource Usage

```bash
docker stats mysql-server
```

---

## Restart Database

```bash
docker restart mysql-server
```

---

## Verify Configuration

```bash
docker inspect mysql-server
```

---

# Section 10: Simulate Production Incident

## Stop Database

```bash
docker stop mysql-server
```

---

## Attempt Workbench Connection

Expected:

```text
Connection Failed
```

---

## Investigate

Check status:

```bash
docker ps -a
```

Expected:

```text
Exited
```

---

## Restore Service

```bash
docker start mysql-server
```

---

## Verify

```bash
docker ps
```

Connect again in Workbench.

Success.

---

# Troubleshooting Exercises

## Problem 1: Can't Connect from Workbench

Check:

```bash
docker ps
```

Verify:

```bash
docker logs mysql-server
```

Verify:

```text
Security Group Port 3306
```

Verify:

```bash
docker inspect mysql-server
```

---

## Problem 2: MySQL Container Stops

Investigate:

```bash
docker ps -a
```

Review:

```bash
docker logs mysql-server
```

---

## Problem 3: Authentication Failure

Verify:

```text
Username
Password
```

Recreate container if necessary.

---

## Problem 4: Port Already in Use

Check:

```bash
sudo ss -tulpn
```

or

```bash
sudo netstat -tulpn
```

---

# Optional Challenge Lab

Create a non-root user.

Login:

```bash
docker exec -it mysql-server mysql -u root -p
```

Create user:

```sql
CREATE USER 'supportuser'
IDENTIFIED BY 'Support123!';
```

Grant access:

```sql
GRANT ALL PRIVILEGES
ON prodsupport.*
TO 'supportuser';
```

Apply:

```sql
FLUSH PRIVILEGES;
```

Verify from Workbench using:

```text
supportuser
Support123!
```

---

# Production Support Command Cheat Sheet

```bash
docker pull mysql:8.0

docker images

docker ps

docker ps -a

docker logs mysql-server

docker logs -f mysql-server

docker exec -it mysql-server bash

docker stats mysql-server

docker inspect mysql-server

docker restart mysql-server

docker stop mysql-server

docker start mysql-server
```

---

# Knowledge Check

### Question 1

What command displays running containers?

```bash
docker ps
```

---

### Question 2

How do you view MySQL container logs?

```bash
docker logs mysql-server
```

---

### Question 3

Which port does MySQL use by default?

```text
3306
```

---

### Question 4

What command connects to a running container?

```bash
docker exec -it mysql-server bash
```

---

### Question 5

How do you restart MySQL?

```bash
docker restart mysql-server
```

---

# Lab Summary

In this lab you successfully:

- Created an AWS EC2 server
- Installed Docker
- Deployed MySQL using Docker
- Configured networking and security groups
- Connected remotely via MySQL Workbench
- Created databases and tables
- Performed common production support tasks
- Troubleshot a simulated outage

This lab closely mirrors real-world production support activities where engineers must verify container health, investigate logs, validate network connectivity, and restore service when incidents occur.