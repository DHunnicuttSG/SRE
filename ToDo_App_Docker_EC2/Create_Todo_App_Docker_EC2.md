
*   **Backend:** Python + **FastAPI** (simple, fast, great docs)
*   **Frontend:** **React**
*   **Containerization:** **Docker** + **Docker Compose**
*   **Compute:** **AWS EC2** (Ubuntu)
*   **Data:** SQLite (file-based DB) for simplicity

> 🧭 **How to use this guide:** Follow phases in order. Every step includes *commands*, *what they do*, *expected output*, *verification*, and *troubleshooting*. No prior AWS or Docker experience needed.

***

## Phase 1 — Create Your AWS Account (if needed)

1.  **Sign up for AWS**
    *   Go to: <https://aws.amazon.com/> → **Create an AWS Account**
    *   Enter email, set a password, and a unique account name.
    *   Choose **Personal** unless it’s a company account.
    *   Add a payment method (you’ll get **Free Tier** eligibility).
    *   Verify your phone and complete identity steps.
    *   Choose **Basic support** (free).
    *   After completion, sign in to the **AWS Management Console**: <https://console.aws.amazon.com/>

**Why:** You need an AWS account to create resources like EC2 (virtual servers).

**Verify:** You see the AWS Console home page and your account name in the top-right.

***

## Phase 2 — Launch an EC2 Instance (your virtual server)

1.  **Open EC2**
    *   From Console, search for **EC2** → open the EC2 service.

2.  **Launch Instance**
    *   Click **Launch instance**.
    *   **Name:** `todo-ec2`
    *   **Application and OS Images (AMI):** Choose **Ubuntu Server 22.04 LTS** (free tier eligible).
    *   **Instance type:** `t2.micro` or `t3.micro` (Free Tier).
    *   **Key pair (login):**
        *   Click **Create new key pair** → Name: `todo-key` → Type: **RSA** → Format: **.pem** → **Create key pair**.
        *   This downloads `todo-key.pem`. **Keep it safe.**
    *   **Network settings → Edit:**
        *   **Allow SSH (22)** from **My IP** (more secure).
        *   **Add security group rule** → **HTTP (80)** → **Anywhere** (0.0.0.0/0).
    *   **Storage:** Default (8GB) is fine.
    *   Click **Launch instance**.

**Why:** EC2 is your cloud VM. The **security group** is a virtual firewall allowing SSH for admin and HTTP for your website.

**Verify:** On **Instances** page, your instance shows **Running** and has a public IPv4 address (e.g., `3.85.x.x`).

***

## Phase 3 — Connect via SSH (secure shell)

> **Prerequisites:** You have `todo-key.pem` and know your instance’s **Public IPv4 address**.

1.  **Set permissions for key (Mac/Linux)**

```bash
chmod 400 ~/Downloads/todo-key.pem
```

*   **What it does:** Restricts the file so only you can read it; SSH requires this.

2.  **SSH into the instance**

```bash
ssh -i ~/Downloads/todo-key.pem ubuntu@YOUR_PUBLIC_IP
```

*   Replace `YOUR_PUBLIC_IP` with the IPv4 address from EC2.
*   **Expected output:** On first connect, it asks to trust the fingerprint — type `yes`. Then your prompt becomes:
        ubuntu@ip-...:~$

**Troubleshooting**

*   `Permission denied (publickey)`: Ensure username is **ubuntu** and key path is correct; re-run `chmod 400`.
*   Timeout: Check security group has **SSH (22)** open from your IP.

***

## Phase 4 — Install Docker & Docker Compose

> **Docker** packages your app + dependencies into containers. **Docker Compose** runs multiple containers together (frontend + backend).

1.  **Update packages**

```bash
sudo apt-get update -y && sudo apt-get upgrade -y
```

*   **Why:** Ensures latest security fixes and package lists.

2.  **Install Docker**

```bash
sudo apt-get install -y docker.io
```

*   **Verify:**

```bash
docker --version
# Expected: Docker version 24.x or similar
```

3.  **Enable and start Docker**

```bash
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker
# Expect: Active: active (running)
```

