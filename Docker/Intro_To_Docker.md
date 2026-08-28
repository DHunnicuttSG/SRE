# Introduction to Docker for Production Support Engineers

**Duration:** 2.5 Hours  
**Audience:** Production Support, Operations, Application Support, NOC, Junior SREs, Infrastructure Support Engineers

---

# Course Overview

This introductory course provides Production Support Engineers with the foundational Docker knowledge needed to support containerized applications in production environments. The class focuses on practical operational tasks such as monitoring containers, viewing logs, troubleshooting failures, and deploying a simple containerized application on AWS EC2.

## Learning Objectives

By the end of this class, students will be able to:

- Explain what Docker is and why organizations use containers.
- Understand the differences between Virtual Machines and Containers.
- Run and manage Docker containers.
- View logs and troubleshoot common container issues.
- Deploy a Docker container on an AWS EC2 instance.
- Perform common day-to-day production support tasks.

---

# Agenda

| Topic | Duration |
|---------|---------|
| Introduction to Containers | 20 min |
| Docker Fundamentals | 25 min |
| Docker Commands Demo | 25 min |
| Production Support Use Cases | 20 min |
| AWS EC2 Hands-On Lab | 45 min |
| Troubleshooting Exercise | 15 min |
| Q&A / Wrap-Up | 10 min |

---

# Module 1: Introduction to Containers

## The Traditional Deployment Problem

Historically, applications were installed directly onto servers:

```text
Server
├── Application A
├── Application B
├── Java
├── Python
└── OS Dependencies
```

### Common Challenges

- Dependency conflicts
- Inconsistent environments
- Difficult upgrades
- Complex rollbacks
- "Works on my machine" issues

### Example

An application requires:

- Java 17
- Specific libraries
- Specific Linux packages

Production environment contains:

- Java 11
- Older dependencies

Result:

```text
Application Startup Failure
```

---

## What is a Container?

A container packages:

- Application Code
- Runtime
- Libraries
- Dependencies
- Configuration Files

Into a standardized deployable unit.

### Shipping Container Analogy

Just as shipping containers work across:

- Ships
- Trucks
- Railways

Docker containers work across:

- Developer laptops
- Test environments
- Cloud servers
- On-prem servers

---

## Benefits of Containers

### Consistency

Same application behavior across environments.

### Portability

Run anywhere Docker is installed.

### Fast Startup

Containers start in seconds.

### Efficient Resource Usage

Containers share the host OS kernel.

### Scalability

Easily create multiple container instances.

---

## Containers vs Virtual Machines

### Virtual Machines

```text
Hardware
│
Hypervisor
│
Guest Operating System
│
Application
```

### Docker Containers

```text
Hardware
│
Host Operating System
│
Docker Engine
│
Containers
```

### Comparison

| Feature | Virtual Machine | Docker Container |
|----------|----------|----------|
| Startup Time | Minutes | Seconds |
| OS Required | Full OS | Shared Kernel |
| Resource Usage | Higher | Lower |
| Portability | Moderate | High |

---

# Module 2: Docker Fundamentals

## Docker Architecture

### Docker Engine

Core service responsible for:

- Running containers
- Managing images
- Managing networking
- Managing storage

---

## Docker Images

A Docker image is:

```text
Application Blueprint
```

Examples:

```bash
nginx
ubuntu
mysql
redis
```

View local images:

```bash
docker images
```

---

## Docker Containers

A container is:

```text
A Running Instance of an Image
```

Example:

```bash
docker run nginx
```

---

## Docker Registry

Docker registries store images.

Examples:

- Docker Hub
- AWS Elastic Container Registry (ECR)
- Azure Container Registry (ACR)

---

## Docker Lifecycle

```text
Dockerfile
    ↓
Docker Image
    ↓
Docker Container
    ↓
Stopped Container
    ↓
Removed Container
```

---

## Key Docker Concepts

### Image

Read-only template used to create containers.

### Container

Running application instance.

### Volume

Persistent data storage.

### Network

Allows communication between containers and external systems.

---

# Module 3: Essential Docker Commands

## Verify Installation

```bash
docker --version
```

---

## Retrieve an Image

```bash
docker pull nginx
```

---

## View Available Images

```bash
docker images
```

Example Output:

