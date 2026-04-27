You got it, David—let’s automate it end‑to‑end so you can go from a fresh EC2 instance to a live, working app with **one script**. I generated a ready‑to‑run setup script that:

*   Installs Docker + Docker Compose plugin
*   Creates the backend (FastAPI + SQLite) and frontend (React) code
*   Builds both containers
*   Configures Nginx to **proxy** `/api/*` → backend (no CORS headaches, no IP hardcoding)
*   Starts everything with `docker compose`

You can either **download the script** or just copy‑paste it on your EC2 instance.

***

## ✅ What this fixes vs. the manual guide

*   **No more `localhost` in the browser issue.** The frontend calls `/api/...`, and Nginx proxies that to the backend container. This removes CORS issues and avoids hardcoding your IP.
*   **DB persistence done right.** SQLite lives under `/data/todos.db` in the backend container, mounted to a named Docker volume.
*   **Only port 80 is exposed** to the internet (backend is internal), which is simpler and a bit safer.

***

## 1) Get on your EC2 box

SSH in (same as before):

```bash
ssh -i ~/Downloads/todo-key.pem ubuntu@YOUR_PUBLIC_IP
```

***

## 2) Create and run the setup script (2 options)

### Option A — Copy/paste (most reliable)

Paste this into your EC2 terminal to create the file:

