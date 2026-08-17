# MySQL Lesson: Stored Procedures, Triggers, and Deadlocks

## Lesson Information

**Course:** MySQL Database Development  
**Topic:** Stored Procedures, Triggers, and Deadlocks  
**Duration:** 90–120 Minutes  
**Skill Level:** Intermediate

---

# Learning Objectives

By the end of this lesson, students will be able to:

- Define and explain the purpose of stored procedures.
- Create and execute stored procedures in MySQL.
- Define and explain database triggers.
- Create BEFORE and AFTER triggers.
- Explain what database deadlocks are.
- Identify the causes of deadlocks.
- Apply best practices to prevent deadlocks.

---

# Introduction

As databases grow in complexity, developers need ways to automate tasks, enforce business rules, and manage concurrent access to data.

MySQL provides several features to help accomplish these goals:

- **Stored Procedures** allow reusable SQL logic to be stored within the database.
- **Triggers** automatically execute when specific database events occur.
- **Deadlock Management** helps developers understand and resolve transaction conflicts.

This lesson explores each concept through examples and hands-on activities.

---

# Part 1: Stored Procedures

## What Is a Stored Procedure?

A stored procedure is a collection of SQL statements that is saved in the database and executed as a single unit.

Instead of writing the same SQL repeatedly in an application, the logic can be stored directly in MySQL.

### Benefits of Stored Procedures

- Reduce duplicate code
- Improve maintainability
- Increase consistency
- Reduce network traffic
- Enhance security
- Centralize business logic

---

## Basic Stored Procedure Syntax

```sql
DELIMITER //

CREATE PROCEDURE procedure_name()
BEGIN
    -- SQL statements
END //

DELIMITER ;
```

### Explanation

A different delimiter is temporarily used because semicolons are required within the procedure body.

Once the procedure is created, the delimiter is changed back to its default value.

---

## Sample Data

Create a table for the examples:

```sql
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Email VARCHAR(100)
);
```

Insert some sample data:

```sql
INSERT INTO Customers (CustomerName, Email)
VALUES
('Alice Johnson', 'alice@email.com'),
('Brian Smith', 'brian@email.com'),
('Carol Davis', 'carol@email.com');
```

---

## Example 1: Procedure Without Parameters

Create a procedure that returns all customers.

```sql
DELIMITER //

CREATE PROCEDURE GetCustomers()
BEGIN
    SELECT *
    FROM Customers;
END //

DELIMITER ;
```

Execute the procedure:

```sql
CALL GetCustomers();
```

### Expected Result

```text
CustomerID | CustomerName   | Email
-----------|---------------|--------------------
1          | Alice Johnson | alice@email.com
2          | Brian Smith   | brian@email.com
3          | Carol Davis   | carol@email.com
```

---

## Example 2: Procedure With Input Parameters

Create a procedure that returns a customer by ID.

```sql
DELIMITER //

CREATE PROCEDURE GetCustomerById(
    IN p_customer_id INT
)
BEGIN
    SELECT *
    FROM Customers
    WHERE CustomerID = p_customer_id;
END //

DELIMITER ;
```

Execute:

```sql
CALL GetCustomerById(2);
```

### Expected Result

```text
CustomerID | CustomerName
-----------|-------------
2          | Brian Smith
```

---

## Parameter Types

### IN

Accepts values into the procedure.

```sql
IN p_customer_id INT
```

### OUT

Returns a value from the procedure.

```sql
OUT totalCustomers INT
```

### INOUT

Accepts input and returns output.

```sql
INOUT counter INT
```

---

## Example 3: Procedure Using an OUT Parameter

```sql
DELIMITER //

CREATE PROCEDURE GetCustomerCount(
    OUT totalCount INT
)
BEGIN
    SELECT COUNT(*)
    INTO totalCount
    FROM Customers;
END //

DELIMITER ;
```

Execute:

```sql
CALL GetCustomerCount(@count);

SELECT @count;
```

---
## Example 4: Procedure for Adding Customers

