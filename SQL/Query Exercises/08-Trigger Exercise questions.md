Create and test the following triggers in the `PersonalTrainer` database. These activities use dedicated practice tables so they do not change the existing Client, Invoice, or Workout data.

Run this setup once before starting the activities:

```sql
CREATE TABLE TriggerPracticeContact (
    ContactId INT AUTO_INCREMENT PRIMARY KEY,
    EmailAddress VARCHAR(255) NOT NULL
);

CREATE TABLE TriggerPracticeProduct (
    ProductId INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE TriggerPracticePriceAudit (
    AuditId INT AUTO_INCREMENT PRIMARY KEY,
    ProductId INT NOT NULL,
    OldPrice DECIMAL(10, 2) NOT NULL,
    NewPrice DECIMAL(10, 2) NOT NULL,
    ChangedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO TriggerPracticeProduct (ProductId, ProductName, Price)
VALUES (1, 'Practice product', 10.00);
```

Use MySQL 8.0. When you create a trigger with a compound body, use your SQL client's delimiter feature.

### Activity 1
Create a `BEFORE INSERT` trigger on TriggerPracticeContact that trims surrounding spaces from EmailAddress and stores it in lowercase.

Insert an email address containing leading/trailing spaces and uppercase letters. Query the stored value to verify the trigger ran.

### Activity 2
Create a `BEFORE INSERT` trigger on TriggerPracticeProduct that raises an error with `SIGNAL SQLSTATE '45000'` when Price is negative.

Insert one valid row to verify it succeeds. Then try a negative price and confirm that the statement is rejected and no product row is inserted for it.

### Activity 3
Create an `AFTER UPDATE` trigger on TriggerPracticeProduct that adds a row to TriggerPracticePriceAudit when Price changes.

Store ProductId, OLD.Price, NEW.Price, and the audit timestamp. Update ProductId 1 to a different price and inspect the audit row.

### Activity 4
Use `SHOW TRIGGERS` and `SHOW CREATE TRIGGER` to inspect the triggers. Drop only the three exercise triggers using `DROP TRIGGER IF EXISTS`.
