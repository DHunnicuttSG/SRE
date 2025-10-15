use PersonalTrainer;

-- Activity 1
-- Use an aggregate to count the number of Clients.
-- 500 rows

SELECT COUNT(*)
FROM Client;

--------------------

-- Activity 2
-- Use an aggregate to count Client.BirthDate.
-- The number is different than total Clients. Why?
-- 463 rows

SELECT COUNT(BirthDate)
FROM Client;

--------------------

-- Activity 3
-- Group Clients by City and count them.
-- Order by the number of Clients desc.
-- 20 rows

SELECT
	City,
    COUNT(*)
FROM Client
GROUP BY City
ORDER BY COUNT(*) DESC;

--------------------

-- Activity 4
-- Calculate a total per invoice using only the InvoiceLineItem table.
-- Group by InvoiceId.
-- You'll need an expression for the line item total: Price * Quantity.
-- Aggregate per group using SUM().
-- 1000 rows

SELECT
	InvoiceId,
    SUM(Price * Quantity) InvoiceTotal
FROM InvoiceLineItem
GROUP BY InvoiceId;

--------------------

-- Activity 5
-- Calculate a total per invoice using only the InvoiceLineItem table.
-- (See above.)
-- Only include totals greater than $500.00.
-- Order from lowest total to highest.
-- 234 rows

SELECT
	InvoiceId,
    SUM(Price * Quantity) InvoiceTotal
FROM InvoiceLineItem
GROUP BY InvoiceId
HAVING SUM(Price * Quantity) > 500.0
ORDER BY SUM(Price * Quantity);

--------------------

-- Activity 6
-- Calculate the average line item total
-- grouped by InvoiceLineItem.Description.
-- 3 rows

SELECT
	Description,
    AVG(Price * Quantity) AvgTotal
FROM InvoiceLineItem
GROUP BY Description;

--------------------

-- Activity 7
-- Select ClientId, FirstName, and LastName from Client
-- for clients who have *paid* over $1000 total.
-- Paid is Invoice.InvoiceStatus = 2.
-- Order by LastName, then FirstName.
-- 146 rows

SELECT
	c.ClientId,
    c.FirstName,
    c.LastName,
    SUM(li.Price * li.Quantity) Total
FROM Client c
INNER JOIN Invoice i ON c.ClientId = i.ClientId
INNER JOIN InvoiceLineItem li ON i.InvoiceId = li.InvoiceId
WHERE i.InvoiceStatus = 2
GROUP BY c.ClientId, c.FirstName, c.LastName
HAVING SUM(li.Price * li.Quantity) > 1000.00
ORDER BY c.LastName, c.FirstName;

--------------------

-- Activity 8
-- Count exercises by category.
-- Group by ExerciseCategory.Name.
-- Order by exercise count descending.
-- 13 rows

SELECT
	c.`Name` CategoryName,
    COUNT(e.ExerciseId) ExerciseCount
FROM ExerciseCategory c
INNER JOIN Exercise e ON c.ExerciseCategoryId = e.ExerciseCategoryId
GROUP BY c.ExerciseCategoryId, c.`Name`
ORDER BY COUNT(e.ExerciseId) DESC;

--------------------

-- Activity 9
-- Select Exercise.Name along with the minimum, maximum,
-- and average ExerciseInstance.Sets.
-- Order by Exercise.Name.
-- 64 rows

SELECT
	e.`Name` ExerciseName,
    MIN(i.Sets) MinSets,
    MAX(i.Sets) MaxSets,
    AVG(i.Sets) AvgSets
FROM Exercise e
INNER JOIN ExerciseInstance i ON e.ExerciseId = i.ExerciseId
GROUP BY e.ExerciseId, e.`Name`
ORDER BY e.`Name`;

--------------------

-- Activity 10
-- Find the minimum and maximum Client.BirthDate
-- per Workout.
-- 26 rows
-- Sample: 
-- WorkoutName, EarliestBirthDate, LatestBirthDate
-- '3, 2, 1... Yoga!', '1928-04-28', '1993-02-07'

SELECT
	w.`Name` WorkoutName,
	MIN(c.BirthDate) EarliestBirthDate,
    MAX(c.BirthDate) LatestBirthDate
FROM Workout w
INNER JOIN ClientWorkout cw ON w.WorkoutId = cw.WorkoutId
INNER JOIN Client c ON cw.ClientId = c.ClientId
GROUP BY w.WorkoutId, w.`Name`
ORDER BY w.`Name`;

--------------------