```text
REPOSITORY   TAG       IMAGE ID
nginx        latest    xxxxxxxx
```

---

## Run a Container

```bash
docker run nginx
```

---

## Run Container in Background

```bash
docker run -d nginx
```

---

## Assign Container Name

```bash
docker run -d --name webserver nginx
```

---

## View Running Containers

```bash
docker ps
```

---

## View All Containers

```bash
docker ps -a
```

---

## Stop a Container

```bash
docker stop webserver
```

---

## Start a Container

```bash
docker start webserver
```

---

## Restart a Container

```bash
docker restart webserver
```

---

## Remove a Container

```bash
docker rm webserver
```

---

## View Container Logs

One of the most important support commands:

```bash
docker logs webserver
```

Follow logs in real time:

```bash
docker logs -f webserver
```

---

## Execute Commands Inside a Container

```bash
docker exec -it webserver bash
```

---

## Display Resource Usage

```bash
docker stats
```

Example Metrics:

- CPU Usage
- Memory Usage
- Network Usage

---

## Inspect Container Details

```bash
docker inspect webserver
```

Displays:

- IP address
- Port mappings
- Mounted volumes
- Environment variables

---

# Module 4: Docker from a Production Support Perspective

## Common Production Tasks

### Check Running Applications

```bash
docker ps
```

---

### Review Application Logs

```bash
docker logs app-container
```

---

### Restart Failed Applications

```bash
docker restart app-container
```

---

### Verify Port Mappings

```bash
docker inspect app-container
```

---

### Monitor Resource Consumption

```bash
docker stats
```

---

## Common Production Issues

### Container Not Starting

Diagnostics:

```bash
docker ps -a
docker logs app-container
```

Possible Causes:

- Missing environment variables
- Application startup failure
- Network issues
- Invalid configuration

---

### Port Conflict

Error:

```text
Bind for 0.0.0.0:80 failed
```

Find the conflicting service:

```bash
sudo netstat -tulpn
```

or

```bash
sudo ss -tulpn
```

---

### Container Exits Immediately

Investigate:

```bash
docker ps -a
docker logs container-name
```

Common Causes:

- Application crash
- Missing configuration
- Database unavailable
- Startup script failure

---

# Module 5: Hands-On AWS EC2 Docker Lab

## Lab Objective

Deploy a Dockerized NGINX web server on an AWS EC2 instance and perform basic operational support tasks.

---

## Architecture

```text
Internet
    │
AWS Security Group
    │
EC2 Instance
    │
Docker Engine
    │
NGINX Container
```

---

# Step 1: Launch EC2 Instance

### Recommended Configuration

- Amazon Linux 2023
- t2.micro or t3.micro
- Public IP Enabled

### Security Group Rules

| Port | Protocol | Source |
|--------|--------|--------|
| 22 | TCP | Your IP |
| 80 | TCP | Anywhere |

---

# Step 2: Connect to EC2

```bash
ssh -i dockerlab.pem ec2-user@PUBLIC-IP
```

---

# Step 3: Update System

```bash
sudo yum update -y
```

---

# Step 4: Install Docker

```bash
sudo yum install docker -y
```

Start Docker:

```bash
sudo systemctl start docker
```

Enable Docker at boot:

```bash
sudo systemctl enable docker
```

Verify installation:

```bash
docker --version
```

---

# Step 5: Grant Docker Permissions

Add user to Docker group:

```bash
sudo usermod -aG docker ec2-user
```

Logout and reconnect:

```bash
exit
```

Reconnect:

```bash
ssh -i dockerlab.pem ec2-user@PUBLIC-IP
```

Verify:

```bash
docker ps
```

---

# Step 6: Download NGINX Image

```bash
docker pull nginx
```

Verify:

```bash
docker images
```

---

# Step 7: Run the Web Server

```bash
docker run -d \
--name webserver \
-p 80:80 \
nginx
```

---

# Step 8: Verify Deployment

```bash
docker ps
```

Expected:

```text
CONTAINER ID   IMAGE   STATUS
xxxxxxxxxxxx   nginx   Up
```

---

# Step 9: Test the Application

Open:

```text
http://EC2-PUBLIC-IP
```

Expected Result:

```text
Welcome to nginx!
```

---

# Step 10: View Logs

Display logs:

