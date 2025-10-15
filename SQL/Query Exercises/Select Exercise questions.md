For each of the activities below, write and execute a SQL SELECT statement that will produce the correct results. Each activity includes the expected number of records for each query, but you should also be sure that the results include only the named columns.

Keep in mind that there's usually more than one correct way to write a query. If yours is different the query written by a classmate or your instructor, it may still be correct. Run both and compare the results.

### Activity 1
Select all rows and columns from the Exercise table. (64 rows)

### Activity 2
Select all rows and columns from the Client table. (500 rows)

### Activity 3
Select all columns from Client where the City is Metairie. (29 rows)

### Activity 4
Is there a Client with the ClientId '818u7faf-7b4b-48a2-bf12-7a26c92de20c'? (0 rows)

### Activity 5
How many rows are in the Goal table? (17 rows)

### Activity 6
Select Name and LevelId from the Workout table. (26 rows)

### Activity 7
Select Name, LevelId, and Notes from Workout where LevelId is 2. (11 rows)

### Activity 8
Select FirstName, LastName, and City from Client where City is Metairie, Kenner, or Gretna. (77 rows)

### Activity 9
Select FirstName, LastName, and BirthDate from Client for Clients born in the 1980s. (72 rows)

### Activity 10
Write the query above in a different way.

If you used BETWEEN, you can't use it again.
If you didn't use BETWEEN, use it!
The results should still have 72 rows.

### Activity 11
How many rows in the Login table have a .gov EmailAddress? (17 rows)

### Activity 12
How many Logins do NOT have a .com EmailAddress? (122 rows)

### Activity 13
Select first and last name of Clients without a BirthDate. (37 rows)

### Activity 14
Select the Name of each ExerciseCategory that has a parent (ParentCategoryId value is not null). (12 rows)

### Activity 15
Select Name and Notes of each level 3 Workout that contains the word 'you' in its Notes. (4 rows)

### Activity 16
Select FirstName, LastName, City from Clients whose LastName starts with L,M, or N and who live in LaPlace. (5 rows)

### Activity 17
Select InvoiceId, Description, Price, Quantity, and ServiceDate from InvoiceLineItem.

Add an additional field that uses Price and Quantity to calculate the line item total.
Display records where the line item total is between 15 and 25 dollars. 
(667 rows)
Activity 18
Does the Client, Estrella Bazely, have a Login? If so, what is her email address?

This requires two queries:

Select a Client record for Estrella Bazely. Does it exist?
If it does, select a Login record that matches its ClientId.
Activity 19
What are the Goals of the Workout with the Name 'This Is Parkour'?

You need three queries!

Select the WorkoutId from Workout where Name equals 'This Is Parkour'. (1 row)
Select GoalId from WorkoutGoal where the WorkoutId matches the WorkoutId from your first query. (3 rows)
Select everything from Goal where the GoalId is one of the GoalIds from your second query. (3 rows)