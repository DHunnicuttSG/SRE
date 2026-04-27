## Create a contactList_app using todo_app as a model

Below you’ll find:

*   ✅ Project structure
*   ✅ Complete, ready-to-run Python source files (Model, View, Controller, Main)
*   ✅ MySQL schema (auto-created), environment variables, and PyCharm setup steps
*   ✅ Notes on what changed from the TODO app and how to extend it

***

## 1) Project structure

    contactList_app/
      controller/
        contact_controller.py
      model/
        contact.py
        mysql_repository.py
      view/
        console_view.py
      main.py
      requirements.txt
      README.md
      .gitignore

***

## 2) Model

### `model/contact.py`

```python
from dataclasses import dataclass

@dataclass
class Contact:
    id: int
    first_name: str
    last_name: str
    email: str = ""
    phone: str = ""
    notes: str = ""
    favorite: bool = False

    def __str__(self) -> str:
        star = "⭐" if self.favorite else "✦"
        name = f"{self.first_name} {self.last_name}".strip()
        parts = [
            f"[{star}] {self.id}: {name}",
            f"<{self.email}>" if self.email else "",
            f"📞 {self.phone}" if self.phone else "",
            f"— {self.notes}" if self.notes else "",
        ]
        return " ".join(p for p in parts if p).strip()
```

***

## 3) Repository (MySQL)

### `model/mysql_repository.py`

