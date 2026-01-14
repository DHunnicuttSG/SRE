Here’s a focused, practical walkthrough to refactor your `todo_app` to use a **MySQL** database while keeping your MVC intact. We’ll add a new MySQL-backed repository that implements the same interface as your in-memory `TodoRepository`, so your controller and view **don’t need to change**.

***

## What we’ll do

1.  **Install the MySQL driver**
2.  **Create a database and table**
3.  **Add a new MySQL repository (`MySqlTodoRepository`)**
4.  **Wire it up in `main.py`**
5.  **(Optional) Add a DB init script and basic integration test**
6.  **PyCharm tips + troubleshooting**

***

## 1) Install the MySQL driver

I recommend `mysql-connector-python` (official MySQL driver):

```bash
pip install mysql-connector-python
```

> Alternative: `PyMySQL` also works; code will be slightly different.

***

## 2) Create the database and table

From a MySQL client (CLI or GUI), run:

```sql
-- Create database (once)
CREATE DATABASE IF NOT EXISTS todo_app
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

-- Create a dedicated user (recommended for dev)
-- Use a real password in place of 'devpassword'
CREATE USER IF NOT EXISTS 'todo_user'@'%' IDENTIFIED BY 'devpassword';
GRANT ALL PRIVILEGES ON todo_app.* TO 'todo_user'@'%';
FLUSH PRIVILEGES;

-- Create the table
USE todo_app;

CREATE TABLE IF NOT EXISTS todos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    completed TINYINT(1) NOT NULL DEFAULT 0
);
```

> Notes:
>
> *   MySQL stores booleans as `TINYINT(1)`. We’ll convert `0/1` ⇄ `False/True` in Python.
> *   `utf8mb4` ensures you can store emojis if desired.

***

## 3) Add a MySQL-backed repository

Create a new file: `model/mysql_repository.py`

```python
# model/mysql_repository.py
from __future__ import annotations
from typing import List, Optional, Any, Dict
import mysql.connector
from mysql.connector import pooling, Error  # type: ignore

from model.todo import Todo


class MySqlTodoRepository:
    """
    MySQL implementation of the Todo repository using mysql-connector-python.
    Matches the interface of the in-memory TodoRepository:
      - add(title, description) -> Todo
      - list_all() -> List[Todo]
      - get_by_id(todo_id) -> Optional[Todo]
      - update(todo_id, title=None, description=None, completed=None) -> Optional[Todo]
      - delete(todo_id) -> bool
    """

    def __init__(
        self,
        host: str = "127.0.0.1",
        port: int = 3306,
        user: str = "todo_user",
        password: str = "devpassword",
        database: str = "todo_app",
        use_pool: bool = True,
        pool_name: str = "todo_pool",
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

    # ---------- Connection helpers ----------
    def _get_conn(self):
        return self._pool.get_connection() if self._pool else mysql.connector.connect(**self._db_config)

    def _ensure_table(self) -> None:
        ddl = """
        CREATE TABLE IF NOT EXISTS todos (
            id INT AUTO_INCREMENT PRIMARY KEY,
            title VARCHAR(255) NOT NULL,
            description TEXT,
            completed TINYINT(1) NOT NULL DEFAULT 0
        )
        """
        conn = self._get_conn()
        try:
            with conn.cursor() as cur:
                cur.execute(ddl)
            conn.commit()
        finally:
            conn.close()

    # ---------- CRUD ----------
    def add(self, title: str, description: str = "") -> Todo:
        title = title.strip()
        description = description.strip()
        sql = "INSERT INTO todos (title, description, completed) VALUES (%s, %s, %s)"
        conn = self._get_conn()
        try:
            with conn.cursor(dictionary=True) as cur:
                cur.execute(sql, (title, description, 0))
                conn.commit()
                new_id = cur.lastrowid
            return Todo(id=new_id, title=title, description=description, completed=False)
        finally:
            conn.close()

    def list_all(self) -> List[Todo]:
        sql = "SELECT id, title, description, completed FROM todos ORDER BY id"
        conn = self._get_conn()
        try:
            with conn.cursor(dictionary=True) as cur:
                cur.execute(sql)
                rows = cur.fetchall()  # list[dict]
                return [
                    Todo(
                        id=row["id"],
                        title=row["title"],
                        description=row.get("description") or "",
                        completed=bool(row["completed"]),
                    )
                    for row in rows
                ]
        finally:
            conn.close()

    def get_by_id(self, todo_id: int) -> Optional[Todo]:
        sql = "SELECT id, title, description, completed FROM todos WHERE id = %s"
        conn = self._get_conn()
        try:
            with conn.cursor(dictionary=True) as cur:
                cur.execute(sql, (todo_id,))
                row = cur.fetchone()
                if not row:
                    return None
                return Todo(
                    id=row["id"],
                    title=row["title"],
                    description=row.get("description") or "",
                    completed=bool(row["completed"]),
                )
        finally:
            conn.close()

    def update(
        self,
        todo_id: int,
        title: Optional[str] = None,
        description: Optional[str] = None,
        completed: Optional[bool] = None,
    ) -> Optional[Todo]:
        # Fetch current to keep partial update logic consistent
        current = self.get_by_id(todo_id)
        if not current:
            return None

        new_title = current.title if title is None else title
        new_desc = current.description if description is None else description
        new_completed = current.completed if completed is None else completed

        # Optional: normalize/trim for consistency with add()
        new_title = new_title.strip()
        new_desc = new_desc.strip()

        sql = "UPDATE todos SET title=%s, description=%s, completed=%s WHERE id=%s"
        conn = self._get_conn()
        try:
            with conn.cursor() as cur:
                cur.execute(sql, (new_title, new_desc, int(bool(new_completed)), todo_id))
            conn.commit()
            return Todo(id=todo_id, title=new_title, description=new_desc, completed=new_completed)
        finally:
            conn.close()

    def delete(self, todo_id: int) -> bool:
        sql = "DELETE FROM todos WHERE id = %s"
        conn = self._get_conn()
        try:
            with conn.cursor() as cur:
                cur.execute(sql, (todo_id,))
                affected = cur.rowcount or 0
            conn.commit()
            return affected > 0
        finally:
            conn.close()
```

