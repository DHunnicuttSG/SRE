Here’s a clean, practical **Docker Cheat Sheet** you can use every day. It’s concise but covers the most common commands for building, running, debugging, and managing containers.

***

# 🐳 **Docker Cheat Sheet**

## ✅ **1. Basic Commands**

### **Check Docker version & info**

```bash
docker --version
docker info
```

### **Log in to a registry**

```bash
docker login
```

***

## ✅ **2. Images**

### **List, pull, remove images**

```bash
docker images
docker pull <image>
docker rmi <image>
```

### **Build an image**

```bash
docker build -t <name>:<tag> .
```

### **Tag an image**

```bash
docker tag <source> <repo>:<tag>
```

***

## ✅ **3. Containers**

### **Run a container**

```bash
docker run <image>
```

### **Run with common options**

```bash
docker run -d <image>            # Detached
docker run -it <image>           # Interactive shell
docker run -p 8080:80 <image>    # Port mapping
docker run -v host:container <image>  # Volume mount
docker run --name myapp <image>
```

### **List containers**

```bash
docker ps           # Running
docker ps -a        # All
```

### **Stop, start, restart**

```bash
docker stop <container>
docker start <container>
docker restart <container>
```

### **Remove containers**

```bash
docker rm <container>
docker rm -f <container>    # Force remove
```

***

## ✅ **4. Debugging**

### **Container logs**

```bash
docker logs <container>
docker logs -f <container>    # Follow logs
```

### **Exec into container**

```bash
docker exec -it <container> sh
docker exec -it <container> bash
```

### **Inspect container**

```bash
docker inspect <container>
```

***

## ✅ **5. Volumes**

### **Manage volumes**

```bash
docker volume ls
docker volume create <name>
docker volume rm <name>
```

### **Using volumes**

```bash
docker run -v myvol:/data <image>
```

***

## ✅ **6. Networks**

### **List, create, remove networks**

```bash
docker network ls
docker network create <name>
docker network rm <name>
```

### **Run container on a network**

```bash
docker run --network <name> <image>
```

***

## ✅ **7. Docker Compose**

### **Start services**

```bash
docker compose up
docker compose up -d       # Detached
```

### **Stop services**

```bash
docker compose down
```

### **Rebuild containers**

```bash
docker compose up --build
```

### **View logs**

```bash
docker compose logs -f
```

***

## ✅ **8. Cleaning Up**

```bash
docker system prune            # Remove unused data
docker system prune -a         # Remove unused images + cache
docker volume prune
docker network prune
```

***

## ✅ **9. Dockerfile Basics**

```Dockerfile
FROM python:3.11
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
EXPOSE 8000
CMD ["python", "app.py"]
```

Build & run:

```bash
docker build -t myapp .
docker run -p 8000:8000 myapp
```

***
