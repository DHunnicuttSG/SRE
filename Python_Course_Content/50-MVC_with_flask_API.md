# 🧩 Flask REST API – Contact Manager with MySQL (MVC-Style Backend)

---

## 🧱 Overview

We’ll refactor the MVC app so that:

* **Model** = Database logic
* **Controller (Routes)** = Flask API endpoints
* **View** = JSON responses

---

## 🔹 1. Install Dependencies

```bash
pip install flask mysql-connector-python flask-cors
```

✅ `flask-cors` allows cross-origin requests (helpful for connecting frontend apps like React).

---

## 🔹 2. Database Setup (same as before)

```sql
CREATE DATABASE contactdb;
USE contactdb;

CREATE TABLE contacts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100)
);
```

---

## 🔹 3. Project Structure

```
flask_rest_contacts/
│
├── app.py            → Main Flask app (Controller)
├── model.py          → Database operations (Model)
└── config.py         → Database configuration
```

---

## 🔹 4. Database Configuration (`config.py`)

```python
# config.py

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "password",  # update this!
    "database": "contactdb"
}
```

---

## 🔹 5. The Model (`model.py`)

Handles all database interactions.

```python
# model.py
import mysql.connector
from config import DB_CONFIG

class ContactModel:
    def __init__(self):
        self.conn = mysql.connector.connect(**DB_CONFIG)
        self.cursor = self.conn.cursor(dictionary=True)

    def get_all_contacts(self):
        self.cursor.execute("SELECT * FROM contacts")
        return self.cursor.fetchall()

    def get_contact(self, contact_id):
        self.cursor.execute("SELECT * FROM contacts WHERE id = %s", (contact_id,))
        return self.cursor.fetchone()

    def add_contact(self, name, phone, email):
        sql = "INSERT INTO contacts (name, phone, email) VALUES (%s, %s, %s)"
        self.cursor.execute(sql, (name, phone, email))
        self.conn.commit()
        return self.cursor.lastrowid

    def update_contact(self, contact_id, name, phone, email):
        sql = "UPDATE contacts SET name=%s, phone=%s, email=%s WHERE id=%s"
        self.cursor.execute(sql, (name, phone, email, contact_id))
        self.conn.commit()
        return self.cursor.rowcount

    def delete_contact(self, contact_id):
        self.cursor.execute("DELETE FROM contacts WHERE id=%s", (contact_id,))
        self.conn.commit()
        return self.cursor.rowcount

    def __del__(self):
        self.cursor.close()
        self.conn.close()
```

---

## 🔹 6. Flask API (`app.py`)

Implements RESTful endpoints for CRUD operations.

```python
# app.py
from flask import Flask, jsonify, request
from flask_cors import CORS
from model import ContactModel

app = Flask(__name__)
CORS(app)
model = ContactModel()

@app.route('/api/contacts', methods=['GET'])
def get_contacts():
    contacts = model.get_all_contacts()
    return jsonify(contacts), 200

@app.route('/api/contacts/<int:contact_id>', methods=['GET'])
def get_contact(contact_id):
    contact = model.get_contact(contact_id)
    if contact:
        return jsonify(contact), 200
    return jsonify({"error": "Contact not found"}), 404

@app.route('/api/contacts', methods=['POST'])
def add_contact():
    data = request.get_json()
    name = data.get('name')
    phone = data.get('phone')
    email = data.get('email')
    contact_id = model.add_contact(name, phone, email)
    return jsonify({"message": "Contact added", "id": contact_id}), 201

@app.route('/api/contacts/<int:contact_id>', methods=['PUT'])
def update_contact(contact_id):
    data = request.get_json()
    name = data.get('name')
    phone = data.get('phone')
    email = data.get('email')
    updated = model.update_contact(contact_id, name, phone, email)
    if updated:
        return jsonify({"message": "Contact updated"}), 200
    return jsonify({"error": "Contact not found"}), 404

@app.route('/api/contacts/<int:contact_id>', methods=['DELETE'])
def delete_contact(contact_id):
    deleted = model.delete_contact(contact_id)
    if deleted:
        return jsonify({"message": "Contact deleted"}), 200
    return jsonify({"error": "Contact not found"}), 404

if __name__ == '__main__':
    app.run(debug=True)
```

---

## 🔹 7. Test the API

You can test using **Postman**, **curl**, or **VSCode REST Client**.

### ✅ Get All Contacts

```bash
GET http://127.0.0.1:5000/api/contacts
```

### ✅ Get Single Contact

```bash
GET http://127.0.0.1:5000/api/contacts/1
```

### ✅ Add Contact

```bash
POST http://127.0.0.1:5000/api/contacts
Content-Type: application/json

{
  "name": "Alice",
  "phone": "555-6789",
  "email": "alice@example.com"
}
```

### ✅ Update Contact

```bash
PUT http://127.0.0.1:5000/api/contacts/1
Content-Type: application/json

{
  "name": "Alice Johnson",
  "phone": "555-9999",
  "email": "alice.j@example.com"
}
```

### ✅ Delete Contact

```bash
DELETE http://127.0.0.1:5000/api/contacts/1
```

---

## 🔹 8. MVC Layer Roles Recap (API Version)

| Layer          | File           | Role                      |
| -------------- | -------------- | ------------------------- |
| **Model**      | `model.py`     | Handles MySQL CRUD        |
| **View**       | JSON responses | Client-visible API output |
| **Controller** | `app.py`       | Routes and logic flow     |

---

## 🧠 Key Learning Points

* Flask makes it easy to create **RESTful APIs**.
* `request.get_json()` reads JSON payloads from the client.
* The **Model** layer abstracts database logic.
* JSON responses let you integrate with web or mobile frontends.
* Use `CORS` for secure cross-domain communication.

---

## 🚀 Extension Ideas

1. Add **search endpoints** (filter by name or email).
2. Implement **pagination** for large contact lists.
3. Add **user authentication** (JWT or Flask-Login).
4. Deploy to **AWS / Render / Railway** for production use.

---
