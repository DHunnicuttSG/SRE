Here’s a clean, console-based **Python Todo app** built with an **in-memory list** and a clear **MVC architecture**, perfect for running in **PyCharm**. It supports:

*   **List all todos**
*   **List one todo by ID**
*   **Add a todo** *(needed so you have something to edit/delete)*
*   **Edit a todo**
*   **Delete a todo**
*   **Simple text menu**

***

## 🧱 Project Structure (MVC)

    todo_app/
    ├─ controller/
    │  └─ todo_controller.py
    ├─ model/
    │  ├─ repository.py
    │  └─ todo.py
    ├─ view/
    │  └─ console_view.py
    └─ main.py

*   **Model** = `Todo` entity + `TodoRepository` using a Python `list` as the in-memory database
*   **View** = `ConsoleView` for printing UI and reading user input
*   **Controller** = `TodoController` orchestrates between view and model
*   **main.py** = bootstraps and runs the app

***

## 🚀 How to set it up in PyCharm

1.  **Open PyCharm** → **New Project** → Location: choose where you want `todo_app` to live
2.  Right-click the project root → **New** → **Directory** → create: `model`, `view`, `controller`
3.  In each directory, right-click → **New** → **Python File** and create the files below
4.  Create `main.py` at the project root
5.  Right-click `main.py` → **Run 'main'** (or press **Shift+F10**)

> *(No external dependencies. Any Python 3.8+ works.)*

***

## 📦 Code

> Copy each snippet into the matching file path.

### `model/todo.py`

```python
from dataclasses import dataclass

@dataclass
class Todo:
    """
    Domain entity representing a Todo item.
    """
    id: int
    title: str
    description: str = ""
    completed: bool = False

    def __str__(self) -> str:
        status = "✅" if self.completed else "⬜"
        return f"[{status}] {self.id}: {self.title} - {self.description}".strip()
```

***

### `model/repository.py`

```python
from typing import List, Optional
from .todo import Todo

class TodoRepository:
    """
    In-memory repository that uses a Python list as the 'database'.
    Provides CRUD-like operations: add, list_all, get_by_id, update, delete.
    """
    def __init__(self) -> None:
        self._todos: List[Todo] = []
        self._next_id: int = 1  # auto-incrementing ID

    def add(self, title: str, description: str = "") -> Todo:
        title = title.strip()
        description = description.strip()
        todo = Todo(id=self._next_id, title=title, description=description, completed=False)
        self._todos.append(todo)
        self._next_id += 1
        return todo

    def list_all(self) -> List[Todo]:
        # return a shallow copy to prevent external mutation
        return list(self._todos)

    def get_by_id(self, todo_id: int) -> Optional[Todo]:
        return next((t for t in self._todos if t.id == todo_id), None)

    def update(
        self,
        todo_id: int,
        title: Optional[str] = None,
        description: Optional[str] = None,
        completed: Optional[bool] = None,
    ) -> Optional[Todo]:
        todo = self.get_by_id(todo_id)
        if not todo:
            return None
        if title is not None:
            todo.title = title
        if description is not None:
            todo.description = description
        if completed is not None:
            todo.completed = completed
        return todo

    def delete(self, todo_id: int) -> bool:
        todo = self.get_by_id(todo_id)
        if not todo:
            return False
        self._todos.remove(todo)
        return True
```

***

### `view/console_view.py`

```python
from typing import Dict, Optional, Iterable
from model.todo import Todo

class ConsoleView:
    """
    Console-based view for rendering menus, messages, and reading input.
    Keeps IO separate from business logic (Controller/Model).
    """

    def show_menu(self) -> None:
        print("\n====== TODO MENU ======")
        print("1) List all todos")
        print("2) View a todo by ID")
        print("3) Add a new todo")
        print("4) Edit a todo")
        print("5) Delete a todo")
        print("0) Exit")
        print("=======================\n")

    def get_menu_choice(self) -> str:
        return input("Choose an option (0-5): ").strip()

    # ---------- List / Show ----------
    def show_all(self, todos: Iterable[Todo]) -> None:
        todos = list(todos)
        if not todos:
            print("No todos yet. Add your first one!")
            return
        print("\nAll Todos:")
        print("-" * 40)
        for t in todos:
            print(str(t))
        print("-" * 40)

    def show_one(self, todo: Optional[Todo]) -> None:
        if not todo:
            print("Todo not found.")
            return
        print("\nTodo Details:")
        print("-" * 40)
        print(f"ID:         {todo.id}")
        print(f"Title:      {todo.title}")
        print(f"Description:{' ' if todo.description else ''}{todo.description}")
        print(f"Completed:  {'Yes' if todo.completed else 'No'}")
        print("-" * 40)

    # ---------- Create ----------
    def prompt_new_todo(self) -> Optional[tuple[str, str]]:
        print("\nCreate New Todo")
        title = input("Title (required): ").strip()
        if not title:
            print("Title is required. Aborting create.")
            return None
        description = input("Description (optional): ").strip()
        return title, description

    # ---------- ID ----------
    def prompt_id(self, prompt_text: str = "Enter todo ID: ") -> Optional[int]:
        raw = input(prompt_text).strip()
        if not raw:
            print("No ID entered.")
            return None
        try:
            todo_id = int(raw)
            return todo_id
        except ValueError:
            print("ID must be a number.")
            return None

    # ---------- Edit ----------
    def prompt_edit_todo(self, todo: Todo) -> Dict:
        print("\nEdit Todo (press Enter to keep current value)")
        print(f"Current title: {todo.title}")
        new_title = input("New title: ").strip()
        print(f"Current description: {todo.description}")
        new_desc = input("New description: ").strip()
        print(f"Current completed: {'Yes' if todo.completed else 'No'}")
        new_completed = input("Completed? (y/n, blank to keep): ").strip().lower()

        updates: Dict = {}
        if new_title != "":
            updates["title"] = new_title
        if new_desc != "":
            updates["description"] = new_desc
        if new_completed in ("y", "yes"):
            updates["completed"] = True
        elif new_completed in ("n", "no"):
            updates["completed"] = False
        # if blank, we leave it unchanged
        return updates

    # ---------- Feedback ----------
    def show_created(self, todo: Todo) -> None:
        print(f"Created todo #{todo.id}: {todo.title}")

    def show_updated(self, todo: Optional[Todo]) -> None:
        if not todo:
            print("Update failed: todo not found.")
        else:
            print(f"Updated todo #{todo.id}.")

    def show_deleted(self, todo_id: int, success: bool) -> None:
        if success:
            print(f"Deleted todo #{todo_id}.")
        else:
            print(f"Delete failed: todo #{todo_id} not found.")

    def show_not_found(self, todo_id: int) -> None:
        print(f"Todo #{todo_id} not found.")

    def invalid_choice(self) -> None:
        print("Invalid choice. Please select a valid option.")

    def goodbye(self) -> None:
        print("Goodbye! 👋")
```