**Key points:**

*   Uses **parameterized queries** (`%s`) to prevent SQL injection.
*   Converts MySQL `TINYINT(1)` ⇄ Python `bool`.
*   Keeps **the same method names and return types** as your original `TodoRepository`.
*   Includes **connection pooling** for efficiency (you can disable with `use_pool=False`).
*   Creates the table automatically (`ensure_schema=True`), so you can just run.

***

## 4) Wire it up in `main.py`

Replace the in-memory repo with the MySQL repo:

```python
# main.py
import os
from controller.todo_controller import TodoController
from view.console_view import ConsoleView
from model.mysql_repository import MySqlTodoRepository
# from model.repository import TodoRepository  # old in-memory

def bootstrap_sample_data(repo) -> None:
    if not repo.list_all():  # seed only if empty
        repo.add("Set up project", "Create MVC folders and files")
        repo.add("Write repository", "Add DB-backed CRUD functions")
        repo.add("Wire up controller", "Connect view and model")

def main() -> None:
    # Prefer environment variables for secrets
    repo = MySqlTodoRepository(
        host=os.getenv("TODO_DB_HOST", "127.0.0.1"),
        port=int(os.getenv("TODO_DB_PORT", "3306")),
        user=os.getenv("TODO_DB_USER", "todo_user"),
        password=os.getenv("TODO_DB_PASSWORD", "devpassword"),
        database=os.getenv("TODO_DB_NAME", "todo_app"),
        use_pool=True,
        pool_name="todo_pool",
        pool_size=5,
        ensure_schema=True,
    )

    view = ConsoleView()
    bootstrap_sample_data(repo)
    app = TodoController(repo, view)
    app.run()

if __name__ == "__main__":
    main()
```

> In PyCharm, you can set **Run Configuration → Environment variables**:
>
> *   `TODO_DB_HOST=127.0.0.1`
> *   `TODO_DB_PORT=3306`
> *   `TODO_DB_USER=todo_user`
> *   `TODO_DB_PASSWORD=devpassword`
> *   `TODO_DB_NAME=todo_app`

***

## 5) (Optional) DB init script and integration test

**A) `scripts/create_db.py`** (handy if you want to initialize from code):