```python
from __future__ import annotations
from typing import List, Optional, Any, Dict
import mysql.connector
from mysql.connector import pooling
from model.contact import Contact

class MySqlContactRepository:
    """
    MySQL implementation of the Contact repository using mysql-connector-python.
    API:
      - add(first_name, last_name, email="", phone="", notes="", favorite=False) -> Contact
      - list_all() -> List[Contact]
      - get_by_id(contact_id) -> Optional[Contact]
      - update(contact_id, first_name=None, last_name=None, email=None, phone=None, notes=None, favorite=None) -> Optional[Contact]
      - delete(contact_id) -> bool
      - search(query) -> List[Contact]
    """

    def __init__(
        self,
        host: str = "127.0.0.1",
        port: int = 3306,
        user: str = "contact_user",
        password: str = "devContact123",
        database: str = "contact_app",
        use_pool: bool = True,
        pool_name: str = "contact_pool",
        pool_size: int = 5,
        ensure_schema: bool = True,
    ) -> None:
        self._db_config: Dict[str, Any] = {
            "host": host,
            "port": port,
            "user": user,
            "password": password,
            "database": database,
        }
        self._pool = None
        if use_pool:
            self._pool = pooling.MySQLConnectionPool(
                pool_name=pool_name,
                pool_size=pool_size,
                **self._db_config,
            )
        if ensure_schema:
            self._ensure_table()

    # --- Connection helpers ---
    def _get_conn(self):
        return self._pool.get_connection() if self._pool else mysql.connector.connect(**self._db_config)

    def _ensure_table(self) -> None:
        ddl = """
        CREATE TABLE IF NOT EXISTS contacts (
            id INT AUTO_INCREMENT PRIMARY KEY,
            first_name VARCHAR(100) NOT NULL,
            last_name  VARCHAR(100) NOT NULL,
            email      VARCHAR(255) UNIQUE,
            phone      VARCHAR(50),
            notes      TEXT,
            favorite   TINYINT(1) NOT NULL DEFAULT 0,
            INDEX idx_contacts_name (last_name, first_name)
        )
        """
        conn = self._get_conn()
        try:
            with conn.cursor() as cur:
                cur.execute(ddl)
            conn.commit()
        finally:
            conn.close()

    # --- CRUD ---
    def add(self, first_name: str, last_name: str, email: str = "", phone: str = "", notes: str = "", favorite: bool = False) -> Contact:
        first_name = first_name.strip()
        last_name  = last_name.strip()
        email      = email.strip()
        phone      = phone.strip()
        notes      = notes.strip()
        sql = """
        INSERT INTO contacts (first_name, last_name, email, phone, notes, favorite)
        VALUES (%s, %s, %s, %s, %s, %s)
        """
        conn = self._get_conn()
        try:
            with conn.cursor(dictionary=True) as cur:
                cur.execute(sql, (first_name, last_name, email, phone, notes, int(bool(favorite))))
                conn.commit()
                new_id = cur.lastrowid
                return Contact(id=new_id, first_name=first_name, last_name=last_name, email=email, phone=phone, notes=notes, favorite=favorite)
        finally:
            conn.close()

    def list_all(self) -> List[Contact]:
        sql = "SELECT id, first_name, last_name, email, phone, notes, favorite FROM contacts ORDER BY last_name, first_name, id"
        conn = self._get_conn()
        try:
            with conn.cursor(dictionary=True) as cur:
                cur.execute(sql)
                rows = cur.fetchall()
                return [
                    Contact(
                        id=row["id"],
                        first_name=row["first_name"],
                        last_name=row["last_name"],
                        email=row.get("email") or "",
                        phone=row.get("phone") or "",
                        notes=row.get("notes") or "",
                        favorite=bool(row["favorite"]),
                    )
                    for row in rows
                ]
        finally:
            conn.close()

    def get_by_id(self, contact_id: int) -> Optional[Contact]:
        sql = "SELECT id, first_name, last_name, email, phone, notes, favorite FROM contacts WHERE id = %s"
        conn = self._get_conn()
        try:
            with conn.cursor(dictionary=True) as cur:
                cur.execute(sql, (contact_id,))
                row = cur.fetchone()
                if not row:
                    return None
                return Contact(
                    id=row["id"],
                    first_name=row["first_name"],
                    last_name=row["last_name"],
                    email=row.get("email") or "",
                    phone=row.get("phone") or "",
                    notes=row.get("notes") or "",
                    favorite=bool(row["favorite"]),
                )
        finally:
            conn.close()

    def update(
        self,
        contact_id: int,
        first_name: Optional[str] = None,
        last_name:  Optional[str] = None,
        email:      Optional[str] = None,
        phone:      Optional[str] = None,
        notes:      Optional[str] = None,
        favorite:   Optional[bool] = None,
    ) -> Optional[Contact]:
        current = self.get_by_id(contact_id)
        if not current:
            return None
        new_fn   = current.first_name if first_name is None else first_name
        new_ln   = current.last_name  if last_name  is None else last_name
        new_em   = current.email      if email      is None else email
        new_ph   = current.phone      if phone      is None else phone
        new_note = current.notes      if notes      is None else notes
        new_fav  = current.favorite   if favorite   is None else favorite

        new_fn, new_ln, new_em, new_ph, new_note = map(str.strip, [new_fn, new_ln, new_em, new_ph, new_note])

        sql = """
        UPDATE contacts
           SET first_name=%s, last_name=%s, email=%s, phone=%s, notes=%s, favorite=%s
         WHERE id=%s
        """
        conn = self._get_conn()
        try:
            with conn.cursor() as cur:
                cur.execute(sql, (new_fn, new_ln, new_em, new_ph, new_note, int(bool(new_fav)), contact_id))
                conn.commit()
                return Contact(id=contact_id, first_name=new_fn, last_name=new_ln, email=new_em, phone=new_ph, notes=new_note, favorite=new_fav)
        finally:
            conn.close()

    def delete(self, contact_id: int) -> bool:
        sql = "DELETE FROM contacts WHERE id = %s"
        conn = self._get_conn()
        try:
            with conn.cursor() as cur:
                cur.execute(sql, (contact_id,))
                affected = cur.rowcount or 0
                conn.commit()
                return affected > 0
        finally:
            conn.close()

    def search(self, query: str) -> List[Contact]:
        """Search across first_name, last_name, and email."""
        q = f"%{query.strip()}%"
        sql = (
            "SELECT id, first_name, last_name, email, phone, notes, favorite FROM contacts "
            "WHERE first_name LIKE %s OR last_name LIKE %s OR email LIKE %s "
            "ORDER BY last_name, first_name"
        )
        conn = self._get_conn()
        try:
            with conn.cursor(dictionary=True) as cur:
                cur.execute(sql, (q, q, q))
                rows = cur.fetchall()
                return [
                    Contact(
                        id=row["id"],
                        first_name=row["first_name"],
                        last_name=row["last_name"],
                        email=row.get("email") or "",
                        phone=row.get("phone") or "",
                        notes=row.get("notes") or "",
                        favorite=bool(row["favorite"]),
                    )
                    for row in rows
                ]
        finally:
            conn.close()
```

