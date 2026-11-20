For each activity, write and execute a SQL query that returns the requested result. These exercises use MySQL 8.0 window functions with the `PersonalTrainer` database.

A window function calculates a value across related rows while keeping each row in the result. `PARTITION BY` defines the groups, and `ORDER BY` defines the order inside each group. Unlike `GROUP BY`, a window function does not collapse the rows.

### Activity 1
For every Workout, select its Name, LevelId, MaxMinutes, and a row number within its Level.

Number Workouts from the longest MaxMinutes to the shortest. Break ties by Workout.Name.

### Activity 2
For every Workout, select its Name, LevelId, MaxMinutes, and rank within its Level by MaxMinutes from highest to lowest.

Use `RANK()` and explain what happens to the rank after a tie.

### Activity 3
Return up to three Clients per City. Include City, FirstName, LastName, and the Client's position within that City.

Use `ROW_NUMBER()` ordered by LastName, FirstName, and ClientId. Filter to the first three rows in each City using a derived table or CTE.

### Activity 4
For every Invoice, select ClientId, InvoiceId, InvoiceDate, and the cumulative number of invoices for that Client.

Order each Client's invoices by InvoiceDate, then InvoiceId. Include all invoice rows.

### Activity 5
For each paid Invoice, calculate the invoice total and the Client's running paid total. Include ClientId, InvoiceId, InvoiceDate, InvoiceTotal, and RunningPaidTotal.

Aggregate line items to one row per invoice before applying the running window sum. Paid invoices have InvoiceStatus = 2.

### Activity 6
For every Workout, select its Name, LevelId, MaxMinutes, and the maximum MaxMinutes among Workouts in the same Level.

Use `MAX()` as a window function. Keep all Workouts in the result.

### Activity 7
For every Invoice, select ClientId, InvoiceId, InvoiceDate, the previous InvoiceDate for that Client, and the number of days since the previous invoice.

Use `LAG()` ordered by InvoiceDate, then InvoiceId. The first invoice per Client has no previous date.

### Activity 8
Count how many Clients selected each Goal, then rank Goals from most popular to least popular.

Include GoalId, GoalName, ClientCount, and a dense rank. Use a derived table to aggregate before applying `DENSE_RANK()`.
