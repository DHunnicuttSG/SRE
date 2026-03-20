Below is a **hands-on, step‑by‑step, production‑grade guide** to deploying a Python web app on an AWS EC2 instance, written exactly like a senior DevOps engineer would explain it to a new engineer.

This workflow takes you from **zero → a live web app reachable anywhere on the internet**.

***

# ✅ **1. EC2 SETUP — Launching the Instance**

### ✅ **1.1 Recommended OS**

Use an OS that is:

*   Stable
*   Well‑supported
*   Has systemd
*   Works smoothly with Python

✅ **Amazon Linux 2023** (recommended)  
✅ **Ubuntu Server 22.04 LTS** (also excellent)

Below, I’ll assume **Amazon Linux 2023**.

***

### ✅ **1.2 Launching the EC2 instance**

In AWS Console:

1.  Go to **EC2 → Instances → Launch Instance**
2.  Select AMI:  
    **Amazon Linux 2023 AMI**
3.  Instance type:  
    ✅ `t2.micro` / `t3.micro` (free tier or cheap)
4.  Key pair:  
    ✅ Create a new key pair → Download the `.pem` file  
    Keep it safe and *do not misplace it*.
5.  Network settings → Security Group:
    Add inbound rules:
        SSH        TCP 22      Your IP (recommended)
        HTTP       TCP 80      Anywhere (0.0.0.0/0)
    (Later, you may add HTTPS 443 if using SSL.)
6.  Storage: Default is fine.
7.  Launch the instance.

***

# ✅ **2. CONNECT TO THE INSTANCE (SSH)**

### ✅ Fix key permissions

```bash
chmod 400 mykey.pem
```

### ✅ SSH into EC2

```bash
ssh -i mykey.pem ec2-user@<EC2_PUBLIC_IP>
```

(If Ubuntu, user is `ubuntu`.)

***

# ✅ **3. ENVIRONMENT SETUP (Python, pip, venv)**

### ✅ Update packages

```bash
sudo dnf update -y
```

### ✅ Install Python 3 + venv + git

```bash
sudo dnf install -y python3 python3-pip python3-venv git
```

### ✅ Create a directory for your app

```bash
mkdir ~/myapp
cd ~/myapp
```

### ✅ Create a virtual environment

```bash
python3 -m venv venv
```

### ✅ Activate it

```bash
source venv/bin/activate
```

### ✅ Install Flask (or FastAPI)

```bash
pip install flask
```

***

# ✅ **4. CREATE A MINIMAL PYTHON WEB APP**

Create `app.py`:

```bash
nano app.py
```

Paste:

```python
from flask import Flask
app = Flask(__name__)

@app.route("/")
def home():
    return "Hello from your EC2 server! ✅"

if __name__ == "__main__":
    # IMPORTANT: Bind to 0.0.0.0 so it is reachable externally
    app.run(host="0.0.0.0", port=8000)
```

Save & exit (`CTRL+O`, `ENTER`, `CTRL+X`).

### ✅ Test the app

```bash
python app.py
```

Visit:  
`http://<EC2_PUBLIC_IP>:8000`

If you **cannot** reach it:

*   Add inbound rule for **TCP 8000** temporarily in security group.
*   Ensure app is binding to `0.0.0.0` (NOT `127.0.0.1`) — a common mistake.

***

# ✅ **5. RUNNING THE APP PERSISTENTLY USING systemd**

This is how professionals do it — reliable, monitored, auto‑starting.

### ✅ Create a systemd service file

```bash
sudo nano /etc/systemd/system/myapp.service
```

Paste:

```ini
[Unit]
Description=My Python Web App
After=network.target

[Service]
User=ec2-user
WorkingDirectory=/home/ec2-user/myapp
ExecStart=/home/ec2-user/myapp/venv/bin/python app.py
Restart=always
RestartSec=5
Environment="PATH=/home/ec2-user/myapp/venv/bin"

[Install]
WantedBy=multi-user.target
```

Save & exit.

### ✅ Reload systemd and start the service

```bash
sudo systemctl daemon-reload
sudo systemctl start myapp
sudo systemctl enable myapp
```

### ✅ Check status

```bash
systemctl status myapp
```

### ✅ View logs

```bash
journalctl -u myapp -f
```

⚠️ **Without systemd, your app stops the moment you disconnect SSH.**

***

# ✅ **6. ACCESSING THE APP FROM ANYWHERE**

### ✅ Find your EC2 Public IP

In AWS Console → EC2 → Instances → Public IPv4 address  
Example: `3.91.128.55`

Or from instance:

```bash
curl ifconfig.me
```

### ✅ Check your browser

Visit:

    http://<EC2_PUBLIC_IP>:8000

You should see:

    Hello from your EC2 server! ✅

***

# ✅ **Optional: Use Port 80 Instead of 8000**

If you want your app reachable at:

    http://<PUBLIC_IP>

Update the app to use port 80:

```python
app.run(host="0.0.0.0", port=80)
```

Then update systemd:

```ini
ExecStart=/home/ec2-user/myapp/venv/bin/python app.py
```

⚠️ **Port 80 requires root permissions — best practice: reverse proxy with Nginx.**

***

# ✅ **COMMON MISTAKES (Read This!)**

✅ **App binds to 127.0.0.1**  
You must bind `0.0.0.0` or the world cannot reach it.

✅ **Forgot to open ports in security group**  
Allow inbound:

*   TCP 22 (SSH)
*   TCP 80 (HTTP)
*   TCP 8000 (only if using that)

✅ **Service not starting after edit**  
You must run:

    sudo systemctl daemon-reload

✅ **App stops after SSH disconnect**  
Use **systemd**, not `python app.py` in foreground.

✅ **Firewall on instance blocking ports**  
Amazon Linux normally does not enable firewalld by default — but if using Ubuntu:

    sudo ufw allow 8000
    sudo ufw allow 80

***

# ✅ **YOU NOW HAVE A WORKING PYTHON APP LIVE ON AWS EC2** ✅