***

## 4) View (Console)

### `view/console_view.py`

```python
from typing import Dict, Optional, Iterable
from model.contact import Contact

class ConsoleView:
    """
    Console-based view for rendering menus, messages, and reading input.
    Keeps IO separate from controller/model.
    """
    def show_menu(self) -> None:
        print("\n====== CONTACTS MENU ======")
        print("1) List all contacts")
        print("2) View a contact by ID")
        print("3) Add a new contact")
        print("4) Edit a contact")
        print("5) Delete a contact")
        print("6) Search contacts")
        print("0) Exit")
        print("==========================\n")

    def get_menu_choice(self) -> str:
        return input("Choose an option (0-6): ").strip()

    # --- List / Show ---
    def show_all(self, contacts: Iterable[Contact]) -> None:
        contacts = list(contacts)
        if not contacts:
            print("No contacts yet. Add your first one!")
            return
        print("\nAll Contacts:")
        print("-" * 60)
        for c in contacts:
            print(str(c))
        print("-" * 60)

    def show_one(self, contact: Optional[Contact]) -> None:
        if not contact:
            print("Contact not found.")
            return
        print("\nContact Details:")
        print("-" * 60)
        print(f"ID: {contact.id}")
        print(f"Name: {contact.first_name} {contact.last_name}")
        print(f"Email: {contact.email or '-'}")
        print(f"Phone: {contact.phone or '-'}")
        print(f"Notes: {contact.notes or '-'}")
        print(f"Favorite: {'Yes' if contact.favorite else 'No'}")
        print("-" * 60)

    # --- Create ---
    def prompt_new_contact(self) -> Optional[tuple]:
        print("\nCreate New Contact")
        first_name = input("First name (required): ").strip()
        last_name = input("Last name (required): ").strip()
        if not first_name or not last_name:
            print("First and last name are required. Aborting create.")
            return None
        email = input("Email (optional): ").strip()
        phone = input("Phone (optional): ").strip()
        notes = input("Notes (optional): ").strip()
        fav = input("Favorite? (y/n, default n): ").strip().lower()
        favorite = fav in ("y", "yes")
        return first_name, last_name, email, phone, notes, favorite

    # --- ID ---
    def prompt_id(self, prompt_text: str = "Enter contact ID: ") -> Optional[int]:
        raw = input(prompt_text).strip()
        if not raw:
            print("No ID entered.")
            return None
        try:
            return int(raw)
        except ValueError:
            print("ID must be a number.")
            return None

    # --- Edit ---
    def prompt_edit_contact(self, contact: Contact) -> Dict:
        print("\nEdit Contact (press Enter to keep current value)")
        print(f"Current first name: {contact.first_name}")
        new_fn = input("New first name: ").strip()
        print(f"Current last name: {contact.last_name}")
        new_ln = input("New last name: ").strip()
        print(f"Current email: {contact.email}")
        new_email = input("New email: ").strip()
        print(f"Current phone: {contact.phone}")
        new_phone = input("New phone: ").strip()
        print(f"Current notes: {contact.notes}")
        new_notes = input("New notes: ").strip()
        print(f"Current favorite: {'Yes' if contact.favorite else 'No'}")
        new_fav = input("Favorite? (y/n, blank to keep): ").strip().lower()

        updates: Dict = {}
        if new_fn != "":
            updates["first_name"] = new_fn
        if new_ln != "":
            updates["last_name"] = new_ln
        if new_email != "":
            updates["email"] = new_email
        if new_phone != "":
            updates["phone"] = new_phone
        if new_notes != "":
            updates["notes"] = new_notes
        if new_fav in ("y", "yes"):
            updates["favorite"] = True
        elif new_fav in ("n", "no"):
            updates["favorite"] = False
        return updates

    # --- Search ---
    def prompt_search(self) -> str:
        return input("Search by first/last name or email: ").strip()

    # --- Feedback ---
    def show_created(self, contact: Contact) -> None:
        print(f"Created contact #{contact.id}: {contact.first_name} {contact.last_name}")

    def show_updated(self, contact: Optional[Contact]) -> None:
        if not contact:
            print("Update failed: contact not found.")
        else:
            print(f"Updated contact #{contact.id}.")

    def show_deleted(self, contact_id: int, success: bool) -> None:
        if success:
            print(f"Deleted contact #{contact_id}.")
        else:
            print(f"Delete failed: contact #{contact_id} not found.")

    def show_not_found(self, contact_id: int) -> None:
        print(f"Contact #{contact_id} not found.")

    def invalid_choice(self) -> None:
        print("Invalid choice. Please select a valid option.")

    def goodbye(self) -> None:
        print("Goodbye! 👋")
```

