# Hands-On Lab: Dockerizing a Python To-Do Application with SQLite

## Lab Overview

In this lab, students will:

- Create a Python Flask application
- Connect the application to a SQLite database
- Build a custom Docker image
- Run the application in a container
- Deploy using Docker Compose
- Troubleshoot common production issues
- Perform support and operational tasks

---

# Learning Objectives

By the end of this lab students will be able to:

- Understand Dockerfiles
- Build Docker images
- Run containers
- Use Docker Compose
- Investigate container logs
- Access running containers
- Troubleshoot application failures
- Support containerized applications in production

---

# Solution Architecture

```text
Browser
   │
   ▼
Flask Todo Application
   │
   ▼
SQLite Database
   │
   ▼
Docker Container
```

Later:

```text
Browser
   │
Docker Compose
   │
Docker Container
   │
SQLite Database File
```

---

# Prerequisites

AWS EC2 Instance

Recommended:

```text
Amazon Linux 2023
t2.micro
```

Security Group:

```text
22 SSH
5000 TCP
```

---

# Section 1 - Connect to EC2

SSH into your server.

```bash
ssh -i dockerlab.pem ec2-user@PUBLIC-IP
```

---

# Section 2 - Install Docker

Update packages:

```bash
sudo yum update -y
```

Install Docker:

```bash
sudo yum install docker -y
```

Start Docker:

```bash
sudo systemctl start docker
```

Enable Docker:

```bash
sudo systemctl enable docker
```

Verify:

```bash
docker --version
```

---

# Section 3 - Install Docker Compose

Verify Compose:

```bash
docker compose version
```

Most newer Docker installations include it.

---

# Section 4 - Build Application Structure

Create project directory.

```bash
mkdir todo-app

cd todo-app
```

Create files:

```bash
touch app.py

touch requirements.txt

touch Dockerfile

touch docker-compose.yml
```

Verify:

```bash
ls
```

---

# Section 5 - Create Python Application

Edit:

```bash
vi app.py
```

Paste:

```python
from flask import Flask, request, redirect
import sqlite3

app = Flask(__name__)

def init_db():
    conn = sqlite3.connect("todo.db")
    c = conn.cursor()

    c.execute("""
        CREATE TABLE IF NOT EXISTS tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            task TEXT NOT NULL
        )
    """)

    conn.commit()
    conn.close()

init_db()

@app.route("/", methods=["GET"])
def home():

    conn = sqlite3.connect("todo.db")
    c = conn.cursor()

    c.execute("SELECT * FROM tasks")

    tasks = c.fetchall()

    conn.close()

    html = "<h1>Docker ToDo App</h1>"

    html += """
    <form method='POST' action='/>
      <button>Add Task</button>
    </form>
    """

    for task in tasks:
        html += f"<p>{task[1]}</p>"

    return html

@app.route("/add", methods=["POST"])
def add():

    task = request.form["task"]

    conn = sqlite3.connect("todo.db")
    c = conn.cursor()

    c.execute(
        "INSERT INTO tasks(task) VALUES (?)",
        (task,)
    )

    conn.commit()
    conn.close()

    return redirect("/")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
```

Save and exit.

---

# Section 6 - Create Requirements File

Edit:

```bash
vi requirements.txt
```

Contents:

```text
flask
```

Save.

---

# Section 7 - Create Dockerfile

Edit:

```bash
vi Dockerfile
```

Contents:

```dockerfile
FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python","app.py"]
```

Save.

---

# Section 8 - Build Docker Image

Build:

```bash
docker build -t todo-app .
```

Verify:

```bash
docker images
```

Expected:

```text
todo-app
latest
```

---

# Section 9 - Run Container

Run:

```bash
docker run -d \
--name todo-container \
-p 5000:5000 \
todo-app
```

Verify:

```bash
docker ps
```

---

# Section 10 - Test Application

Open browser:

```text
http://EC2-PUBLIC-IP:5000
```

Expected:

```text
Docker ToDo App
```

Add tasks.

Examples:

```text
Check logs
Review tickets
Restart services
```

---

# Section 11 - Review Logs

View logs:

```bash
docker logs todo-container
```

Follow logs:

```bash
docker logs -f todo-container
```

Refresh browser.

Observe requests.

Press:

```text
CTRL+C
```

---

# Section 12 - Access Container

Enter container:

```bash
docker exec -it todo-container bash
```

View files:

```bash
ls
```

Expected:

```text
app.py
requirements.txt
todo.db
```

---

View database file:

```bash
ls -lh
```

Exit:

```bash
exit
```

---

# Section 13 - Stop and Start

Stop container:

```bash
docker stop todo-container
```

Verify:

```bash
docker ps -a
```

Start container:

```bash
docker start todo-container
```

---

# Section 14 - Deploy with Docker Compose

Stop and remove existing container:

```bash
docker stop todo-container

docker rm todo-container
```

---

# Section 15 - Create Docker Compose File

Edit:

```bash
vi docker-compose.yml
```

Contents:

```yaml
services:
  todoapp:

    build: .

    container_name: todo-container

    ports:
      - "5000:5000"

    volumes:
      - todo-data:/app

volumes:
  todo-data:
```

Save.

---

# Section 16 - Deploy with Compose

Start services:

```bash
docker compose up -d
```

Verify:

```bash
docker compose ps
```

---

# Section 17 - View Compose Logs

```bash
docker compose logs
```

Follow:

```bash
docker compose logs -f
```

---

# Section 18 - Stop Compose Environment

```bash
docker compose down
```

Start again:

```bash
docker compose up -d
```

---

# Section 19 - Production Support Scenarios

## Scenario 1

Website Down

Check:

```bash
docker ps
```

Restart:

```bash
docker restart todo-container
```

---

## Scenario 2

Container Exited

Investigate:

```bash
docker ps -a

docker logs todo-container
```

---

## Scenario 3

Port Issue

Error:

```text
Port already allocated
```

Check:

```bash
docker ps
```

Determine which container owns port 5000.

---

## Scenario 4

High Resource Utilization

Check:

```bash
docker stats
```

Review:

- CPU
- Memory
- Network

---

## Scenario 5

Database Missing

Enter container:

```bash
docker exec -it todo-container bash
```

Verify:

```bash
ls
```

Confirm:

```text
todo.db
```

exists.

---

# Useful Support Commands

```bash
docker ps

docker ps -a

docker images

docker logs todo-container

docker logs -f todo-container

docker restart todo-container

docker stats

docker inspect todo-container

docker exec -it todo-container bash

docker compose up -d

docker compose down

docker compose logs
```

---

# Challenge Exercise

Modify application to display:

```text
Production Support Dashboard
```

instead of:

```text
Docker ToDo App
```

Rebuild:

```bash
docker build -t todo-app .
```

Restart:

```bash
docker compose down

docker compose up -d
```

Validate change.

---

# Knowledge Check

### What does the Dockerfile do?

Creates a custom image.

---

### What command builds an image?

```bash
docker build -t todo-app .
```

---

### What command starts services with Compose?

```bash
docker compose up -d
```

---

### What command displays logs?

```bash
docker logs container-name
```

---

### What command allows access into a container?

```bash
docker exec -it container-name bash
```

---

# Lab Summary

During this lab you:

- Built a Python Flask application
- Connected it to SQLite
- Created a Docker image
- Deployed a containerized application
- Used Docker Compose
- Viewed logs
- Restarted services
- Investigated failures
- Performed realistic Production Support operations

This lab closely mirrors the workflow Production Support engineers encounter when supporting internally developed containerized applications in cloud environments.