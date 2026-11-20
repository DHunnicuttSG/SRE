These activities use a dedicated InnoDB practice table. They do not modify the existing Client, Invoice, or Workout data.

Run this setup once:

```sql
CREATE TABLE TransactionPracticeAccount (
    AccountId INT PRIMARY KEY,
    Holder VARCHAR(100) NOT NULL,
    Balance DECIMAL(12, 2) NOT NULL
) ENGINE = InnoDB;

INSERT INTO TransactionPracticeAccount (AccountId, Holder, Balance)
VALUES
    (1, 'Alex', 1000.00),
    (2, 'Blair', 500.00),
    (3, 'Casey', 750.00);
```

If the table already exists, reset these three practice rows to the listed starting balances before repeating an activity. Do not put setup DDL inside a transaction you intend to roll back.

### Activity 1: Commit a Transfer
Transfer $100.00 from Account 1 to Account 2.

Use one transaction for both updates. Check the balances before and after `COMMIT`. Starting from the setup balances, the final balances should be $900.00 for Account 1 and $600.00 for Account 2.

### Activity 2: Roll Back an Incorrect Update
Start from the setup balances. Add $500.00 to Account 2 inside a transaction, verify the uncommitted balance in your session, then roll back.

Confirm that Account 2's balance is still $500.00 after the rollback.

### Activity 3: Use a Savepoint
Start from the setup balances. Within one transaction:

1. Subtract $200.00 from Account 1.
2. Create a savepoint named `after_debit`.
3. Add $200.00 to Account 2.
4. Roll back to `after_debit`, undoing that credit but keeping the debit.
5. Add $200.00 to Account 3 instead.
6. Commit the transaction.

Verify the final balances: Account 1 is $800.00, Account 2 is $500.00, and Account 3 is $950.00.

### Activity 4: Observe a Repeatable-Read Snapshot
Use two database sessions and reset the practice balances first. Follow the steps in the answer key.

Set Session B's next transaction to `REPEATABLE READ`. Start a transaction in Session B and read Account 1's balance. While Session B remains open, update and commit Account 1 in Session A. Read the balance again in Session B before and after committing its transaction.

Record which values Session B sees and explain why the later read changes after Session B commits.

### Activity 5: Review Transaction Safety
Answer these questions:

- What can prevent a `ROLLBACK` from undoing a statement?
- Why should an application check the number of affected rows before committing?
- If InnoDB reports a deadlock, which unit of work should the application retry?
