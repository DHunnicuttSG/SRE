***

# ✅ **Deploying a Full CRUD Flask + SQLite Contact List Backend in Docker on AWS EC2**

### Includes: Create, Read, Update, Delete operations

***

# **1. Prerequisites**

## **1.1 Launch an EC2 Instance (Amazon Linux 2023 or Amazon Linux 2)**

Settings:

*   **AMI**: Amazon Linux 2023 (or latest)
*   **Instance type**: t2.micro
*   **Key pair**: Create or select one
*   **Storage**: Default is fine

## **1.2 Configure Security Group**

Allow inbound:

| Port     | Purpose                                 |
| -------- | --------------------------------------- |
| **22**   | SSH                                     |
| **5000** | Flask API exposed from Docker container |

Rules to add:

*   SSH — TCP 22 — Your IP
*   Custom TCP — TCP 5000 — 0.0.0.0/0 (or your IP for more security)

## **1.3 SSH into the EC2 Instance**

```bash
ssh -i your-key.pem ec2-user@EC2_PUBLIC_IP
```

***

# **2. Install Docker on Amazon Linux**

## **2.1 Update packages**

```bash
sudo dnf update -y
```

## **2.2 Install Docker**

```bash
sudo dnf install docker -y
```

## **2.3 Start and enable Docker**

```bash
sudo systemctl enable docker
sudo systemctl start docker
```

## **2.4 Add ec2-user to the docker group**

```bash
sudo usermod -aG docker ec2-user
```

Log out and back in:

```bash
exit
ssh -i your-key.pem ec2-user@EC2_PUBLIC_IP
```

***

# **3. Create the Python CRUD Application**

Create a project folder:

```bash
mkdir contact-app
cd contact-app
```

***

# ✅ **3.1 Full CRUD Flask App (`app.py`)**

Create the file:

```bash
nano app.py
```

Paste the following **full CRUD implementation**:

```python
from flask import Flask, request, jsonify
import sqlite3

app = Flask(__name__)
DB = "database.db"

def init_db():
    conn = sqlite3.connect(DB)
    cursor = conn.cursor()
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS contacts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            first_name TEXT NOT NULL,
            last_name TEXT NOT NULL,
            company TEXT,
            email TEXT,
            phone TEXT
        )
    """)
    conn.commit()
    conn.close()

# ---------- CREATE ----------
@app.route('/contacts', methods=['POST'])
def create_contact():
    data = request.json
    conn = sqlite3.connect(DB)
    cursor = conn.cursor()
    cursor.execute("""
        INSERT INTO contacts (first_name, last_name, company, email, phone)
        VALUES (?, ?, ?, ?, ?)
    """, (
        data['first_name'],
        data['last_name'],
        data.get('company'),
        data.get('email'),
        data.get('phone')
    ))
    conn.commit()
    conn.close()
    return jsonify({"message": "Contact created"}), 201

# ---------- READ ALL ----------
@app.route('/contacts', methods=['GET'])
def read_contacts():
    conn = sqlite3.connect(DB)
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM contacts")
    rows = cursor.fetchall()
    conn.close()

    contacts = [
        {
            "id": row[0],
            "first_name": row[1],
            "last_name": row[2],
            "company": row[3],
            "email": row[4],
            "phone": row[5]
        }
        for row in rows
    ]

    return jsonify(contacts), 200

# ---------- READ ONE ----------
@app.route('/contacts/<int:id>', methods=['GET'])
def read_contact(id):
    conn = sqlite3.connect(DB)
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM contacts WHERE id = ?", (id,))
    row = cursor.fetchone()
    conn.close()

    if not row:
        return jsonify({"error": "Contact not found"}), 404

    contact = {
        "id": row[0],
        "first_name": row[1],
        "last_name": row[2],
        "company": row[3],
        "email": row[4],
        "phone": row[5]
    }

    return jsonify(contact), 200

# ---------- UPDATE ----------
@app.route('/contacts/<int:id>', methods=['PUT'])
def update_contact(id):
    data = request.json

    conn = sqlite3.connect(DB)
    cursor = conn.cursor()
    cursor.execute("""
        UPDATE contacts
        SET first_name=?, last_name=?, company=?, email=?, phone=?
        WHERE id=?
    """, (
        data['first_name'],
        data['last_name'],
        data.get('company'),
        data.get('email'),
        data.get('phone'),
        id
    ))
    conn.commit()

    if cursor.rowcount == 0:
        conn.close()
        return jsonify({"error": "Contact not found"}), 404

    conn.close()
    return jsonify({"message": "Contact updated"}), 200

# ---------- DELETE ----------
@app.route('/contacts/<int:id>', methods=['DELETE'])
def delete_contact(id):
    conn = sqlite3.connect(DB)
    cursor = conn.cursor()
    cursor.execute("DELETE FROM contacts WHERE id = ?", (id,))
    conn.commit()

    if cursor.rowcount == 0:
        conn.close()
        return jsonify({"error": "Contact not found"}), 404

    conn.close()
    return jsonify({"message": "Contact deleted"}), 200

if __name__ == "__main__":
    init_db()
    app.run(host="0.0.0.0", port=5000)
```

✅ Contains **CREATE**, **READ (all & by ID)**, **UPDATE**, **DELETE**.

***

# **3.2 Create `requirements.txt`**

```bash
nano requirements.txt
```

    Flask==3.0.0

***

# **3.3 Create Dockerfile**

```bash
nano Dockerfile
```

```dockerfile
FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
```

***

# **4. Build the Docker Image**

```bash
docker build -t contact-backend .
```

***

# **5. Run the Container**

```bash
docker run -d -p 5000:5000 --name contact-api contact-backend
```

Check container:

```bash
docker ps
```

***

# ✅ **6. Test the Full CRUD API**

Replace `EC2_PUBLIC_IP` with your instance's public IP.

***

## ✅ **6.1 CREATE a Contact**

```bash
curl -X POST http://EC2_PUBLIC_IP:5000/contacts \
  -H "Content-Type: application/json" \
  -d '{
    "first_name":"Alice",
    "last_name":"Smith",
    "company":"Acme",
    "email":"alice@example.com",
    "phone":"555-1111"
  }'
```

***

## ✅ **6.2 READ All Contacts**

```bash
curl http://EC2_PUBLIC_IP:5000/contacts
```

***

## ✅ **6.3 READ One Contact**

```bash
curl http://EC2_PUBLIC_IP:5000/contacts/1
```

***

## ✅ **6.4 UPDATE a Contact**

```bash
curl -X PUT http://EC2_PUBLIC_IP:5000/contacts/1 \
  -H "Content-Type: application/json" \
  -d '{
    "first_name":"Alice",
    "last_name":"Williams",
    "company":"Acme",
    "email":"alice@new.com",
    "phone":"555-2222"
  }'
```

***

## ✅ **6.5 DELETE a Contact**

```bash
curl -X DELETE http://EC2_PUBLIC_IP:5000/contacts/1
```

***

# ✅ **Your fully containerized CRUD API is deployed successfully!**
