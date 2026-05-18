# 🧩 MVC Architecture in Python — Building a Contact List App (MySQL)

---

## 🔹 What Is MVC?

**MVC** stands for:

* **Model** – manages data and database logic
* **View** – handles display (user interface)
* **Controller** – coordinates between Model and View

✅ **Purpose:**
It separates responsibilities so your code is easier to maintain, test, and expand.

---

### 🧠 MVC Flow Diagram

```
User Input → Controller → Model → Database
                 ↓
               View ← Output
```

---

## 🔹 Example App: Contact List Manager

We’ll build a simple **command-line MVC app** that:

* Stores contacts in a MySQL database
* Can add, view, and delete contacts

---

## 🔹 1. Prerequisites

Install required packages:

```bash
pip install mysql-connector-python
```

And make sure MySQL is running.

Create a database:

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
mvc_contact_app/
│
├── model.py        → Handles database logic
├── view.py         → Handles user interface
├── controller.py   → Connects model & view
└── main.py         → Entry point
```

---

## 🔹 3. The Model (model.py)

This layer handles all database operations.

```python
# model.py
import mysql.connector

class ContactModel:
    def __init__(self):
        self.conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="password",   # change to your MySQL password
            database="contactdb"
        )
        self.cursor = self.conn.cursor()

    def add_contact(self, name, phone, email):
        sql = "INSERT INTO contacts (name, phone, email) VALUES (%s, %s, %s)"
        self.cursor.execute(sql, (name, phone, email))
        self.conn.commit()

    def get_all_contacts(self):
        self.cursor.execute("SELECT * FROM contacts")
        return self.cursor.fetchall()

    def delete_contact(self, contact_id):
        sql = "DELETE FROM contacts WHERE id = %s"
        self.cursor.execute(sql, (contact_id,))
        self.conn.commit()

    def close(self):
        self.conn.close()
```

---

## 🔹 4. The View (view.py)

This layer manages **how information is shown to the user**.

```python
# view.py

class ContactView:
    def show_menu(self):
        print("\n==== Contact Manager ====")
        print("1. View all contacts")
        print("2. Add new contact")
        print("3. Delete a contact")
        print("4. Exit")
        return input("Choose an option: ")

    def show_contacts(self, contacts):
        print("\n---- Contact List ----")
        for c in contacts:
            print(f"ID: {c[0]} | Name: {c[1]} | Phone: {c[2]} | Email: {c[3]}")
        print("-----------------------")

    def get_contact_details(self):
        name = input("Enter name: ")
        phone = input("Enter phone: ")
        email = input("Enter email: ")
        return name, phone, email

    def get_contact_id(self):
        return input("Enter contact ID to delete: ")

    def show_message(self, message):
        print(message)
```

---

## 🔹 5. The Controller (controller.py)

This layer **connects the Model and View** and manages the app’s logic.

```python
# controller.py
from model import ContactModel
from view import ContactView

class ContactController:
    def __init__(self):
        self.model = ContactModel()
        self.view = ContactView()

    def run(self):
        while True:
            choice = self.view.show_menu()

            if choice == "1":
                contacts = self.model.get_all_contacts()
                self.view.show_contacts(contacts)

            elif choice == "2":
                name, phone, email = self.view.get_contact_details()
                self.model.add_contact(name, phone, email)
                self.view.show_message("Contact added successfully!")

            elif choice == "3":
                contact_id = self.view.get_contact_id()
                self.model.delete_contact(contact_id)
                self.view.show_message("Contact deleted successfully!")

            elif choice == "4":
                self.model.close()
                self.view.show_message("Goodbye!")
                break

            else:
                self.view.show_message("Invalid choice, try again.")
```

---

## 🔹 6. The Main Entry (main.py)

This file launches the application.

```python
# main.py
from controller import ContactController

if __name__ == "__main__":
    app = ContactController()
    app.run()
```

---

## 🧠 How It Works

1. **User** interacts with the `View` (menu).
2. The `Controller` processes input.
3. The `Model` reads/writes data from the **MySQL database**.
4. The `View` displays results.

✅ This clean separation allows you to:

* Swap MySQL for SQLite or PostgreSQL easily.
* Replace the CLI with a web UI (Flask, Django).
* Test logic without relying on user input.

---

## 🧩 Possible Enhancements

* Add a **search feature** for contacts.
* Validate input (phone/email format).
* Add a **Flask front-end** for a web version.
* Use **environment variables** for DB credentials.

---