-- Activity 11
-- Count client goals.
-- Be careful not to exclude rows for clients without goals.
-- 500 rows total
-- 50 rows with no goals

SELECT
	c.ClientId,
    COUNT(cg.GoalId) GoalCount
FROM Client c
LEFT OUTER JOIN ClientGoal cg ON c.ClientId = cg.ClientId
GROUP BY c.ClientId
ORDER BY COUNT(cg.GoalId) ASC;

--------------------

-- Activity 12
-- Select Exercise.Name, Unit.Name, 
-- and minimum and maximum ExerciseInstanceUnitValue.Value
-- for all exercises with a configured ExerciseInstanceUnitValue.
-- Order by Exercise.Name, then Unit.Name.
-- 82 rows

SELECT
	e.`Name` ExerciseName,
    u.`Name` UnitName,
    MIN(uv.Value) MinValue,
    MAX(uv.Value) 'MaxValue'
FROM Exercise e
INNER JOIN ExerciseInstance ei 
	ON e.ExerciseId = ei.ExerciseId
INNER JOIN ExerciseInstanceUnitValue uv 
	ON ei.ExerciseInstanceId = uv.ExerciseInstanceId
INNER JOIN Unit u ON uv.UnitId = u.UnitId
GROUP BY e.ExerciseId, e.`Name`, u.UnitId, u.`Name`
ORDER BY e.`Name`, u.`Name`;

--------------------

-- Activity 13
-- Modify the query above to include ExerciseCategory.Name.
-- Order by ExerciseCategory.Name, then Exercise.Name, then Unit.Name.
-- 82 rows

SELECT
	c.`Name` CategoryName,
	e.`Name` ExerciseName,
    u.`Name` UnitName,
    MIN(uv.Value) MinValue,
    MAX(uv.Value) 'MaxValue'
FROM Exercise e
INNER JOIN ExerciseInstance ei 
	ON e.ExerciseId = ei.ExerciseId
INNER JOIN ExerciseInstanceUnitValue uv 
	ON ei.ExerciseInstanceId = uv.ExerciseInstanceId
INNER JOIN Unit u 
	ON uv.UnitId = u.UnitId
INNER JOIN ExerciseCategory c 
	ON e.ExerciseCategoryId = c.ExerciseCategoryId
GROUP BY e.ExerciseId, e.`Name`, u.UnitId, u.`Name`, c.`Name`
ORDER BY c.`Name`, e.`Name`, u.`Name`;

--------------------

-- Activity 14
-- Select the minimum and maximum age in years for
-- each Level.
-- To calculate age in years, use the MySQL function DATEDIFF.
-- 4 rows

SELECT
	l.`Name` LevelName,
	MIN(DATEDIFF(CURDATE(), c.BirthDate) / 365) MinAge,
    MAX(DATEDIFF(CURDATE(), c.BirthDate) / 365) MaxAge
FROM Level l
INNER JOIN Workout w ON l.LevelId = w.LevelId
INNER JOIN ClientWorkout cw ON w.WorkoutId = cw.WorkoutId
INNER JOIN Client c ON cw.ClientId = c.ClientId
GROUP BY l.LevelId, l.`Name`;

--------------------

-- Activity 15
-- Stretch Goal!
-- Count logins by email extension (.com, .net, .org, etc...).
-- Research SQL functions to isolate a very specific part of a string value.
-- 27 rows (27 unique email extensions)

SELECT
	SUBSTRING_INDEX(EmailAddress, '.', -1),
    COUNT(EmailAddress)
FROM Login
GROUP BY SUBSTRING_INDEX(EmailAddress, '.', -1)
ORDER BY COUNT(EmailAddress) DESC;

--------------------

-- Activity 16
-- Stretch Goal!
-- Match client goals to workout goals.
-- Select Client FirstName and LastName and Workout.Name for
-- all workouts that match at least 2 of a client's goals.
-- Order by the client's last name, then first name.
-- 139 rows

SELECT
	w.`Name` WorkoutName,
    CONCAT(c.FirstName, ' ', c.LastName) ClientName,
    COUNT(cg.GoalId)
FROM Client c
INNER JOIN ClientGoal cg ON c.ClientId = cg.ClientId
INNER JOIN WorkoutGoal wg ON cg.GoalId = wg.GoalId
INNER JOIN Workout w ON wg.WorkoutId = w.WorkoutId
GROUP BY w.WorkoutId, w.`Name`, c.ClientId, c.FirstName, c.LastName
HAVING COUNT(cg.GoalId) > 1
ORDER BY c.LastName, c.FirstName;