**Nginx** (pronounced “engine-x”) is a **high-performance web server** and **reverse proxy server** commonly used on Linux systems.

***

## 🔍 What Nginx Does

At its core, Nginx is software that can:

### 🌐 1. Serve Websites (Web Server)

*   Delivers HTML, CSS, images, and other files to users' browsers
*   Similar role to Apache

Example:
When someone visits your EC2 instance’s IP, Nginx can serve a webpage.

***

### 🔁 2. Act as a Reverse Proxy

*   Receives requests from users
*   Forwards them to backend services (like a Node.js or Python app)
*   Sends the response back to the user

***

### ⚖️ 3. Load Balancing

*   Distributes incoming traffic across multiple servers
*   Helps handle high traffic efficiently

***

### 🔐 4. Handle HTTPS (SSL/TLS)

*   Manages secure encryption for websites
*   Works with certificates (like Let's Encrypt)

***

## 💡 Why Nginx is Popular

*   ⚡ Very fast and efficient
*   🧠 Handles many connections with low memory usage
*   🧰 Common in real-world production environments
*   ☁️ Frequently used on AWS EC2 instances

***

## 🧪 Basic Example on Your EC2 Instance

Install Nginx:

```bash
sudo yum install nginx -y     # Amazon Linux
# or
sudo apt install nginx -y     # Ubuntu
```

Start it:

```bash
sudo systemctl start nginx
```

Enable at boot:

```bash
sudo systemctl enable nginx
```

***

### ✅ Test It

Open your EC2 public IP in a browser:

    http://your-ec2-ip

You should see the **Nginx welcome page**.

***

## 🧠 Simple Analogy

Think of Nginx as:

> A **front desk receptionist** that:

*   Greets incoming visitors (requests)
*   Sends them to the right department (app/server)
*   Brings back the response

***

## 🔗 Why It Matters for Your Course

In your bash + Linux workflow, Nginx is useful for:

*   Hosting simple apps or pages
*   Practicing process monitoring (`ps`, `systemctl`)
*   Writing scripts to check service uptime
*   Automating service restarts (great for your later exercises)

***