```sql
DELIMITER //

CREATE PROCEDURE AddCustomer(
    IN p_name VARCHAR(100),
    IN p_email VARCHAR(100)
)
BEGIN
    INSERT INTO Customers
    (
        CustomerName,
        Email
    )
    VALUES
    (
        p_name,
        p_email
    );

    SELECT 'Customer added Successfully' AS Message;
END //

DELIMITER ;
```

Execute:

```sql
CALL AddCustomer(
    'David Hunnicutt',
    'hunnicutt@email.com'
);
```
---

## Stored Procedure Best Practices

- Use meaningful names.
- Keep procedures focused on a single task.
- Validate input parameters.
- Document complex logic.
- Limit unnecessary database calls.

---

## Activity: Create a Procedure

### Requirement

Create a procedure named:

```text
GetProductsByCategory
```

The procedure should:

1. Accept a category name.
2. Return all products in that category.

### Example Execution

```sql
CALL GetProductsByCategory('Electronics');
```

---

## Knowledge Check

1. What command executes a stored procedure?
2. What keyword declares an input parameter?
3. Why are stored procedures useful?

### *Answers*
1. `CALL`
2. `IN`
3. They allow reusable and centralized business logic.
---

# Part 2: Triggers

## What is a Trigger?

A trigger is a database object that automatically executes when a specified event occurs on a table.

Triggers respond to:

- INSERT
- UPDATE
- DELETE

No user intervention is required.

---

# Why Use Triggers?

Triggers are commonly used for:

- Auditing changes to data
- Enforcing business rules
- Validating data before it is saved
- Logging activity
- Automatically maintaining related data

Because triggers execute automatically, they help ensure consistency without requiring changes in application code.

---

# Trigger Types

## BEFORE INSERT

Executes before a new row is inserted into a table.

### Common Uses

- Data validation
- Setting default values
- Enforcing business rules

---

## AFTER INSERT

Executes after a row has been inserted.

### Common Uses

- Audit logging
- Notifications
- Updating summary tables

---

## BEFORE UPDATE

Executes before an existing row is modified.

### Common Uses

- Validation checks
- Preventing invalid updates
- Recording historical values

---

## AFTER UPDATE

Executes after a row has been updated.

### Common Uses

- Audit logging
- Synchronizing related tables
- Tracking data changes

---

## BEFORE DELETE

Executes before a row is deleted.

### Common Uses

- Preventing accidental deletions
- Archiving data before removal

---

## AFTER DELETE

Executes after a row has been deleted.

### Common Uses

- Audit logging
- Cleanup operations
- Historical tracking

---

# Sample Tables

## Employees Table

```sql
CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    Salary DECIMAL(10,2)
);
```

## Employee Audit Table

```sql
CREATE TABLE EmployeeAudit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT,
    ActionPerformed VARCHAR(50),
    ActionDate DATETIME
);
```

---

# Example 1: AFTER INSERT Trigger

This trigger records employee inserts in the audit table.

```sql
DELIMITER //

CREATE TRIGGER trg_AfterEmployeeInsert
AFTER INSERT ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO EmployeeAudit
    (
        EmployeeID,
        ActionPerformed,
        ActionDate
    )
    VALUES
    (
        NEW.EmployeeID,
        'INSERT',
        NOW()
    );
END //

DELIMITER ;
```

---

# Testing the Trigger

Insert a new employee:

```sql
INSERT INTO Employees
(
    EmployeeName,
    Salary
)
VALUES
(
    'Sarah Miller',
    65000
);
```

Verify the audit record:

```sql
SELECT *
FROM EmployeeAudit;
```

### Expected Result

```text
AuditID | EmployeeID | ActionPerformed | ActionDate
--------|------------|----------------|---------------------
1       | 1          | INSERT         | 2025-01-01 10:00:00
```

---

# Example 2: BEFORE UPDATE Trigger

Prevent employees from having a negative salary.

```sql
DELIMITER //

CREATE TRIGGER trg_ValidateSalary
BEFORE UPDATE ON Employees
FOR EACH ROW
BEGIN
    IF NEW.Salary < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be negative';
    END IF;
END //

DELIMITER ;
```

