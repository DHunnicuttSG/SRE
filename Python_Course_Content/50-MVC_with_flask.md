# 🌐 Flask MVC Contact List App (with MySQL)

---

## 🧩 MVC Architecture Recap (Web Version)

| Component      | Description                       | Flask Equivalent                              |
| -------------- | --------------------------------- | --------------------------------------------- |
| **Model**      | Manages database interactions     | Python classes using `mysql.connector` or ORM |
| **View**       | Handles what the user sees        | HTML templates (Jinja2)                       |
| **Controller** | Routes and controls the app logic | Flask route functions                         |

---

## 🔹 1. Prerequisites

Install Flask and MySQL connector:

```bash
pip install flask mysql-connector-python
```

Set up the database (same as before):

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

## 🔹 2. Project Structure

```
flask_mvc_contacts/
│
├── app.py                 → Main Flask application (Controller)
├── model.py               → Database logic
├── templates/
│   ├── base.html
│   ├── index.html
│   ├── add_contact.html
│   └── delete_contact.html
└── static/
    └── style.css
```

---

## 🔹 3. The Model (`model.py`)

Handles database operations.

```python
# model.py
import mysql.connector

class ContactModel:
    def __init__(self):
        self.conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="password",   # update with your MySQL password
            database="contactdb"
        )
        self.cursor = self.conn.cursor(dictionary=True)

    def get_all_contacts(self):
        self.cursor.execute("SELECT * FROM contacts")
        return self.cursor.fetchall()

    def add_contact(self, name, phone, email):
        sql = "INSERT INTO contacts (name, phone, email) VALUES (%s, %s, %s)"
        self.cursor.execute(sql, (name, phone, email))
        self.conn.commit()

    def delete_contact(self, contact_id):
        sql = "DELETE FROM contacts WHERE id = %s"
        self.cursor.execute(sql, (contact_id,))
        self.conn.commit()

    def close(self):
        self.cursor.close()
        self.conn.close()
```

---

## 🔹 4. The Controller (`app.py`)

Handles user requests and connects Model ↔ View.

```python
# app.py
from flask import Flask, render_template, request, redirect, url_for
from model import ContactModel

app = Flask(__name__)
model = ContactModel()

@app.route('/')
def index():
    contacts = model.get_all_contacts()
    return render_template('index.html', contacts=contacts)

@app.route('/add', methods=['GET', 'POST'])
def add_contact():
    if request.method == 'POST':
        name = request.form['name']
        phone = request.form['phone']
        email = request.form['email']
        model.add_contact(name, phone, email)
        return redirect(url_for('index'))
    return render_template('add_contact.html')

@app.route('/delete/<int:contact_id>')
def delete_contact(contact_id):
    model.delete_contact(contact_id)
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(debug=True)
```

---

## 🔹 5. The Views (HTML Templates)

### 🧱 `templates/base.html`

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact Manager</title>
    <link rel="stylesheet" href="{{ url_for('static', filename='style.css') }}">
</head>
<body>
    <h1>📇 Contact Manager</h1>
    <nav>
        <a href="{{ url_for('index') }}">Home</a> |
        <a href="{{ url_for('add_contact') }}">Add Contact</a>
    </nav>
    <hr>
    {% block content %}{% endblock %}
</body>
</html>
```

---

### 🧱 `templates/index.html`

```html
{% extends "base.html" %}
{% block content %}
<h2>All Contacts</h2>
<table>
    <tr>
        <th>ID</th><th>Name</th><th>Phone</th><th>Email</th><th>Action</th>
    </tr>
    {% for c in contacts %}
    <tr>
        <td>{{ c.id }}</td>
        <td>{{ c.name }}</td>
        <td>{{ c.phone }}</td>
        <td>{{ c.email }}</td>
        <td><a href="{{ url_for('delete_contact', contact_id=c.id) }}">Delete</a></td>
    </tr>
    {% endfor %}
</table>
{% endblock %}
```

---

### 🧱 `templates/add_contact.html`

```html
{% extends "base.html" %}
{% block content %}
<h2>Add New Contact</h2>
<form method="POST">
    <label>Name:</label><br>
    <input type="text" name="name" required><br>
    <label>Phone:</label><br>
    <input type="text" name="phone" required><br>
    <label>Email:</label><br>
    <input type="email" name="email" required><br><br>
    <input type="submit" value="Add Contact">
</form>
{% endblock %}
```

---

## 🔹 6. Optional: Simple CSS (`static/style.css`)

```css
body {
    font-family: Arial, sans-serif;
    margin: 30px;
    background-color: #f4f6f9;
}

table {
    border-collapse: collapse;
    width: 80%;
    background: white;
    box-shadow: 0 0 5px #ccc;
}

td, th {
    border: 1px solid #ccc;
    padding: 8px;
}

nav a {
    margin-right: 10px;
    text-decoration: none;
    color: #007bff;
}

h1 {
    color: #333;
}
```

---

## 🔹 7. Run the App

```bash
python app.py
```

Then open your browser to:
👉 `http://127.0.0.1:5000/`

You’ll see:

* A homepage listing all contacts
* A form to add new contacts
* Delete links to remove contacts

---

## 🧠 Key Takeaways

| Layer          | Flask Component | Responsibility         |
| -------------- | --------------- | ---------------------- |
| **Model**      | `model.py`      | Database CRUD logic    |
| **View**       | `templates/`    | User interface (HTML)  |
| **Controller** | `app.py`        | Routing and logic flow |

✅ **MVC ensures clean separation of concerns**
✅ **Easier debugging and maintenance**
✅ **Ready to scale for larger web apps**

---
