For each activity, write and execute a SQL query using a common table expression (CTE). These exercises use MySQL 8.0 and the `PersonalTrainer` database.

A CTE is a named query introduced with `WITH`. It exists for one statement and can make a multi-step query easier to read. A recursive CTE references itself and is useful for hierarchical data.

### Activity 1
Create a CTE named WorkoutDurations that selects WorkoutId, Name, LevelId, MinMinutes, and MaxMinutes from Workout.

Use the CTE to select Workouts where MaxMinutes is at least 60. Return the Workout name and duration range.

### Activity 2
Return every Client's ClientId, FirstName, LastName, and GoalCount, including Clients who have no Goals.

Use one CTE to count ClientGoal rows by ClientId, then left join it to Client. Display 0 for Clients with no Goals.

### Activity 3
Find Clients with more than $1,000 in paid invoice totals. Paid invoices have InvoiceStatus = 2.

Use one CTE to calculate paid totals by ClientId, then join it to Client. Return ClientId, FirstName, LastName, and PaidTotal. There should be 146 rows.

### Activity 4
For each Goal, show its name, the number of Clients who selected it, and the number of Workouts associated with it.

Use separate CTEs to calculate Client counts and Workout counts, then join those results to Goal. Include Goals with zero related rows.

### Activity 5
For every Workout, show its Name, LevelId, MaxMinutes, and the average MaxMinutes for its Level. Return only Workouts whose MaxMinutes is above their Level's average.

Use a CTE with a windowed `AVG()` and filter its results in the outer query.

### Activity 6
Display every ExerciseCategory in a hierarchy, with its CategoryId, ParentCategoryId, depth starting at 0, and a path from the root category to that category.

Use a recursive CTE that starts with categories whose ParentCategoryId is NULL and follows ParentCategoryId to child categories. Order by the path.

### Activity 7
For each Client who has invoices, return their highest-total invoice or invoices. Include ClientId, InvoiceId, InvoiceDate, InvoiceTotal, and the rank of the invoice within that Client.

Use one CTE to calculate totals per invoice and another to rank invoices per Client. Keep ties for the highest total.