4.  **Run Docker without sudo (optional, recommended)**

```bash
sudo usermod -aG docker $USER
newgrp docker
docker ps
# Should not say "permission denied"; expect an empty list or header line.
```

5.  **Install Docker Compose (v2 is built into Docker as docker compose)**

```bash
docker compose version
# Expected: Docker Compose version v2.x.x
```

If that fails:

```bash
sudo apt-get install -y docker-compose
docker-compose --version
```

**Troubleshooting**

*   `Cannot connect to the Docker daemon`: ensure Docker is running (`sudo systemctl start docker`), or add user to `docker` group (above).

***

## Phase 5 — Project Structure

We’ll keep everything under `/home/ubuntu/todo-app`.

```bash
mkdir -p ~/todo-app/backend ~/todo-app/frontend
cd ~/todo-app
```

**Final structure** (we’ll create these files soon):

    todo-app/
      docker-compose.yml
      backend/
        app.py
        requirements.txt
        Dockerfile
        todos.db        # auto-created at runtime
      frontend/
        package.json
        src/
          index.js
          App.js
        public/
          index.html
        Dockerfile

***

## Phase 6 — Build the Backend (FastAPI + SQLite)

### 6.1 Create backend files

```bash
cd ~/todo-app/backend
```

**requirements.txt**

```bash
cat > requirements.txt << 'EOF'
fastapi==0.110.0
uvicorn[standard]==0.27.1
sqlalchemy==2.0.25
pydantic==2.6.1
EOF
```

*   **Why:** Lists Python packages so Docker can install them.

**app.py**

```bash
cat > app.py << 'EOF'
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from sqlalchemy import Column, Integer, String, Boolean, create_engine
from sqlalchemy.orm import declarative_base, sessionmaker

# Database setup (SQLite file)
DATABASE_URL = "sqlite:///./todos.db"
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

# CORS: allow frontend (React) to call backend from a different port
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # For learning; in production, set to your domain/origin
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
EOF
```

**Dockerfile**

```bash
cat > Dockerfile << 'EOF'
# 1) Use a lightweight Python image
FROM python:3.11-slim

# 2) Set working directory inside the container
WORKDIR /app

# 3) Copy dependency file first (better layer caching)
COPY requirements.txt /app/requirements.txt

# 4) Install system updates and Python deps
RUN pip install --no-cache-dir -r /app/requirements.txt

# 5) Copy application code
COPY . /app

# 6) Expose port 8000 (FastAPI default here)
EXPOSE 8000

# 7) Command to run the app using Uvicorn (ASGI server)
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
EOF
```

**What each line does:**

1.  **FROM**: Picks a base OS+Python environment.
2.  **WORKDIR**: Sets `/app` as the working folder.
3.  **COPY requirements.txt**: Copy deps to leverage Docker caching.
4.  **RUN pip install**: Install Python dependencies inside the image.
5.  **COPY . /app**: Copy your code into the image.
6.  **EXPOSE 8000**: Declares the internal port the app listens on.
7.  **CMD**: Default command to start FastAPI server.

**Quick local test (optional)**
We’ll test via Compose in Phase 9.

***

## Phase 7 — Build the Frontend (React)

### 7.1 Initialize React app

```bash
cd ~/todo-app/frontend

# Install Node & npm if missing (Ubuntu)
sudo apt-get install -y nodejs npm
node -v && npm -v  # verify versions

# Create React skeleton (without interactive prompts)
npx create-react-app . --use-npm
```

**Expected output:** A lot of files created, ending with:

    Happy hacking!

### 7.2 Replace default files

**src/App.js**

```bash
cat > src/App.js << 'EOF'
import React, { useEffect, useState } from 'react';

const API_BASE = process.env.REACT_APP_API_BASE || 'http://localhost:8000';

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
      alert('Failed to fetch todos. Check backend URL.');
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

  useEffect(() => {
    fetchTodos();
  }, []);

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
EOF
```

**src/index.js**

```bash
cat > src/index.js << 'EOF'
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(<App />);
EOF
```

**public/index.html**

```bash
cat > public/index.html << 'EOF'
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
EOF
```