```bash
cat > setup_todo_app.sh << 'EOF'
#!/usr/bin/env bash
set -euo pipefail

# === Setup a full-stack Todo app on Ubuntu EC2 with Docker & Compose ===
# - Backend: FastAPI + SQLite (Python 3.11-slim in Docker)
# - Frontend: React (built in Node container, served by Nginx)
# - Orchestration: docker compose

APP_DIR="$HOME/todo-app"
BACKEND_DIR="$APP_DIR/backend"
FRONTEND_DIR="$APP_DIR/frontend"

print_step() {
  echo
  echo "=============================================="
  echo "[Step] $1"
  echo "=============================================="
}

print_note() {
  echo "[Note] $1"
}

# 0) Pre-flight: ensure running on Ubuntu/Debian with apt
if ! command -v apt-get >/dev/null 2>&1; then
  echo "This script expects an Ubuntu/Debian system with apt-get." >&2
  exit 1
fi

# 1) Install Docker and Docker Compose plugin
print_step "Installing Docker and Docker Compose plugin"
sudo apt-get update -y
sudo apt-get install -y docker.io docker-compose-plugin curl
sudo systemctl enable --now docker

# Add current user to docker group (effective after re-login)
sudo usermod -aG docker "$USER" || true
print_note "If you want to run 'docker' without sudo in new terminals, log out and back in. This script will continue using sudo."

# 2) Create project structure
print_step "Creating project structure at $APP_DIR"
mkdir -p "$BACKEND_DIR" "$FRONTEND_DIR/src" "$FRONTEND_DIR/public"

# 3) Write backend files (FastAPI + SQLite)
print_step "Writing backend files"
cat > "$BACKEND_DIR/requirements.txt" << 'FILE'
fastapi==0.110.0
uvicorn[standard]==0.27.1
sqlalchemy==2.0.25
pydantic==2.6.1
FILE

cat > "$BACKEND_DIR/app.py" << 'FILE'
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from sqlalchemy import Column, Integer, String, Boolean, create_engine
from sqlalchemy.orm import declarative_base, sessionmaker
import os

# Use a dedicated data directory for SQLite (mounted as a volume)
DB_PATH = os.environ.get("DB_PATH", "/data/todos.db")
DATABASE_URL = f"sqlite:////{DB_PATH}"
engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})
SessionLocal = sessionmaker(bind=engine, autoflush=False, autocommit=False)
Base = declarative_base()

class Todo(Base):
    __tablename__ = "todos"
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    completed = Column(Boolean, default=False)

Base.metadata.create_all(bind=engine)

app = FastAPI(title="Todo API", version="1.0")

# CORS: kept permissive for demo; in production, restrict allow_origins
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class TodoCreate(BaseModel):
    title: str

class TodoUpdate(BaseModel):
    title: str | None = None
    completed: bool | None = None

@app.get("/todos")
def list_todos():
    db = SessionLocal()
    todos = db.query(Todo).all()
    db.close()
    return [{"id": t.id, "title": t.title, "completed": t.completed} for t in todos]

@app.post("/todos", status_code=201)
def create_todo(todo: TodoCreate):
    db = SessionLocal()
    new_todo = Todo(title=todo.title, completed=False)
    db.add(new_todo)
    db.commit()
    db.refresh(new_todo)
    db.close()
    return {"id": new_todo.id, "title": new_todo.title, "completed": new_todo.completed}

@app.put("/todos/{todo_id}")
def update_todo(todo_id: int, todo: TodoUpdate):
    db = SessionLocal()
    db_todo = db.query(Todo).filter(Todo.id == todo_id).first()
    if not db_todo:
        db.close()
        raise HTTPException(status_code=404, detail="Todo not found")

    if todo.title is not None:
        db_todo.title = todo.title
    if todo.completed is not None:
        db_todo.completed = todo.completed

    db.commit()
    db.refresh(db_todo)
    db.close()
    return {"id": db_todo.id, "title": db_todo.title, "completed": db_todo.completed}

@app.delete("/todos/{todo_id}", status_code=204)
def delete_todo(todo_id: int):
    db = SessionLocal()
    db_todo = db.query(Todo).filter(Todo.id == todo_id).first()
    if not db_todo:
        db.close()
        raise HTTPException(status_code=404, detail="Todo not found")
    db.delete(db_todo)
    db.commit()
    db.close()
    return
FILE

cat > "$BACKEND_DIR/Dockerfile" << 'FILE'
# 1) Lightweight Python image
FROM python:3.11-slim

# 2) Working directory
WORKDIR /app

# 3) Dependencies first (cache)
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# 4) Copy app code
COPY . /app

# 5) Expose app port
EXPOSE 8000

# 6) Run app with uvicorn
ENV DB_PATH=/data/todos.db
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
FILE

# 4) Write frontend files (React app + Nginx proxy to backend)
print_step "Writing frontend files"
cat > "$FRONTEND_DIR/package.json" << 'FILE'
{
  "name": "todo-frontend",
  "version": "1.0.0",
  "private": true,
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-scripts": "5.0.1"
  },
  "scripts": {
    "build": "react-scripts build"
  }
}
FILE

cat > "$FRONTEND_DIR/src/App.js" << 'FILE'
import React, { useEffect, useState } from 'react';

const API_BASE = '/api'; // proxied by Nginx to backend

function App() {
  const [todos, setTodos] = useState([]);
  const [newTitle, setNewTitle] = useState('');
  const [loading, setLoading] = useState(false);

  const fetchTodos = async () => {
    setLoading(true);
    try {
      const res = await fetch(`${API_BASE}/todos`);
      const data = await res.json();
      setTodos(data);
    } catch (e) {
      console.error('Failed to fetch todos', e);
      alert('Failed to fetch todos.');
    } finally {
      setLoading(false);
    }
  };

  const addTodo = async (e) => {
    e.preventDefault();
    if (!newTitle.trim()) return;
    try {
      const res = await fetch(`${API_BASE}/todos`, {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({ title: newTitle })
      });
      if (!res.ok) throw new Error('Failed to add');
      setNewTitle('');
      fetchTodos();
    } catch (e) {
      alert('Failed to add todo');
    }
  };

  const toggleTodo = async (id, completed) => {
    try {
      const res = await fetch(`${API_BASE}/todos/${id}`, {
        method: 'PUT',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({ completed: !completed })
      });
      if (!res.ok) throw new Error('Failed to update');
      fetchTodos();
    } catch (e) {
      alert('Failed to update todo');
    }
  };

  const deleteTodo = async (id) => {
    try {
      const res = await fetch(`${API_BASE}/todos/${id}`, { method: 'DELETE' });
      if (res.status !== 204) throw new Error('Failed to delete');
      fetchTodos();
    } catch (e) {
      alert('Failed to delete todo');
    }
  };

  useEffect(() => { fetchTodos(); }, []);

  return (
    <div style={{ maxWidth: 600, margin: '40px auto', fontFamily: 'Arial' }}>
      <h1>Todo List</h1>
      <form onSubmit={addTodo} style={{ marginBottom: 20 }}>
        <input
          value={newTitle}
          onChange={(e) => setNewTitle(e.target.value)}
          placeholder="New todo title"
          style={{ padding: 10, width: '70%' }}
        />
        <button style={{ padding: 10, marginLeft: 10 }} type="submit">Add</button>
      </form>

      {loading ? <p>Loading...</p> : (
        <ul style={{ listStyle: 'none', padding: 0 }}>
          {todos.map((t) => (
            <li key={t.id} style={{
              display: 'flex', justifyContent: 'space-between', padding: '8px 0',
              borderBottom: '1px solid #ddd'
            }}>
              <span
                onClick={() => toggleTodo(t.id, t.completed)}
                style={{ cursor: 'pointer', textDecoration: t.completed ? 'line-through' : 'none' }}
              >
                {t.title}
              </span>
              <button onClick={() => deleteTodo(t.id)} style={{ marginLeft: 10, color: 'white', background: 'crimson', border: 'none', padding: '6px 10px' }}>
                Delete
              </button>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}

export default App;
FILE

cat > "$FRONTEND_DIR/src/index.js" << 'FILE'
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(<App />);
FILE

cat > "$FRONTEND_DIR/public/index.html" << 'FILE'
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Todo App</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
  </head>
  <body>
    <noscript>You need to enable JavaScript to run this app.</noscript>
    <div id="root"></div>
  </body>
</html>
FILE

cat > "$FRONTEND_DIR/nginx.conf" << 'FILE'
server {
  listen 80;
  server_name _;

  root /usr/share/nginx/html;
  index index.html index.htm;

  # Serve React (SPA) and fall back to index.html for client routing
  location / {
    try_files $uri /index.html;
  }

  # Proxy API calls to the backend service
  location /api/ {
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_http_version 1.1;
    proxy_pass http://backend:8000/; # trailing slash drops /api/ prefix
  }
}
FILE

cat > "$FRONTEND_DIR/Dockerfile" << 'FILE'
# 1) Build stage: compile React app
FROM node:18-alpine AS build
WORKDIR /app
COPY package.json ./
RUN npm install --no-audit --no-fund
COPY public ./public
COPY src ./src
RUN npm run build

# 2) Serve stage: Nginx
FROM nginx:alpine
# Replace default server config with our proxy config
COPY nginx.conf /etc/nginx/conf.d/default.conf
# Copy static build output
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
FILE

# 5) Write docker-compose.yml (single exposed port 80)
print_step "Writing docker-compose.yml"
cat > "$APP_DIR/docker-compose.yml" << 'FILE'
version: "3.9"

services:
  backend:
    build: ./backend
    container_name: todo-backend
    expose:
      - "8000"              # only accessible within Docker network
    volumes:
      - todo_data:/data      # persist SQLite DB
    restart: unless-stopped

  frontend:
    build: ./frontend
    container_name: todo-frontend
    ports:
      - "80:80"             # expose website on standard HTTP
    depends_on:
      - backend
    restart: unless-stopped

volumes:
  todo_data:
FILE

# 6) Build and run the stack
print_step "Building containers (this may take a few minutes)"
cd "$APP_DIR"
sudo docker compose build

print_step "Starting containers"
sudo docker compose up -d

print_step "Container status"
sudo docker compose ps

# 7) Try to detect public IP (EC2 metadata). Works with IMDSv2 if enabled.
print_step "Detecting EC2 public IP (best-effort)"
PUBLIC_IP=""
TOKEN=$(curl -sX PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 60" || true)
if [ -n "${TOKEN}" ]; then
  PUBLIC_IP=$(curl -s -H "X-aws-ec2-metadata-token: ${TOKEN}" http://169.254.169.254/latest/meta-data/public-ipv4 || true)
else
  PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4 || true)
fi

print_step "Done!"
if [ -n "$PUBLIC_IP" ]; then
  echo "Open your browser to: http://$PUBLIC_IP/"
else
  echo "Open your EC2 instance Public IPv4 address in a browser (http://YOUR_PUBLIC_IP/)"
fi

echo
print_note "Verify on the server:"
echo "  curl -I http://localhost    # should return HTTP/1.1 200 OK"
echo "  sudo docker compose logs --no-log-prefix --tail=50 backend"
echo "  sudo docker compose logs --no-log-prefix --tail=50 frontend"

echo
print_note "Manage the app:"
echo "  cd $APP_DIR"
echo "  sudo docker compose ps            # show status"
echo "  sudo docker compose logs -f       # follow logs"
echo "  sudo docker compose down          # stop"
echo "  sudo docker compose up -d         # start"

echo
print_note "To update code: edit files under $APP_DIR, then run:"
echo "  sudo docker compose build && sudo docker compose up -d"
EOF

chmod +x setup_todo_app.sh
```

