USE PersonalTrainer;

-- Activity 1
-- Workouts whose MaxMinutes is above the overall average.
SELECT
    w.`Name` WorkoutName,
    w.MaxMinutes
FROM Workout w
WHERE w.MaxMinutes > (
    SELECT AVG(w2.MaxMinutes)
    FROM Workout w2
)
ORDER BY w.MaxMinutes DESC, w.`Name`;

--------------------

-- Activity 2
-- Workouts associated with the Core Strength goal.
SELECT
    w.WorkoutId,
    w.`Name` WorkoutName
FROM Workout w
WHERE w.WorkoutId IN (
    SELECT wg.WorkoutId
    FROM WorkoutGoal wg
    INNER JOIN Goal g ON wg.GoalId = g.GoalId
    WHERE g.`Name` = 'Core Strength'
)
ORDER BY w.`Name`;

--------------------

-- Activity 3
-- Clients who have at least one goal.
SELECT
    c.ClientId,
    c.FirstName,
    c.LastName
FROM Client c
WHERE EXISTS (
    SELECT 1
    FROM ClientGoal cg
    WHERE cg.ClientId = c.ClientId
)
ORDER BY c.LastName, c.FirstName;

--------------------

-- Activity 4
-- Clients who are not signed up for a Workout.
-- 50 rows
SELECT
    c.ClientId,
    c.FirstName,
    c.LastName
FROM Client c
WHERE NOT EXISTS (
    SELECT 1
    FROM ClientWorkout cw
    WHERE cw.ClientId = c.ClientId
)
ORDER BY c.LastName, c.FirstName;

--------------------

-- Activity 5
-- Each Client's earliest Invoice or Invoices.
SELECT
    i.InvoiceId,
    i.ClientId,
    i.InvoiceDate
FROM Invoice i
WHERE i.InvoiceDate = (
    SELECT MIN(i2.InvoiceDate)
    FROM Invoice i2
    WHERE i2.ClientId = i.ClientId
)
ORDER BY i.ClientId, i.InvoiceId;

--------------------

-- Activity 6
-- ExerciseInstances with more Sets than the average for that Exercise.
SELECT
    e.`Name` ExerciseName,
    ei.ExerciseInstanceId,
    ei.Sets
FROM ExerciseInstance ei
INNER JOIN Exercise e ON ei.ExerciseId = e.ExerciseId
WHERE ei.Sets > (
    SELECT AVG(ei2.Sets)
    FROM ExerciseInstance ei2
    WHERE ei2.ExerciseId = ei.ExerciseId
)
ORDER BY e.`Name`, ei.ExerciseInstanceId;

--------------------

-- Activity 7
-- Invoices whose total is greater than the average invoice total.
SELECT
    totals.InvoiceId,
    totals.InvoiceTotal
FROM (
    SELECT
        li.InvoiceId,
        SUM(li.Price * li.Quantity) InvoiceTotal
    FROM InvoiceLineItem li
    GROUP BY li.InvoiceId
) totals
WHERE totals.InvoiceTotal > (
    SELECT AVG(invoice_totals.InvoiceTotal)
    FROM (
        SELECT SUM(li2.Price * li2.Quantity) InvoiceTotal
        FROM InvoiceLineItem li2
        GROUP BY li2.InvoiceId
    ) invoice_totals
)
ORDER BY totals.InvoiceTotal, totals.InvoiceId;

--------------------

-- Activity 8
-- Clients with more than $1,000 in paid invoices.
-- 146 rows
SELECT
    c.ClientId,
    c.FirstName,
    c.LastName
FROM Client c
WHERE c.ClientId IN (
    SELECT i.ClientId
    FROM Invoice i
    INNER JOIN InvoiceLineItem li ON i.InvoiceId = li.InvoiceId
    WHERE i.InvoiceStatus = 2
    GROUP BY i.ClientId
    HAVING SUM(li.Price * li.Quantity) > 1000.00
)
ORDER BY c.LastName, c.FirstName;