---

# Testing the Validation Trigger

Attempt to update a salary:

```sql
UPDATE Employees
SET Salary = -1000
WHERE EmployeeID = 1;
```

### Expected Result

```text
ERROR: Salary cannot be negative
```

The update is rejected because the trigger prevents invalid values.

---

# Example 3: AFTER DELETE Trigger

Record deleted employees in the audit table.

```sql
DELIMITER //

CREATE TRIGGER trg_AfterEmployeeDelete
AFTER DELETE ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO EmployeeAudit
    (
        EmployeeID,
        ActionPerformed,
        ActionDate
    )
    VALUES
    (
        OLD.EmployeeID,
        'DELETE',
        NOW()
    );
END //

DELIMITER ;
```

---

# Understanding NEW and OLD

Triggers provide access to row values through two special keywords.

## NEW

Represents the values being inserted or updated.

Example:

```sql
NEW.Salary
```

```sql
NEW.EmployeeName
```

Used with:

- INSERT triggers
- UPDATE triggers

---

## OLD

Represents the row values before an update or delete operation.

Example:

```sql
OLD.Salary
```

```sql
OLD.EmployeeName
```

Used with:

- UPDATE triggers
- DELETE triggers

---

# Trigger Flow Example

```text
Employee Record Inserted
            |
            V
AFTER INSERT Trigger Executes
            |
            V
Audit Record Created
            |
            V
Transaction Completes
```

---
## Some useful trigger commands:
 - show triggers - list all triggers
 - show triggers from <db_name> - list triggers in database
 - show create trigger <trigger_name> - shows code for trigger


---
# Trigger Best Practices

- Keep trigger logic simple.
- Avoid placing large amounts of business logic in triggers.
- Document trigger behavior clearly.
- Test triggers thoroughly.
- Monitor performance when triggers execute frequently.
- Use triggers primarily for auditing and validation.

---

# Hands-On Activity

## Product Audit Trigger

Create a trigger that:

1. Executes after a new product is inserted.
2. Stores the ProductID in an audit table.
3. Records the action type.
4. Saves the date and time of the insert.

### Example Audit Table

```sql
CREATE TABLE ProductAudit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    ActionType VARCHAR(50),
    ActionDate DATETIME
);
```

---

# Knowledge Check

### Question 1

What database object automatically executes when table data changes?

### Answer

A trigger.

---

### Question 2

Which keyword references the newly inserted values?

### Answer

`NEW`

---

### Question 3

Which trigger type executes before a row is updated?

### Answer

`BEFORE UPDATE`

---

# Part 3: Deadlocks

## What Is a Deadlock?

A deadlock occurs when two or more transactions each hold locks that the other transactions need in order to continue.

Because each transaction is waiting on the other, neither can proceed.

MySQL detects this condition and automatically rolls back one of the transactions to break the deadlock.

---

# Real-World Example

Imagine two employees working in a file room:

- Employee A has File Cabinet 1 and needs File Cabinet 2.
- Employee B has File Cabinet 2 and needs File Cabinet 1.

Neither employee can continue because each is waiting for access to the cabinet currently being used by the other.

This situation is similar to a database deadlock.

---

# Transaction Review

A transaction is a group of SQL statements treated as a single unit of work.

Example:

```sql
START TRANSACTION;

UPDATE Accounts
SET Balance = Balance - 100
WHERE AccountID = 1;

COMMIT;
```

Transactions help maintain:

- Consistency
- Reliability
- Data integrity

---

# Setup for Deadlock Demonstration

Create an accounts table.

```sql
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    Balance DECIMAL(10,2)
);
```

Insert sample accounts.

```sql
INSERT INTO Accounts
VALUES
(1, 1000.00),
(2, 1500.00);
```

---

# Session A

Open Query Window #1.

Start a transaction:

```sql
START TRANSACTION;
```

Lock Account 1:

