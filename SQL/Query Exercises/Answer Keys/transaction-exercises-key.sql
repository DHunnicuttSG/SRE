USE PersonalTrainer;

-- Setup for transaction exercises.
CREATE TABLE IF NOT EXISTS TransactionPracticeAccount (
    AccountId INT PRIMARY KEY,
    Holder VARCHAR(100) NOT NULL,
    Balance DECIMAL(12, 2) NOT NULL
) ENGINE = InnoDB;

INSERT IGNORE INTO TransactionPracticeAccount (AccountId, Holder, Balance)
VALUES
    (1, 'Alex', 1000.00),
    (2, 'Blair', 500.00),
    (3, 'Casey', 750.00);

--------------------

-- Activity 1
-- Commit a transfer from Account 1 to Account 2.
UPDATE TransactionPracticeAccount
SET Balance = CASE AccountId
    WHEN 1 THEN 1000.00
    WHEN 2 THEN 500.00
    WHEN 3 THEN 750.00
END
WHERE AccountId IN (1, 2, 3);

START TRANSACTION;

UPDATE TransactionPracticeAccount
SET Balance = Balance - 100.00
WHERE AccountId = 1
  AND Balance >= 100.00;

SELECT ROW_COUNT() DebitRowsAffected;

UPDATE TransactionPracticeAccount
SET Balance = Balance + 100.00
WHERE AccountId = 2;

SELECT AccountId, Holder, Balance
FROM TransactionPracticeAccount
ORDER BY AccountId;

COMMIT;

SELECT AccountId, Holder, Balance
FROM TransactionPracticeAccount
ORDER BY AccountId;

--------------------

-- Activity 2
-- Roll back an incorrect update to Account 2.
UPDATE TransactionPracticeAccount
SET Balance = CASE AccountId
    WHEN 1 THEN 1000.00
    WHEN 2 THEN 500.00
    WHEN 3 THEN 750.00
END
WHERE AccountId IN (1, 2, 3);

START TRANSACTION;

UPDATE TransactionPracticeAccount
SET Balance = Balance + 500.00
WHERE AccountId = 2;

SELECT AccountId, Holder, Balance
FROM TransactionPracticeAccount
WHERE AccountId = 2;

ROLLBACK;

SELECT AccountId, Holder, Balance
FROM TransactionPracticeAccount
WHERE AccountId = 2;

--------------------

-- Activity 3
-- Keep the debit, undo the first credit, then credit Account 3.
UPDATE TransactionPracticeAccount
SET Balance = CASE AccountId
    WHEN 1 THEN 1000.00
    WHEN 2 THEN 500.00
    WHEN 3 THEN 750.00
END
WHERE AccountId IN (1, 2, 3);

START TRANSACTION;

UPDATE TransactionPracticeAccount
SET Balance = Balance - 200.00
WHERE AccountId = 1
  AND Balance >= 200.00;

SAVEPOINT after_debit;

UPDATE TransactionPracticeAccount
SET Balance = Balance + 200.00
WHERE AccountId = 2;

ROLLBACK TO SAVEPOINT after_debit;

UPDATE TransactionPracticeAccount
SET Balance = Balance + 200.00
WHERE AccountId = 3;

COMMIT;

SELECT AccountId, Holder, Balance
FROM TransactionPracticeAccount
ORDER BY AccountId;

--------------------

-- Activity 4
-- Demonstrate a REPEATABLE READ snapshot using two sessions.
UPDATE TransactionPracticeAccount
SET Balance = 1000.00
WHERE AccountId = 1;

-- Run the following in Session B first:
-- SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- START TRANSACTION;
-- SELECT Balance FROM TransactionPracticeAccount WHERE AccountId = 1;
-- Expected: 1000.00
--
-- While Session B remains open, run in Session A:
-- START TRANSACTION;
-- UPDATE TransactionPracticeAccount
-- SET Balance = Balance - 50.00
-- WHERE AccountId = 1;
-- COMMIT;
--
-- Back in Session B, run:
-- SELECT Balance FROM TransactionPracticeAccount WHERE AccountId = 1;
-- Expected before Session B commits: 1000.00 (the transaction's snapshot)
-- COMMIT;
-- SELECT Balance FROM TransactionPracticeAccount WHERE AccountId = 1;
-- Expected after Session B commits: 950.00
--
-- Reset Account 1 before repeating this multi-session demonstration:
-- UPDATE TransactionPracticeAccount SET Balance = 1000.00 WHERE AccountId = 1;

--------------------

-- Activity 5
-- Discussion:
-- ROLLBACK cannot undo committed work, nontransactional-table changes,
-- or work committed implicitly by a statement.
-- Check affected-row counts before committing a multi-step operation.
-- After a deadlock, retry the complete logical transaction.
