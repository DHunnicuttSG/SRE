# 🧪 Run a Python App Using Nginx (Quick Lab)

## 🧠 Key Concept (remember this)

> Nginx **does not run Python**  
> It **forwards requests** to a Python server (Gunicorn)

***

# 🧱 Architecture

    Browser → Nginx → Gunicorn → Python App → Response

***

# 🔧 Step 1: Install Dependencies

### Amazon Linux:

```bash
sudo yum install python3 -y
```

### Ubuntu:

```bash
sudo apt install python3-pip -y
```

***

# 📦 Step 2: Install Flask + Gunicorn

```bash
pip3 install flask gunicorn
```

***

# 🐍 Step 3: Create Python App

```bash
nano app.py
```

Paste:

```python
from flask import Flask
app = Flask(__name__)

@app.route("/")
def home():
    return "Hello from Python behind Nginx!"
```

***

# ▶️ Step 4: Run the App with Gunicorn

```bash
gunicorn --bind 127.0.0.1:8000 app:app
```

***

### ✅ Test locally:

```bash
curl http://127.0.0.1:8000
```

Expected:

    Hello from Python behind Nginx!

***

# 🌐 Step 5: Configure Nginx

Create config file:

```bash
sudo nano /etc/nginx/conf.d/app.conf
```

Paste:

```nginx
server {
    listen 80;

    location / {
        proxy_pass http://127.0.0.1:8000;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

***

# ✅ Step 6: Test and Restart Nginx

```bash
sudo nginx -t
sudo systemctl restart nginx
```

***

# 🌍 Step 7: Test in Browser

Go to:

    http://<your-ec2-public-ip>

✅ You should see:

    Hello from Python behind Nginx!

***

# ⚠️ Important Notes

### ✅ Keep Gunicorn running

If you close the terminal, it stops.

Run it in background:

```bash
nohup gunicorn --bind 127.0.0.1:8000 app:app &
```

***

### ✅ Open port 80 in AWS

Make sure your security group allows:

*   HTTP (port 80)

***

# ✅ Troubleshooting (VERY useful for students)

### Check Nginx logs:

```bash
sudo journalctl -u nginx -n 20
```

### Check app logs:

```bash
ps aux | grep gunicorn
```

***

# 🚀 Quick Mental Model

| Component | Job                          |
| --------- | ---------------------------- |
| Nginx     | Handles incoming web traffic |
| Gunicorn  | Runs Python app              |
| Flask     | Application logic            |

***

# 🧪 Minimal Working Flow Recap

1.  Create Python app
2.  Run with:
    ```bash
    gunicorn --bind 127.0.0.1:8000 app:app
    ```
3.  Configure Nginx → proxy to port 8000
4.  Restart Nginx
5.  Access via browser

***

# 🚀 Optional Upgrade (Great for Teaching)