***

## 5) Controller

### `controller/contact_controller.py`

```python
from model.mysql_repository import MySqlContactRepository
from view.console_view import ConsoleView

class ContactController:
    """Application controller for the contact list app."""

    def __init__(self, repo: MySqlContactRepository, view: ConsoleView) -> None:
        self.repo = repo
        self.view = view

    def run(self) -> None:
        while True:
            self.view.show_menu()
            choice = self.view.get_menu_choice()
            if choice == "1":  # list all
                contacts = self.repo.list_all()
                self.view.show_all(contacts)
            elif choice == "2":  # view by id
                contact_id = self.view.prompt_id("Enter contact ID to view: ")
                if contact_id is None:
                    continue
                contact = self.repo.get_by_id(contact_id)
                self.view.show_one(contact)
            elif choice == "3":  # add
                new_data = self.view.prompt_new_contact()
                if not new_data:
                    continue
                first_name, last_name, email, phone, notes, favorite = new_data
                contact = self.repo.add(first_name, last_name, email, phone, notes, favorite)
                self.view.show_created(contact)
            elif choice == "4":  # edit
                contact_id = self.view.prompt_id("Enter contact ID to edit: ")
                if contact_id is None:
                    continue
                existing = self.repo.get_by_id(contact_id)
                if not existing:
                    self.view.show_not_found(contact_id)
                    continue
                updates = self.view.prompt_edit_contact(existing)
                updated = self.repo.update(contact_id, **updates)
                self.view.show_updated(updated)
            elif choice == "5":  # delete
                contact_id = self.view.prompt_id("Enter contact ID to delete: ")
                if contact_id is None:
                    continue
                success = self.repo.delete(contact_id)
                self.view.show_deleted(contact_id, success)
            elif choice == "6":  # search
                q = self.view.prompt_search()
                if not q:
                    continue
                results = self.repo.search(q)
                self.view.show_all(results)
            elif choice == "0":
                self.view.goodbye()
                break
            else:
                self.view.invalid_choice()
```

***

## 6) Application entry point

### `main.py`

