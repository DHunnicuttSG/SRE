## 🧱 Test File Layout

Create a `tests/` directory at the project root:

    todo_app/
    ├─ controller/
    ├─ model/
    ├─ view/
    ├─ tests/
    │  ├─ __init__.py        # (optional, helps PyCharm treat it as a package)
    │  └─ test_repository.py # <-- add this file
    └─ main.py

> In PyCharm: Right-click project root → **New → Directory** → `tests`  
> Inside `tests`, add **Python File** → `test_repository.py`  
> (Optional) Add an empty `__init__.py` file inside `tests/`.

***

## ✅ `unittest` Tests (recommended, no extra dependencies)

**`tests/test_repository.py`**

```python
import unittest

from model.repository import TodoRepository
from model.todo import Todo


class TestTodoRepository(unittest.TestCase):

    def setUp(self) -> None:
        # Fresh repository for each test
        self.repo = TodoRepository()

    # ---------- Creation ----------
    def test_add_creates_todo_with_incrementing_id(self):
        t1 = self.repo.add("First", "desc1")
        t2 = self.repo.add("Second", "desc2")

        self.assertIsInstance(t1, Todo)
        self.assertEqual(t1.id, 1)
        self.assertEqual(t1.title, "First")
        self.assertEqual(t1.description, "desc1")
        self.assertFalse(t1.completed)

        self.assertEqual(t2.id, 2)

    def test_add_trims_whitespace(self):
        t = self.repo.add("  Title  ", "  spaced  ")
        self.assertEqual(t.title, "Title")
        self.assertEqual(t.description, "spaced")

    # ---------- Read ----------
    def test_list_all_returns_copy(self):
        self.repo.add("A")
        all_before = self.repo.list_all()
        self.assertEqual(len(all_before), 1)
        # Mutating the returned list should not affect internal storage
        all_before.clear()
        all_after = self.repo.list_all()
        self.assertEqual(len(all_after), 1)

    def test_get_by_id_found_and_not_found(self):
        self.repo.add("A")
        self.repo.add("B")
        t2 = self.repo.get_by_id(2)
        self.assertIsNotNone(t2)
        self.assertEqual(t2.title, "B")
        self.assertIsNone(self.repo.get_by_id(999))  # not found

    # ---------- Update ----------
    def test_update_individual_fields(self):
        t = self.repo.add("Initial", "desc")
        updated = self.repo.update(t.id, title="New Title")
        self.assertIsNotNone(updated)
        self.assertEqual(updated.title, "New Title")
        self.assertEqual(updated.description, "desc")
        self.assertFalse(updated.completed)

        updated = self.repo.update(t.id, description="new desc")
        self.assertEqual(updated.description, "new desc")

        updated = self.repo.update(t.id, completed=True)
        self.assertTrue(updated.completed)

    def test_update_none_for_nonexistent(self):
        result = self.repo.update(42, title="x")
        self.assertIsNone(result)

    def test_update_does_not_change_when_no_fields_passed(self):
        t = self.repo.add("Keep", "same")
        updated = self.repo.update(t.id)  # no kwargs
        self.assertIsNotNone(updated)
        self.assertEqual(updated.title, "Keep")
        self.assertEqual(updated.description, "same")
        self.assertFalse(updated.completed)

    # ---------- Delete ----------
    def test_delete_success_and_failure(self):
        t1 = self.repo.add("A")
        t2 = self.repo.add("B")
        self.assertTrue(self.repo.delete(t1.id))   # success
        self.assertFalse(self.repo.delete(t1.id))  # already deleted
        self.assertIsNotNone(self.repo.get_by_id(t2.id))
        self.assertFalse(self.repo.delete(999))    # nonexistent

    # ---------- ID continuity after delete ----------
    def test_ids_keep_incrementing_after_deletes(self):
        t1 = self.repo.add("A")
        t2 = self.repo.add("B")
        self.repo.delete(t1.id)
        t3 = self.repo.add("C")
        # Ensure IDs continue incrementing (no reuse)
        self.assertEqual([t2.id, t3.id], [2, 3])


if __name__ == "__main__":
    unittest.main()
```

### 🏃 How to run in PyCharm / Terminal

*   **PyCharm**: Right-click `tests/test_repository.py` → **Run 'Unittests for test\_repository'**
*   **Terminal** (from project root):
    ```bash
    python -m unittest discover -s tests -p "test_*.py" -v
    ```
    or
    ```bash
    python -m unittest tests.test_repository -v
    ```

***

## (Optional) 🧪 `pytest` Version

If you prefer `pytest` and you have it installed:

**`tests/test_repository_pytest.py`**

```python
import pytest
from model.repository import TodoRepository

@pytest.fixture()
def repo():
    return TodoRepository()

def test_add_and_ids(repo):
    t1 = repo.add("A", "d1")
    t2 = repo.add("B", "d2")
    assert t1.id == 1
    assert t2.id == 2
    assert t1.completed is False

def test_list_all_copy(repo):
    repo.add("A")
    lst = repo.list_all()
    lst.clear()
    assert len(repo.list_all()) == 1

def test_get_by_id(repo):
    repo.add("A")
    repo.add("B")
    assert repo.get_by_id(2).title == "B"
    assert repo.get_by_id(999) is None

def test_update_fields(repo):
    t = repo.add("A", "d")
    updated = repo.update(t.id, title="X", completed=True)
    assert updated.title == "X"
    assert updated.completed is True
    assert repo.update(999, title="nope") is None

def test_delete(repo):
    t = repo.add("A")
    assert repo.delete(t.id) is True
    assert repo.delete(t.id) is False
    assert repo.delete(999) is False

def test_ids_increment_after_delete(repo):
    t1 = repo.add("A")
    t2 = repo.add("B")
    repo.delete(t1.id)
    t3 = repo.add("C")
    assert (t2.id, t3.id) == (2, 3)
```

Run:

```bash
pytest -q
```

***

## 🔍 Notes on What We’re Testing (Coverage)

*   **Create**
    *   IDs auto-increment
    *   Whitespace trimming for `title`/`description`
*   **Read**
    *   `list_all()` returns a **copy** to protect internal state
    *   `get_by_id()` returns `None` when not found
*   **Update**
    *   Partial updates (each field independently)
    *   Leaves fields unchanged if not provided
    *   Returns `None` for nonexistent ID
*   **Delete**
    *   Returns `True`/`False` correctly
    *   ID **not** reused after deletion