***

### `controller/todo_controller.py`

```python
from model.repository import TodoRepository
from view.console_view import ConsoleView

class TodoController:
    """
    Application controller: reads inputs from the view, calls the model,
    and instructs the view to render outputs. Contains the main loop.
    """

    def __init__(self, repo: TodoRepository, view: ConsoleView) -> None:
        self.repo = repo
        self.view = view

    def run(self) -> None:
        while True:
            self.view.show_menu()
            choice = self.view.get_menu_choice()

            if choice == "1":  # list all
                todos = self.repo.list_all()
                self.view.show_all(todos)

            elif choice == "2":  # view by id
                todo_id = self.view.prompt_id("Enter todo ID to view: ")
                if todo_id is None:
                    continue
                todo = self.repo.get_by_id(todo_id)
                self.view.show_one(todo)

            elif choice == "3":  # add
                new_data = self.view.prompt_new_todo()
                if not new_data:
                    continue
                title, description = new_data
                todo = self.repo.add(title=title, description=description)
                self.view.show_created(todo)

            elif choice == "4":  # edit
                todo_id = self.view.prompt_id("Enter todo ID to edit: ")
                if todo_id is None:
                    continue
                existing = self.repo.get_by_id(todo_id)
                if not existing:
                    self.view.show_not_found(todo_id)
                    continue
                updates = self.view.prompt_edit_todo(existing)
                updated = self.repo.update(todo_id, **updates)
                self.view.show_updated(updated)

            elif choice == "5":  # delete
                todo_id = self.view.prompt_id("Enter todo ID to delete: ")
                if todo_id is None:
                    continue
                success = self.repo.delete(todo_id)
                self.view.show_deleted(todo_id, success)

            elif choice == "0":  # exit
                self.view.goodbye()
                break

            else:
                self.view.invalid_choice()
```

***

### `main.py`

```python
from controller.todo_controller import TodoController
from model.repository import TodoRepository
from view.console_view import ConsoleView

def bootstrap_sample_data(repo: TodoRepository) -> None:
    # Optional: seed a couple of todos so you can test immediately.
    repo.add("Set up project", "Create MVC folders and files")
    repo.add("Write repository", "Add list-based CRUD functions")
    repo.add("Wire up controller", "Connect view and model")
    repo.add("Instruction Files", "Create instruction files")

def main() -> None:
    repo = TodoRepository()
    view = ConsoleView()
    bootstrap_sample_data(repo)  # comment this out if you don't want seed data
    app = TodoController(repo, view)
    app.run()

if __name__ == "__main__":
    main()
```

***

## 🧪 What you can do in the running app

*   **1 – List all**: Shows every todo with `id`, title, description, and status
*   **2 – View by ID**: Shows detailed info for a single todo
*   **3 – Add**: Create a new todo (title required)
*   **4 – Edit**: Update title/description/completed (press **Enter** to keep a field unchanged)
*   **5 – Delete**: Remove a todo by its ID
*   **0 – Exit**: Quit the app

***

## 🧭 Why this is clean MVC

*   **Model**: `Todo` + `TodoRepository` (pure data & persistence-in-memory logic)
*   **View**: `ConsoleView` (all input/output lives here)
*   **Controller**: `TodoController` (app flow; no printing, no storage)
*   This separation makes it easy to later swap the view (e.g., GUI or web) or the repository (e.g., SQLite) without changing business logic.

***

## 🛠 Tips for PyCharm (helpful while teaching/leading)

*   **Run/Debug**: Right-click `main.py` → **Debug 'main'** to step through MVC flow
*   **Breakpoints**: Add them in `controller/todo_controller.py` to observe user flow
*   **Refactor**: Rename methods safely with **Shift+F6**
*   **Docstrings/Type Hints**: Already included to improve readability and teaching value

***
