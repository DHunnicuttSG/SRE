Here’s a clear set of **step-by-step instructions to refactor your `todo_app` so you can use MySQL or SQLite instead of an in-memory list**:

***

## ✅ 1. Understand the Goal

Currently, your app uses:

*   `TodoRepository` with `self._todos: List[Todo] = []` as storage.
*   All CRUD operations manipulate this list.

To integrate **MySQL** or **SQLite**, you need to:

*   Replace the list with **database tables**.
*   Use **SQL queries** for CRUD operations.
*   Keep the MVC structure intact (Model changes, Controller and View stay mostly the same).

***

## ✅ 2. Install Database Driver

*   For **SQLite** (built-in): No extra install needed.
*   For **MySQL**:
    ```bash
    pip install mysql-connector-python
    ```
    or
    ```bash
    pip install pymysql
    ```

***

## ✅ 3. Create a Database and Table

For SQLite:

```sql
CREATE TABLE todos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    completed BOOLEAN DEFAULT 0
);
```

For MySQL:

```sql
CREATE TABLE todos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    completed BOOLEAN DEFAULT FALSE
);
```

***

## ✅ 4. Refactor `TodoRepository`

Instead of storing todos in a list:

*   Add a **database connection** in `__init__`.
*   Replace `add`, `list_all`, `get_by_id`, `update`, `delete` with SQL queries.

Example for SQLite:

```python
import sqlite3
from typing import List, Optional
from model.todo import Todo

class TodoRepository:
    def __init__(self, db_path: str = "todos.db") -> None:
        self.conn = sqlite3.connect(db_path)
        self.conn.row_factory = sqlite3.Row
        self._create_table()

    def _create_table(self):
        self.conn.execute("""
        CREATE TABLE IF NOT EXISTS todos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT,
            completed BOOLEAN DEFAULT 0
        )
        """)
        self.conn.commit()

    def add(self, title: str, description: str = "") -> Todo:
        cur = self.conn.cursor()
        cur.execute("INSERT INTO todos (title, description, completed) VALUES (?, ?, ?)",
                    (title.strip(), description.strip(), False))
        self.conn.commit()
        todo_id = cur.lastrowid
        return Todo(id=todo_id, title=title.strip(), description=description.strip(), completed=False)

    def list_all(self) -> List[Todo]:
        cur = self.conn.execute("SELECT * FROM todos")
        rows = cur.fetchall()
        return [Todo(id=row["id"], title=row["title"], description=row["description"], completed=bool(row["completed"])) for row in rows]

    def get_by_id(self, todo_id: int) -> Optional[Todo]:
        cur = self.conn.execute("SELECT * FROM todos WHERE id = ?", (todo_id,))
        row = cur.fetchone()
        if row:
            return Todo(id=row["id"], title=row["title"], description=row["description"], completed=bool(row["completed"]))
        return None

    def update(self, todo_id: int, title=None, description=None, completed=None) -> Optional[Todo]:
        todo = self.get_by_id(todo_id)
        if not todo:
            return None
        if title is not None:
            todo.title = title
        if description is not None:
            todo.description = description
        if completed is not None:
            todo.completed = completed
        self.conn.execute("UPDATE todos SET title=?, description=?, completed=? WHERE id=?",
                          (todo.title, todo.description, int(todo.completed), todo_id))
        self.conn.commit()
        return todo

    def delete(self, todo_id: int) -> bool:
        cur = self.conn.execute("DELETE FROM todos WHERE id=?", (todo_id,))
        self.conn.commit()
        return cur.rowcount > 0
```

***

## ✅ 5. Keep MVC Intact

*   **Model**: Only `TodoRepository` changes.
*   **Controller**: No changes (still calls `repo.add()`, `repo.list_all()`, etc.).
*   **View**: No changes (still prints data).

***

## ✅ 6. Update `main.py`

Pass the database path or connection when creating the repository:

```python
repo = TodoRepository(db_path="todos.db")  # SQLite
```

For MySQL:

```python
repo = TodoRepository(host="localhost", user="root", password="yourpass", database="todo_db")
```

***

## ✅ 7. Test Everything

*   Run the app and verify CRUD works.
*   Check the database file or MySQL table for changes.

***

## ✅ 8. Optional Enhancements

*   Use **SQLAlchemy ORM** for cleaner code.
*   Add **migrations** (e.g., Alembic).
*   Implement **connection pooling** for MySQL.

***