```python
# scripts/create_db.py
import mysql.connector

def main():
    conn = mysql.connector.connect(
        host="127.0.0.1",
        port=3306,
        user="root",              # or admin user
        password="yourRootPass",  # replace
    )
    try:
        with conn.cursor() as cur:
            cur.execute("CREATE DATABASE IF NOT EXISTS todo_app DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;")
            cur.execute("USE todo_app;")
            cur.execute("""
                CREATE TABLE IF NOT EXISTS todos (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    title VARCHAR(255) NOT NULL,
                    description TEXT,
                    completed TINYINT(1) NOT NULL DEFAULT 0
                );
            """)
        conn.commit()
        print("Database and table are ready.")
    finally:
        conn.close()

if __name__ == "__main__":
    main()
```

**B) Minimal integration test** (optional; requires a live DB):

    todo_app/
    └─ tests/
       └─ test_mysql_repository_integration.py

```python
# tests/test_mysql_repository_integration.py
import os
import unittest
from model.mysql_repository import MySqlTodoRepository

@unittest.skipUnless(os.getenv("RUN_DB_TESTS") == "1", "Set RUN_DB_TESTS=1 to run DB tests")
class TestMySqlRepoIntegration(unittest.TestCase):
    def setUp(self):
        self.repo = MySqlTodoRepository(
            host=os.getenv("TODO_DB_HOST", "127.0.0.1"),
            port=int(os.getenv("TODO_DB_PORT", "3306")),
            user=os.getenv("TODO_DB_USER", "todo_user"),
            password=os.getenv("TODO_DB_PASSWORD", "devpassword"),
            database=os.getenv("TODO_DB_NAME", "todo_app"),
            ensure_schema=True,
        )
        # Clean table between runs
        conn = self.repo._get_conn()
        try:
            with conn.cursor() as cur:
                cur.execute("DELETE FROM todos")
            conn.commit()
        finally:
            conn.close()

    def test_crud(self):
        a = self.repo.add("A", "d1")
        b = self.repo.add("B", "d2")
        self.assertEqual(a.id + 1, b.id)

        all_items = self.repo.list_all()
        self.assertEqual(len(all_items), 2)

        self.assertIsNotNone(self.repo.get_by_id(a.id))
        self.assertTrue(self.repo.update(b.id, completed=True).completed)

        self.assertTrue(self.repo.delete(a.id))
        self.assertIsNone(self.repo.get_by_id(a.id))

if __name__ == "__main__":
    unittest.main()
```

Run with:

```bash
RUN_DB_TESTS=1 python -m unittest tests/test_mysql_repository_integration.py -v
```

***

## 6) PyCharm steps & troubleshooting

**PyCharm setup**

1.  Add `mysql-connector-python` to your interpreter (Preferences → Python Interpreter → `+`).
2.  Create a Run Configuration for `main.py`.
3.  Set **Environment variables** (as shown above).
4.  (Optional) Create a Run Configuration for `scripts/create_db.py`.

**Common issues**

*   **Auth plugin errors**: Modern MySQL uses `caching_sha2_password`. `mysql-connector-python` supports it. If you used an older client to create the user, re-create the user or set `ALTER USER ... IDENTIFIED WITH caching_sha2_password BY 'pass';`
*   **Port/host**: Ensure MySQL is listening on `127.0.0.1:3306`. For Docker, map ports (`-p 3306:3306`) and host is `127.0.0.1`.
*   **Permissions**: Make sure the chosen user can access the `todo_app` DB and run CRUD.
*   **Boolean handling**: We convert `TINYINT(1)` to `bool` with `bool(row["completed"])` and back with `int(bool_value)`.

***

## What stays the same (good MVC hygiene)

*   **Controller** and **View** are unchanged.
*   The **repository interface** is the same (`add`, `list_all`, `get_by_id`, `update`, `delete`).
*   You can swap between in-memory and MySQL by changing **one import** and the repo initialization in `main.py`.

***

## Next steps (optional)

*   Add an **abstract base class** (e.g., `ITodoRepository`) to formalize the interface and allow clean swapping.
*   Add **SQLAlchemy** to support multiple backends (MySQL/SQLite/Postgres) with one code path.
*   Add **migrations** (Alembic) as your schema evolves.

***