```python
import os
from controller.contact_controller import ContactController
from model.mysql_repository import MySqlContactRepository
from view.console_view import ConsoleView


def bootstrap_sample_data(repo: MySqlContactRepository) -> None:
    # Seed only if empty
    if not repo.list_all():
        repo.add("Ada", "Lovelace", "ada@example.com", "+44 20 1234 5678", "Wrote the first algorithm.", True)
        repo.add("Grace", "Hopper", "grace@example.com", "+1 202 555 0100", "Pioneer of COBOL.", True)
        repo.add("Alan", "Turing", "alan@example.com", "+44 20 9876 5432", "Father of theoretical CS.", False)


def main() -> None:
    repo = MySqlContactRepository(
        host=os.getenv("CONTACT_DB_HOST", "127.0.0.1"),
        port=int(os.getenv("CONTACT_DB_PORT", "3306")),
        user=os.getenv("CONTACT_DB_USER", "contact_user"),
        password=os.getenv("CONTACT_DB_PASSWORD", "devContact123"),
        database=os.getenv("CONTACT_DB_NAME", "contact_app"),
        use_pool=True,
        pool_name="contact_pool",
        pool_size=5,
        ensure_schema=True,
    )
    view = ConsoleView()
    bootstrap_sample_data(repo)  # comment out if you don't want seed data
    app = ContactController(repo, view)
    app.run()


if __name__ == "__main__":
    main()
```

***

## 7) Dependencies & ignore

### `requirements.txt`

```text
mysql-connector-python>=9.0
```

### `.gitignore`

```text
# Python
__pycache__/
*.pyc
*.pyo
*.pyd
.env
.venv/
venv/
.idea/
.DS_Store
```

***

## 8) How to run it in PyCharm

1.  **Open the folder**  
    Open `contactList_app` in PyCharm (**File → Open…**).

2.  **Create/activate a virtualenv**  
    PyCharm usually prompts; otherwise set one up (Python 3.10+), then run:

```bash
pip install -r requirements.txt
```

3.  **Create the MySQL database & user** (example)

```sql
CREATE DATABASE contact_app CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
CREATE USER 'contact_user'@'%' IDENTIFIED BY 'devContact123';
GRANT ALL PRIVILEGES ON contact_app.* TO 'contact_user'@'%';
FLUSH PRIVILEGES;
```

4.  **Set environment variables**  
    In PyCharm: **Run → Edit Configurations… → main.py → Environment variables**:

<!---->

    CONTACT_DB_HOST=127.0.0.1
    CONTACT_DB_PORT=3306
    CONTACT_DB_USER=contact_user
    CONTACT_DB_PASSWORD=devContact123
    CONTACT_DB_NAME=contact_app

5.  **Run `main.py`**  
    You’ll see the “Contacts Menu” in the Run console. The seed data is inserted if the table is empty.

***

## 9) What changed vs the original TODO app

*   **Model:** `Todo` → `Contact` with fields: `first_name`, `last_name`, `email`, `phone`, `notes`, `favorite` (bool). [\[mthreecom-...epoint.com\]](https://mthreecom-my.sharepoint.com/personal/david_hunnicutt_mthree_com/Documents/Microsoft%20Copilot%20Chat%20Files/Todo_to_contactlist.md)
*   **Repository:** `MySqlTodoRepository` → `MySqlContactRepository` with the same CRUD API + `search()`. Table auto-creation now creates a `contacts` table with indices and a unique `email`. [\[mthreecom-...epoint.com\]](https://mthreecom-my.sharepoint.com/personal/david_hunnicutt_mthree_com/Documents/Microsoft%20Copilot%20Chat%20Files/Todo_to_contactlist.md)
*   **View:** Menu and prompts updated for contacts; includes a **Search** option. [\[mthreecom-...epoint.com\]](https://mthreecom-my.sharepoint.com/personal/david_hunnicutt_mthree_com/Documents/Microsoft%20Copilot%20Chat%20Files/Todo_to_contactlist.md)
*   **Controller:** Flow mirrors the TODO controller with updated operations and the new search branch. [\[mthreecom-...epoint.com\]](https://mthreecom-my.sharepoint.com/personal/david_hunnicutt_mthree_com/Documents/Microsoft%20Copilot%20Chat%20Files/Todo_to_contactlist.md)
*   **Main:** Environment variables renamed to `CONTACT_DB_*`; bootstrap sample contacts provided. [\[mthreecom-...epoint.com\]](https://mthreecom-my.sharepoint.com/personal/david_hunnicutt_mthree_com/Documents/Microsoft%20Copilot%20Chat%20Files/Todo_to_contactlist.md)

***
