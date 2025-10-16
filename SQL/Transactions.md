# MySQL Transactions

## 🧱 Step 1: Create a Sample Table

```sql
CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(50),
    balance DECIMAL(10,2)
);
```

---

## 🧩 Step 2: Insert Sample Data

```sql
INSERT INTO accounts (customer_name, balance)
VALUES 
('Alice', 1000.00),
('Bob', 500.00),
('Carol', 750.00);
```

Check it:

```sql
SELECT * FROM accounts;
```

**Result:**

| account_id | customer_name | balance |
| ---------- | ------------- | ------- |
| 1          | Alice         | 1000.00 |
| 2          | Bob           | 500.00  |
| 3          | Carol         | 750.00  |

---

## 🧮 Step 3: Start a Transaction

In MySQL, transactions are **explicitly started** with `START TRANSACTION` or `BEGIN`.

```sql
START TRANSACTION;
```

---

## 🧠 Step 4: Run an Update Query

Let’s say you accidentally credit Bob with too much money:

```sql
UPDATE accounts
SET balance = balance + 1000
WHERE customer_name = 'Bob';
```

Now check the data (still inside the transaction):

```sql
SELECT * FROM accounts;
```

**Temporary result (uncommitted):**

| account_id | customer_name | balance |
| ---------- | ------------- | ------- |
| 1          | Alice         | 1000.00 |
| 2          | Bob           | 1500.00 |
| 3          | Carol         | 750.00  |

---

## 🧩 Step 5: Decide to Roll Back

You realize the update was a mistake — so instead of saving it, you **rollback**:

```sql
ROLLBACK;
```

This undoes all changes made since `START TRANSACTION`.

---

## ✅ Step 6: Verify the Rollback

Now check the data again:

```sql
SELECT * FROM accounts;
```

**Result after rollback:**

| account_id | customer_name | balance |
| ---------- | ------------- | ------- |
| 1          | Alice         | 1000.00 |
| 2          | Bob           | 500.00  |
| 3          | Carol         | 750.00  |

💡 The data is restored exactly as it was before the transaction started.

---

## 🧾 Step 7: Try a Commit (for comparison)

If instead you wanted to **keep** the change, you’d use:

```sql
START TRANSACTION;

UPDATE accounts
SET balance = balance + 100
WHERE customer_name = 'Carol';

COMMIT;
```

Now the change is permanent.

---

# ⚙️ Key Notes on Transactions

| Command                       | Purpose                                        |
| ----------------------------- | ---------------------------------------------- |
| `START TRANSACTION` / `BEGIN` | Begin a new transaction                        |
| `COMMIT`                      | Save all changes permanently                   |
| `ROLLBACK`                    | Undo all changes since the transaction began   |
| `SAVEPOINT name`              | Create a checkpoint to roll back to (optional) |
| `ROLLBACK TO name`            | Roll back to a specific savepoint              |

---

# 🧩 Optional: Using a SAVEPOINT Example

```sql
START TRANSACTION;

UPDATE accounts SET balance = balance - 200 WHERE customer_name = 'Alice';
SAVEPOINT after_alice;

UPDATE accounts SET balance = balance + 200 WHERE customer_name = 'Bob';

-- Oops, we only want to undo the last step
ROLLBACK TO after_alice;

COMMIT;
```

Now only the first update (Alice’s withdrawal) is saved.

---

✅ **Summary**

* Use `START TRANSACTION` → make your changes → `COMMIT` or `ROLLBACK`.
* Transactions protect your data from accidental or partial updates.
* Great for operations involving **multiple dependent updates**, like bank transfers, order processing, or inventory updates.

---