### 7.3 Frontend Dockerfile

```bash
cat > Dockerfile << 'EOF'
# 1) Build stage: build static files with Node
FROM node:18-alpine AS build

# 2) Set working directory
WORKDIR /app

# 3) Copy package files and install deps first (cache layer)
COPY package.json package-lock.json* ./
RUN npm install

# 4) Copy rest of the source and build
COPY . .
# REACT_APP_API_BASE will be passed at runtime in docker-compose
RUN npm run build

# 5) Serve stage: use Nginx to serve static files
FROM nginx:alpine

# 6) Copy build artifacts to Nginx html directory
COPY --from=build /app/build /usr/share/nginx/html

# 7) Expose port 80 for HTTP
EXPOSE 80

# 8) Default command to run Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
EOF
```

**What each line does:**

*   First image (**node**) compiles the React app into static files.
*   Second image (**nginx**) serves those files efficiently.
*   **EXPOSE 80**: Nginx listens on port 80.

***

## Phase 8 — Create `docker-compose.yml` to Orchestrate Both

```bash
cd ~/todo-app
cat > docker-compose.yml << 'EOF'
version: "3.9"

services:
  backend:
    build: ./backend
    container_name: todo-backend
    ports:
      - "8000:8000"         # host:container
    volumes:
      - ./backend:/app      # live mount for easy dev
      - backend_data:/app   # ensure SQLite file persists in container path
    restart: unless-stopped

  frontend:
    build: ./frontend
    container_name: todo-frontend
    ports:
      - "80:80"             # expose website on standard HTTP
    environment:
      - REACT_APP_API_BASE=http://localhost:8000
    depends_on:
      - backend
    restart: unless-stopped

volumes:
  backend_data:
EOF
```

**Explanations:**

*   **services.backend** builds and runs FastAPI on 8000.
*   **services.frontend** builds and serves React via Nginx on 80.
*   **depends\_on** makes frontend wait for backend to start.
*   **REACT\_APP\_API\_BASE** tells the frontend where to call the backend.
*   **ports** map container ports to EC2’s host ports so you can reach them.

***

## Phase 9 — Build and Run the Stack

1.  **Build images**

```bash
cd ~/todo-app
docker compose build
```

*   **Expected:** Logs ending with `Successfully built` for both services.

2.  **Run containers**

```bash
docker compose up -d
```

*   `-d` runs in background.
*   **Verify:**

```bash
docker compose ps
# Expect both todo-backend and todo-frontend "Up"
```

3.  **Check logs (optional)**

```bash
docker logs todo-backend --tail=50
docker logs todo-frontend --tail=50
```

*   Backend should show Uvicorn starting on `0.0.0.0:8000`.
*   Frontend (Nginx) should serve from `/usr/share/nginx/html`.

***

## Phase 10 — Open Security Group for HTTP (already done) & Test

You already added **HTTP (80)** earlier. If not:

*   Go to **EC2 → Instances → your instance → Security → Security groups** → **Edit inbound rules** → Add **HTTP (80)** from **Anywhere**.

### Test in Browser

*   Open: `http://YOUR_PUBLIC_IP/`
*   You should see **Todo List** app.

### Test API directly (optional)

*   Open: `http://YOUR_PUBLIC_IP:8000/todos`
    *   Expected: `[]` initially (empty list).

### Add a Todo

*   In the UI, type “Learn Docker” → **Add** → It appears in the list.
*   Click on text to toggle **completed** (line-through).
*   Click **Delete** to remove.

***

## Phase 11 — Verifications at Each Step

*   **SSH:** Prompt shows `ubuntu@...$`.
*   **Docker installed:** `docker --version` prints version.
*   **Compose running:** `docker compose ps` shows both services **Up**.
*   **Backend health:** `curl http://localhost:8000/todos` from the EC2 SSH session should output `[]` or a JSON list.
*   **Frontend health:** `curl -I http://localhost` returns `200 OK` (Nginx).

Commands:

```bash
# From EC2 terminal:
curl http://localhost:8000/todos
# -> [] (JSON)

curl -I http://localhost
# -> HTTP/1.1 200 OK
```