Then run it:

```bash
./setup_todo_app.sh
```

**Expected highlights in output**

*   “Installing Docker and Docker Compose plugin”
*   “Building containers” → shows Node build and Python image steps
*   “Starting containers”
*   “Container status” → both `todo-frontend` and `todo-backend` **Up**
*   “Open your browser to: http\://YOUR\_PUBLIC\_IP/” (it tries to autodetect it)

### Option B — Download the script I prepared

I also created the script file for you here in chat:

*   **[setup\_todo\_app.sh](blob:https://www.microsoft365.com/da4e3145-d418-439a-b9cc-2d538163d422)**

If your client supports downloading attachments, grab it and upload it to your EC2 instance (e.g., `scp`), then:

```bash
chmod +x setup_todo_app.sh
./setup_todo_app.sh
```

***

## 3) Verify it’s running

On the EC2 instance:

```bash
curl -I http://localhost
# Expected: HTTP/1.1 200 OK

sudo docker compose -f ~/todo-app/docker-compose.yml ps
# Expected: both todo-frontend and todo-backend "Up"
```

From your laptop: open `http://YOUR_PUBLIC_IP/` → add a todo, toggle it, delete it.

***

## 4) Day‑2 operations (stop, start, update)

```bash
# Go to app folder
cd ~/todo-app

# Stop
sudo docker compose down

# Start
sudo docker compose up -d

# Logs (follow)
sudo docker compose logs -f

# Update after you edit any code
sudo docker compose build
sudo docker compose up -d
```

***

## 5) Troubleshooting (quick hits)

*   **Site doesn’t load**
    *   `sudo docker compose ps` → ensure both services are Up
    *   `sudo docker compose logs --tail=100 frontend`
    *   Security group must allow **HTTP (80)** from the internet.

*   **Backend issues**
    *   `sudo docker compose logs --tail=100 backend`
    *   If SQLite errors: reset data (⚠ deletes todos):  
        `sudo docker compose down -v && sudo docker compose up -d`

*   **Port 80 already in use**
    *   `sudo lsof -i :80` → stop the conflict (`sudo systemctl stop apache2` if present)

*   **Permission denied when running docker without sudo**
    *   You’ve been added to the `docker` group. Log out/in for it to apply, or keep using `sudo`.

***

## 6) What changed (and why it’s better)

*   We **route `/api/*` via Nginx** (in the frontend container) to the backend container using Docker’s internal network name `backend`.  
    → This makes your React app use **same-origin** requests (no CORS headaches) and you don’t need to hardcode the EC2 IP anywhere.

*   Only **port 80** is open to the world. The backend is not directly exposed.

***
