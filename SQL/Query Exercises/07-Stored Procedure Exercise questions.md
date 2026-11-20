For each activity, create and call a stored procedure in the `PersonalTrainer` database. These exercises use MySQL 8.0.

Use the MySQL client or GUI tool's delimiter feature when creating procedures with compound bodies. The `DELIMITER` command is handled by the client.

### Activity 1
Create a procedure named `GetWorkoutsByLevel` with an `IN` parameter for LevelId.

Return WorkoutId, Name, and MaxMinutes for Workouts in that Level. Order by Name. Call the procedure for LevelId 1.

### Activity 2
Create a procedure named `GetInvoiceTotal` with an `IN` parameter for InvoiceId and an `OUT` parameter for the total.

Calculate the total using Price * Quantity from InvoiceLineItem. If the Invoice exists but has no line items, return zero. If the InvoiceId does not exist, raise a user-defined error with `SIGNAL`.

Demonstrate the procedure using a valid InvoiceId and a user-defined session variable to receive the total.

### Activity 3
Create a procedure named `GetClientInvoiceSummary` with one `IN` parameter for ClientId and two `OUT` parameters:

- The number of Invoices for that Client
- The total amount from that Client's paid Invoices

Paid Invoices have InvoiceStatus = 2. Return zero for the paid total when there are no paid line items. Call the procedure for a ClientId taken from the Invoice table.

### Activity 4
Create a procedure named `AddLevelWorkoutCount` with an `IN` parameter for LevelId and an `INOUT` parameter for a running count.

Add the number of Workouts in that Level to the running count. Initialize the user variable to 10, call the procedure for LevelId 1, then display the updated value.

### Activity 5
Inspect the definitions of the procedures you created. Then drop only these exercise procedures using `DROP PROCEDURE IF EXISTS`.