***

## Phase 12 — Common Troubleshooting (Beginner-Friendly)

1.  **Site not loading**
    *   Check containers: `docker compose ps`
    *   Check Nginx logs: `docker logs todo-frontend`
    *   Verify security group has **HTTP (80)** open.

2.  **Backend errors**
    *   `docker logs todo-backend` for Python tracebacks.
    *   If `sqlite3.OperationalError`: ensure write permissions; the volume mapping is set. You can wipe volumes:  
        `docker compose down -v` (⚠ deletes data), then `docker compose up -d`.

3.  **CORS errors in browser console**
    *   Ensure **CORS** middleware is present (it is), and **REACT\_APP\_API\_BASE** equals `http://localhost:8000` because from the container’s perspective it calls via the host mapping. Our browser calls the frontend (port 80) which then calls backend at `http://YOUR_PUBLIC_IP:8000`. Because we used absolute URLs pointing to localhost, the call originates from your browser to YOUR\_PUBLIC\_IP:8000. This works since CORS allows `*`.
    *   If you want the frontend to explicitly call the same host: change `REACT_APP_API_BASE` to `http://YOUR_PUBLIC_IP:8000` in `docker-compose.yml` and rebuild.

4.  **Port already in use**
    *   `sudo lsof -i :80` to see what’s using 80.
    *   Stop conflicting service: `sudo systemctl stop apache2` if installed accidentally.

5.  **Permission denied for SSH key**
    *   Run `chmod 400` on key file; ensure `ubuntu` user.

6.  **Slow builds**
    *   Check your instance type and network; Free Tier can be slow. Be patient or rebuild once.

***

## Phase 13 — Stop, Start, and Update the App

**Stop the stack**

```bash
cd ~/todo-app
docker compose down
```

**Start the stack**

```bash
docker compose up -d
```

**Update backend code**

1.  Edit `~/todo-app/backend/app.py`.
2.  Rebuild only backend:

```bash
docker compose build backend
docker compose up -d
```

**Update frontend code**

1.  Edit React files under `~/todo-app/frontend/src`.
2.  Rebuild only frontend:

```bash
docker compose build frontend
docker compose up -d
```

**View logs while running**

```bash
docker compose logs -f
```

***

## Phase 14 — Basic Security Notes (Beginner-Friendly)

*   Keep **SSH** open to **My IP** (not 0.0.0.0/0) — you already set this during launch.
*   Use **key pair** auth (we did). Don’t share the `.pem` file.
*   Use **security groups** as your first firewall: only open **80** (HTTP) to the world for this demo.
*   For production:
    *   Use a domain + HTTPS via a reverse proxy (e.g., Nginx + Let’s Encrypt).
    *   Restrict CORS (`allow_origins` to your domain).
    *   Use managed databases (e.g., RDS/Postgres) rather than SQLite.

***

## Phase 15 — (Optional) Use a Domain Name

*   Assign an **Elastic IP** to keep a static public IP.
*   Point your domain’s **A record** to the Elastic IP.
*   Then access `http://yourdomain.com`.

***

## What You Built (Recap)

*   A **FastAPI** backend providing CRUD endpoints:
    *   `GET /todos`
    *   `POST /todos`
    *   `PUT /todos/{id}`
    *   `DELETE /todos/{id}`
*   A **React** frontend that talks to the backend via REST.
*   Both run as **Docker containers** on an **EC2 Ubuntu** instance.
*   You can **start**, **stop**, **update**, and **debug** using `docker compose`.

***

## Quick Command Cheat Sheet

```bash
# Connect
ssh -i ~/Downloads/todo-key.pem ubuntu@YOUR_PUBLIC_IP

# Docker basics
docker --version
docker compose version
docker compose ps
docker compose logs -f

# Build and run
cd ~/todo-app
docker compose build
docker compose up -d

# Test from server
curl http://localhost:8000/todos
curl -I http://localhost

# Stop / remove
docker compose down
docker compose down -v   # also removes volumes (DB wiped)

# Rebuild specific service
docker compose build backend
docker compose build frontend
docker compose up -d
```