```bash
docker logs webserver
```

Generate browser traffic and rerun:

```bash
docker logs webserver
```

Observe:

```text
GET /
200 OK
```

---

# Step 11: Access the Container

```bash
docker exec -it webserver bash
```

Navigate to site content:

```bash
cd /usr/share/nginx/html
ls
```

View default page:

```bash
cat index.html
```

Exit:

```bash
exit
```

---

# Step 12: Simulate a Production Incident

Stop the application:

```bash
docker stop webserver
```

Refresh browser.

Expected:

```text
Website unavailable
```

---

## Support Investigation

Check container status:

```bash
docker ps -a
```

Output:

```text
Exited
```

Review logs:

```bash
docker logs webserver
```

Restart service:

```bash
docker start webserver
```

Verify:

```bash
docker ps
```

Refresh browser.

Application should be restored.

---

# Module 6: Troubleshooting Exercise

## Scenario 1: Website Down

### Investigation

```bash
docker ps
```

### Resolution

```bash
docker start webserver
```

---

## Scenario 2: Application Errors

### Investigation

```bash
docker logs webserver
```

Look for:

- Exceptions
- Connection failures
- Configuration errors

---

## Scenario 3: Resource Exhaustion

### Investigation

```bash
docker stats
```

Look for:

- High CPU
- High Memory
- Network saturation

---

## Scenario 4: Configuration Review

### Investigation

```bash
docker inspect webserver
```

Review:

- Environment Variables
- Volumes
- Networks
- Port Mappings

---

# Docker Command Cheat Sheet

```bash
docker --version

docker pull nginx

docker images

docker run nginx

docker run -d nginx

docker run -d --name webserver nginx

docker ps

docker ps -a

docker stop webserver

docker start webserver

docker restart webserver

docker rm webserver

docker logs webserver

docker logs -f webserver

docker exec -it webserver bash

docker inspect webserver

docker stats
```

---

# Knowledge Check

### Question 1

What is the difference between a Docker Image and a Docker Container?

### Question 2

Why are containers more lightweight than Virtual Machines?

### Question 3

Which command displays running containers?

```bash
docker ps
```

### Question 4

Which command displays application logs?

```bash
docker logs <container>
```

### Question 5

How do you restart a failed container?

```bash
docker restart <container>
```

### Question 6

What does the following command accomplish?

```bash
-p 80:80
```

### Question 7

Which command helps diagnose CPU and Memory issues?

```bash
docker stats
```

---

# Key Takeaways for Production Support Teams.

---

# Production Support Incident Runbook Example

The following runbook demonstrates a standard support workflow when a containerized application becomes unavailable.

## Incident

Users report that the application is returning errors or is unavailable.

---

## Step 1: Verify Container Status

```bash
docker ps
```

If the container is not running:

```bash
docker ps -a
```

Look for statuses such as:

```text
Exited
Restarting
Created
```

---

## Step 2: Review Container Logs

```bash
docker logs app-container
```

For real-time monitoring:

```bash
docker logs -f app-container
```

Common findings:

- Database connection failures
- Missing environment variables
- Port binding failures
- Application exceptions

---

## Step 3: Verify Resource Utilization

```bash
docker stats
```

Watch for:

- CPU > 90%
- Memory approaching limits
- Excessive network traffic

---

## Step 4: Verify Container Configuration

```bash
docker inspect app-container
```

Review:

- Environment variables
- Port mappings
- Mounted volumes
- Network settings

---

## Step 5: Validate Network Connectivity

Access the running container:

```bash
docker exec -it app-container bash
```

Test connectivity:

```bash
ping hostname
curl http://service-endpoint
```

---

## Step 6: Restart Service

If appropriate:

```bash
docker restart app-container
```

Verify:

```bash
docker ps
```

---

## Step 7: Confirm Recovery

Validate:

- Application availability
- User functionality
- Error logs cleared
- Monitoring alerts resolved

---

# Docker Best Practices for Production Support

## Always Name Containers

Instead of:

```bash
docker run nginx
```

Use:

```bash
docker run -d --name webserver nginx
```

Benefits:

- Easier troubleshooting
- Easier automation
- Easier documentation

---

## Monitor Logs Regularly

```bash
docker logs -f webserver
```

Look for:

