# ✅ **Project Linuz/Python/Flask — Step-by-Step Guide**

## **Python Flask “Hello, Cloud!” App with systemd (Amazon Linux 2023)**

Students will launch an EC2 instance, SSH into it, practice Linux fundamentals, install dependencies, deploy a simple Flask app, configure a systemd service to run it on startup, and test everything from a browser.

***

# 🧩 **Part 1 — Launch the EC2 Instance**

### **1. Log into AWS Console**

Navigate to **EC2 → Instances → Launch Instances**.

### **2. Configure the instance**

*   **Name:** `flask-mini-project`
*   **AMI:** *Amazon Linux 2023 (Free Tier eligible)*
*   **Instance type:** `t2.micro` or `t3.micro` (Free Tier)
*   **Key pair:** Create or choose an existing one (PEM)
*   **Network settings:**
    *   Allow SSH (port 22) from your IP
    *   Add rule: HTTP (port 80) from anywhere

### **3. Launch instance**

Wait until instance reaches **Running** state.

### **4. Retrieve the public IP**

You'll need it for SSH and browser testing.

***

# 🧩 **Part 2 — Connect via SSH**

### **1. Restrict private key permissions**

On your local machine:

```bash
chmod 400 mykey.pem
```

### **2. SSH into the instance**

Use:

```bash
ssh -i "mykey.pem" ec2-user@PUBLIC_IP
```

If successful, your prompt changes to something like:

    [ec2-user@ip-xx-xx-xx-xx ~]$

***

# 🧩 **Part 3 — Practice Basic Linux Commands**

Review: Have students run and observe each:

*   Navigation:
    ```bash
    pwd
    ls -l
    cd /var
    cd ~
    ```
*   File operations:
    ```bash
    mkdir myapp
    touch file.txt
    echo "hello" > file.txt
    cat file.txt
    cp file.txt file2.txt
    mv file2.txt data.txt
    rm data.txt
    ```
*   Permissions:
    ```bash
    ls -l
    chmod 755 file.txt
    ```
*   Searching:
    ```bash
    grep -i hello file.txt
    ```

These are not optional — they reinforce core Linux proficiency.

***

# 🧩 **Part 4 — Install Python + Dependencies**

### **1. Update packages**

```bash
sudo dnf update -y
```

### **2. Install Python 3, pip, and venv**

```bash
sudo dnf install python3 python3-pip -y
```

### **3. Verify versions**

```bash
python3 --version
pip3 --version
```

***

# 🧩 **Part 5 — Create Project Directory + Virtual Environment**

### **1. Make an app directory**

```bash
mkdir ~/flaskapp
cd ~/flaskapp
```

### **2. Create a virtual environment**

```bash
python3 -m venv venv
```

### **3. Activate it**

```bash
source venv/bin/activate
```

### **4. Install Flask**

```bash
pip install flask
```

***

# 🧩 **Part 6 — Create the Flask Application**

### **1. Create the app file**

```bash
nano app.py
```

### **2. Paste in the minimal Flask app**

```python
from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello from your EC2 Flask App!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
```

### **3. Save**

*   `CTRL + O`, press Enter
*   `CTRL + X`

***

# 🧩 **Part 7 — Test Flask App (Without systemd)**

While still in virtual environment:

```bash
python app.py
```

You should see:

    Running on http://0.0.0.0:5000/

### **Open the browser:**

    http://PUBLIC_IP:5000

If the page loads → working.

Stop the app:  
Press **CTRL+C**

***

# 🧩 **Part 8 — Create systemd Service to Run App Automatically**

### **1. Create a systemd unit file**

```bash
sudo nano /etc/systemd/system/flaskapp.service
```

### **2. Paste this configuration**

```ini
[Unit]
Description=Flask App Service
After=network.target

[Service]
User=ec2-user
WorkingDirectory=/home/ec2-user/flaskapp
Environment="PATH=/home/ec2-user/flaskapp/venv/bin"
ExecStart=/home/ec2-user/flaskapp/venv/bin/python /home/ec2-user/flaskapp/app.py

Restart=always

[Install]
WantedBy=multi-user.target
```

Save and exit (`CTRL+O`, Enter, `CTRL+X`).

### **3. Reload systemd**

```bash
sudo systemctl daemon-reload
```

### **4. Start the service**

```bash
sudo systemctl start flaskapp
```

### **5. Enable it on boot**

```bash
sudo systemctl enable flaskapp
```

### **6. Check service status**

```bash
sudo systemctl status flaskapp
```

You should see `active (running)`.

***

# 🧩 **Part 9 — Expose the App on Port 80**

Flask runs on port **5000**, but we want students to visit the app on standard HTTP port **80**.

Simplest approach: use an **iptables port forward**.

### **1. Allow OS to forward port 80 → 5000**

```bash
sudo dnf install iptables-services -y
```

```bash
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 5000
```

### **2. Save rules**

```bash
sudo service iptables save
```

***

# 🧩 **Part 10 — Test Application in Browser**

Visit:

    http://PUBLIC_IP

You should see:

    Hello from your EC2 Flask App!

***

# 🧩 **Part 11 — Common Troubleshooting Students Should Practice**

### **1. Port 80 not reachable**

*   Security Group missing inbound **HTTP (80)** rule
*   Wrong public IP
*   Local firewall blocking outbound

### **2. Flask service not running**

Check logs:

```bash
sudo journalctl -u flaskapp --no-pager -n 50
```

### **3. Permission errors**

Often caused by systemd running as the wrong user:

```bash
sudo chown -R ec2-user:ec2-user ~/flaskapp
```

### **4. Virtual environment path incorrect**

Verify:

```bash
ls ~/flaskapp/venv/bin/python
```

### **5. Flask not installed in venv**

Activate venv → reinstall:

```bash
source ~/flaskapp/venv/bin/activate
pip install flask
```

### **6. Service file syntax errors**

Look for typos in:

```bash
sudo nano /etc/systemd/system/flaskapp.service
```

Then:

```bash
sudo systemctl daemon-reload
```

***

# 🧩 **Part 12 — Demonstration Requirements**

To successfully complete the project, each student must show:

✔ They can launch an EC2 instance  
✔ They can SSH using a key pair  
✔ They demonstrate basic Linux commands  
✔ They install Python & Flask  
✔ They run the app manually  
✔ They deploy the app using systemd  
✔ The app works in a browser

**Challenge** 
* Add a database and a table with 3 records.
* Update your Python app to retrieve the data to the browser