```sql
UPDATE Accounts
SET Balance = Balance - 100
WHERE AccountID = 1;
```

Then attempt:

```sql
UPDATE Accounts
SET Balance = Balance + 100
WHERE AccountID = 2;
```

If Account 2 is already locked, this statement waits.

---

# Session B

Open Query Window #2.

Start a transaction:

```sql
START TRANSACTION;
```

Lock Account 2:

```sql
UPDATE Accounts
SET Balance = Balance - 50
WHERE AccountID = 2;
```

Then attempt:

```sql
UPDATE Accounts
SET Balance = Balance + 50
WHERE AccountID = 1;
```

If Account 1 is already locked, this statement waits.

---

# What Happens?

```text
Session A locks Account 1
Session B locks Account 2

Session A needs Account 2
Session B needs Account 1

Both sessions wait indefinitely

Deadlock occurs
```

---

# MySQL Deadlock Detection

MySQL automatically detects deadlocks.

One transaction receives an error similar to:

```text
ERROR 1213 (40001):
Deadlock found when trying to get lock;
try restarting transaction
```

The selected transaction is rolled back and the other transaction is allowed to continue.

---

# Viewing Deadlock Information

To see information about the most recent deadlock:

```sql
SHOW ENGINE INNODB STATUS;
```

Look for the section:

```text
LATEST DETECTED DEADLOCK
```

This report includes:

- Transactions involved
- SQL statements executed
- Locked records
- Transaction selected for rollback

---

# Common Causes of Deadlocks

## Different Resource Access Order

### Transaction A

```sql
UPDATE Accounts
SET Balance = Balance - 100
WHERE AccountID = 1;

UPDATE Accounts
SET Balance = Balance + 100
WHERE AccountID = 2;
```

### Transaction B

```sql
UPDATE Accounts
SET Balance = Balance - 50
WHERE AccountID = 2;

UPDATE Accounts
SET Balance = Balance + 50
WHERE AccountID = 1;
```

Because the rows are accessed in different orders, a deadlock becomes possible.

---

## Long-Running Transactions

```sql
START TRANSACTION;

UPDATE Products
SET Price = Price * 1.10;

/* Transaction remains open */

COMMIT;
```

The longer locks remain active, the more likely lock conflicts become.

---

## Missing indexes

```sql
UPDATE Orders
SET Status = 'Shipped'
WHERE CustomerID = 100;
```

Without an appropriate index, MySQL may scan and lock more rows than necessary.

---

## Large Batch Updates

Operations that update thousands of rows simultaneously can create heavy lock contentions

Example:

```sql
UPDATE Orders
SET Status = 'Archived'
WHERE OrderDate < '2024-01-01';
```

---

# Preventing Deadlocks

## Access Resources in a Consistent Order

Good Example:

```text
Transaction A
-------------
Account 1
Account 2

Transaction B
-------------
Account 1
Account 2
```

Both transactions acquire locks in the same sequence.

---

## Keep Transactions Short

```sql
START TRANSACTION;

UPDATE Accounts
SET Balance = Balance - 100
WHERE AccountID = 1;

COMMIT;
```

Complete work quickly and commit as soon as possible.

---

## Create Appropriate Indexes

```sql
CREATE INDEX idx_customer
ON Orders(CustomerID);
```

Indexes reduce scanning and minimize locking.

---

## Implement Retry Logic

Applications should detect deadlock errors and retry the transaction.

Pseudo-code:

```text
Execute Transaction

If Deadlock Occurs
    Roll Back
    Retry Transaction
```

---

# Hands-On Activity

## Reproducing a Deadlock

### Step 1

Open two MySQL query windows.

### Step 2

Create and populate the Accounts table.

### Step 3

Run the Session A statements.

### Step 4

Run the Session B statements.

### Step 5

Observe the deadlock error message.

### Step 6

Run:

```sql
SHOW ENGINE INNODB STATUS;
```

### Step 7

Review the deadlock report and identify:

- Which transaction was rolled back
- Which statements caused the deadlock
- Which resources were locked