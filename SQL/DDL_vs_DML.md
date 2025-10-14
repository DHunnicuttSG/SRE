# 🧩 DDL vs. DML Overview

In SQL, commands are grouped into **language subsets** based on what they do:

| Category | Stands For                   | Purpose                                                                                |
| -------- | ---------------------------- | -------------------------------------------------------------------------------------- |
| **DDL**  | Data Definition Language     | Defines and manages the structure of the database (tables, schemas, constraints, etc.) |
| **DML**  | Data Manipulation Language   | Works with the actual data inside tables (insert, update, delete, select)              |
| **DCL**  | Data Control Language        | Manages access and permissions (e.g., `GRANT`, `REVOKE`)                               |
| **TCL**  | Transaction Control Language | Manages transactions (`COMMIT`, `ROLLBACK`, `SAVEPOINT`)                               |

We’ll focus on **DDL** and **DML** here.

---

# 🧱 DDL — *Data Definition Language*

### 📘 Definition:

> DDL statements are used to **create, modify, or delete database structures**, such as tables, indexes, and constraints.

DDL commands affect the *schema* (the blueprint) of your database.

---

## 🧩 Common DDL Commands

| Command    | Purpose                                                     | Example                                               |
| ---------- | ----------------------------------------------------------- | ----------------------------------------------------- |
| `CREATE`   | Create a new database object (like a table, view, or index) | `CREATE TABLE students (...);`                        |
| `ALTER`    | Modify an existing database object                          | `ALTER TABLE students ADD COLUMN email VARCHAR(100);` |
| `DROP`     | Delete an existing database object completely               | `DROP TABLE students;`                                |
| `TRUNCATE` | Remove all data from a table but keep the structure         | `TRUNCATE TABLE students;`                            |
| `RENAME`   | Rename a table or column                                    | `RENAME TABLE students TO learners;`                  |

---

## 🧱 DDL in Action

### 1️⃣ Create a Table

```sql
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    grade CHAR(2),
    enrollment_date DATE DEFAULT (CURRENT_DATE)
);
```

**Explanation:**

* `CREATE TABLE` defines the table.
* `AUTO_INCREMENT` automatically generates IDs.
* `PRIMARY KEY` ensures unique identifiers.
* `DEFAULT` sets a default value when none is provided.

---

### 2️⃣ Alter a Table

```sql
ALTER TABLE students
ADD COLUMN email VARCHAR(100);
```

✅ Adds a new column.

```sql
ALTER TABLE students
MODIFY COLUMN grade VARCHAR(3);
```

✅ Changes column data type.

```sql
ALTER TABLE students
DROP COLUMN grade;
```

✅ Removes a column.

---

### 3️⃣ Drop a Table

```sql
DROP TABLE students;
```

⚠️ **Irreversible!** The structure *and all data* are deleted.

---

### 4️⃣ Truncate a Table

```sql
TRUNCATE TABLE students;
```

✅ Deletes all data but keeps table structure for reuse.
⚡ Faster than `DELETE FROM students;` because it doesn’t log each row deletion.

---

# 🧩 DML — *Data Manipulation Language*

### 📘 Definition:

> DML statements are used to **insert, update, delete, or retrieve** data stored in the database tables.

DML affects the *contents* of the tables — the rows.

---

## 🔹 Common DML Commands

| Command  | Purpose                   | Example                                 |
| -------- | ------------------------- | --------------------------------------- |
| `SELECT` | Retrieve data from tables | `SELECT * FROM students;`               |
| `INSERT` | Add new rows              | `INSERT INTO students VALUES (...);`    |
| `UPDATE` | Modify existing data      | `UPDATE students SET grade='A';`        |
| `DELETE` | Remove rows               | `DELETE FROM students WHERE grade='F';` |

---

## 🧱 DML in Action

### 1️⃣ Insert Data

```sql
INSERT INTO students (first_name, last_name, grade, enrollment_date)
VALUES ('Alice', 'Smith', 'A', '2025-09-01');
```

➡️ Adds a new row to the `students` table.

---

### 2️⃣ Select Data

```sql
SELECT first_name, last_name, grade
FROM students
WHERE grade = 'A';
```

➡️ Retrieves all students with grade “A”.

---

### 3️⃣ Update Data

```sql
UPDATE students
SET grade = 'B'
WHERE student_id = 2;
```

➡️ Changes the grade of the student with ID = 2.

---

### 4️⃣ Delete Data

```sql
DELETE FROM students
WHERE grade = 'F';
```

➡️ Removes all students who failed.

---

# ⚙️ Key Differences Between DDL and DML

| Feature              | DDL                                   | DML                                    |
| -------------------- | ------------------------------------- | -------------------------------------- |
| **Purpose**          | Defines the structure                 | Manages the data                       |
| **Examples**         | `CREATE`, `ALTER`, `DROP`, `TRUNCATE` | `SELECT`, `INSERT`, `UPDATE`, `DELETE` |
| **Affects**          | Schema (tables, columns, constraints) | Data (rows in tables)                  |
| **Rollback Support** | ❌ Auto-committed (cannot roll back)   | ✅ Transactional (can roll back)        |
| **Frequency of Use** | Rare (setup stage)                    | Frequent (everyday operations)         |

---

# 🧠 Real-World Analogy

| Concept | Analogy                                                                             |
| ------- | ----------------------------------------------------------------------------------- |
| **DDL** | Designing and building a bookshelf (structure: number of shelves, height, material) |
| **DML** | Placing books, rearranging them, or removing them (the actual data)                 |

You define the structure *once* (DDL) but use and modify the contents *many times* (DML).

---

# ✅ Summary

| Category | Full Form                  | Purpose                      | Common Commands                                 |
| -------- | -------------------------- | ---------------------------- | ----------------------------------------------- |
| **DDL**  | Data Definition Language   | Create and modify structures | `CREATE`, `ALTER`, `DROP`, `TRUNCATE`, `RENAME` |
| **DML**  | Data Manipulation Language | Work with data inside tables | `SELECT`, `INSERT`, `UPDATE`, `DELETE`          |

---