- Error messages
- Restart loops
- Database failures
- Authentication failures

---

## Check Resource Consumption

```bash
docker stats
```

Proactively identify:

- Memory leaks
- CPU spikes
- Excessive network utilization

---

## Use Versioned Images

Avoid:

```bash
nginx:latest
```

Prefer:

```bash
nginx:1.27
```

Benefits:

- Predictable deployments
- Easier rollback
- Better change control

---

## Document Port Mappings

Example:

```bash
docker run -d \
--name webserver \
-p 80:80 \
nginx
```

Documentation should include:

```text
Host Port: 80
Container Port: 80
Application: NGINX
Purpose: Public Website
```

---

# Optional Advanced Demonstration (If Time Allows)

## Custom Web Page Deployment

Create a simple web page:

```bash
mkdir website

cd website
```

Create index.html:

```html
<html>
<head>
    <title>Docker Training Lab</title>
</head>
<body>
    <h1>Hello from Docker on AWS!</h1>
</body>
</html>
```

Run NGINX with a mounted volume:

```bash
docker run -d \
--name custom-web \
-p 8080:80 \
-v $(pwd):/usr/share/nginx/html \
nginx
```

Access:

```text
http://EC2-PUBLIC-IP:8080
```

Students will see their custom webpage served by Docker.

---

# Real-World Production Support Scenarios

## Scenario 1: Container Restart Loop

Symptoms:

```text
Application unavailable
Container repeatedly restarting
```

Investigate:

```bash
docker ps -a
docker logs app-container
```

Common Causes:

- Startup failures
- Missing configuration
- Dependency failures

---

## Scenario 2: High Memory Usage

Investigate:

```bash
docker stats
```

Symptoms:

```text
Slow performance
Container crashes
Out-of-memory events
```

Potential Resolution:

```bash
docker restart app-container
```

Escalate to engineering if memory leak suspected.

---

## Scenario 3: Application Port Not Accessible

Verify:

```bash
docker ps
```

Confirm port mapping:

```bash
docker inspect app-container
```

Expected:

```json
"80/tcp": [
  {
    "HostPort": "80"
  }
]
```

---

## Scenario 4: Missing Log Data

Verify logging:

```bash
docker logs app-container
```

If logs are not visible:

- Application may not be writing to stdout/stderr
- Logging driver may be misconfigured
- External log collection may be failing

---

# Final Review

## Docker Objects

```text
Dockerfile
    ↓
Image
    ↓
Container
    ↓
Logs
    ↓
Support / Monitoring
```

---

## Most Important Support Commands

```bash
docker ps

docker ps -a

docker logs container

docker logs -f container

docker restart container

docker inspect container

docker stats

docker exec -it container bash
```

---

# Class Summary

In this course you learned:

- What containers are and why organizations use them
- Differences between Virtual Machines and Containers
- Docker architecture and components
- How to deploy containers
- How to troubleshoot containerized applications
- How to use AWS EC2 as a Docker host
- Core operational commands used by Production Support teams

These skills provide a strong foundation for supporting modern cloud-native and containerized applications in production environments.

---

# Next Steps

After this course, students should continue with:

1. Docker Compose
2. Container Networking
3. Docker Volumes and Persistent Storage
4. AWS Elastic Container Registry (ECR)
5. Amazon ECS
6. Kubernetes Fundamentals
7. Production Monitoring and Logging
8. Container Security Fundamentals

---

# Additional Resources

## Docker Documentation

https://docs.docker.com/

## Docker Hub

https://hub.docker.com/

## AWS Docker on EC2

https://docs.aws.amazon.com/

## Docker Training Playground

https://labs.play-with-docker.com/

---

# Instructor Notes

### Demo Checklist

- [ ] Launch EC2 instance
- [ ] SSH into server
- [ ] Install Docker
- [ ] Pull NGINX image
- [ ] Run container
- [ ] Access application in browser
- [ ] Review logs
- [ ] Enter container shell
- [ ] Simulate outage
- [ ] Restore service
- [ ] Walk through troubleshooting workflow

### Expected Student Outcome

Every student should be able to:

- Deploy a Docker container
- Verify container health
- Review logs
- Restart services
- Investigate outages
- Navigate a container environment
- Explain Docker fundamentals from a Production Support perspective
`