For each activity, write and execute a SQL query that returns the requested result. These exercises use the `PersonalTrainer` database and build on the SELECT, JOIN, and aggregate activities.

Subqueries can return a single value, a list of values, or rows that another query uses. Choose the form that best fits the question. Unless an activity gives an expected row count, compare your result with the answer key rather than assuming a particular count.

### Activity 1
Select the Name and MaxMinutes of Workouts whose MaxMinutes is greater than the average MaxMinutes for all Workouts.

Use a scalar subquery in the `WHERE` clause.

### Activity 2
Select the WorkoutId and Name of every Workout associated with the Goal named 'Core Strength'.

Use `IN` with a subquery. Return each Workout only once.

### Activity 3
Select ClientId, FirstName, and LastName for Clients who have at least one Goal.

Use `EXISTS` with a correlated subquery. Do not join ClientGoal in the outer query.

### Activity 4
Select ClientId, FirstName, and LastName for Clients who are not signed up for any Workout.

Use `NOT EXISTS`. There should be 50 rows.

### Activity 5
Select InvoiceId, ClientId, and InvoiceDate for each Invoice that is the earliest invoice for its Client.

Use a correlated scalar subquery. If a Client has multiple invoices on the same earliest date, include each of them.

### Activity 6
Select Exercise.Name, ExerciseInstanceId, and Sets for ExerciseInstances whose Sets value is greater than the average Sets for that same Exercise.

Use a correlated subquery. Order by Exercise.Name, then ExerciseInstanceId.

### Activity 7
Calculate each Invoice's total using Price * Quantity. Return InvoiceId and InvoiceTotal for invoices whose total is greater than the average invoice total.

Use a derived table to calculate invoice totals, then compare those totals to a scalar subquery that calculates the average invoice total. Do not compare to the average line-item total.

### Activity 8
Select ClientId, FirstName, and LastName for Clients whose total paid invoice amount is greater than $1,000. Paid invoices have InvoiceStatus = 2.

Use `IN` with a grouped subquery. There should be 146 rows.
