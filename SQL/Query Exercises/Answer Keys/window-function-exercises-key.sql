USE PersonalTrainer;

-- Activity 1
-- Number Workouts within each Level by MaxMinutes descending.
SELECT
    w.`Name` WorkoutName,
    w.LevelId,
    w.MaxMinutes,
    ROW_NUMBER() OVER (
        PARTITION BY w.LevelId
        ORDER BY w.MaxMinutes DESC, w.`Name`
    ) LevelRowNumber
FROM Workout w
ORDER BY w.LevelId, LevelRowNumber;

--------------------

-- Activity 2
-- Rank Workouts within each Level by MaxMinutes descending.
SELECT
    w.`Name` WorkoutName,
    w.LevelId,
    w.MaxMinutes,
    RANK() OVER (
        PARTITION BY w.LevelId
        ORDER BY w.MaxMinutes DESC
    ) LevelRank
FROM Workout w
ORDER BY w.LevelId, LevelRank, w.`Name`;

--------------------

-- Activity 3
-- Return up to three Clients per City.
SELECT
    ranked.City,
    ranked.FirstName,
    ranked.LastName,
    ranked.CityPosition
FROM (
    SELECT
        c.City,
        c.FirstName,
        c.LastName,
        ROW_NUMBER() OVER (
            PARTITION BY c.City
            ORDER BY c.LastName, c.FirstName, c.ClientId
        ) CityPosition
    FROM Client c
) ranked
WHERE ranked.CityPosition <= 3
ORDER BY ranked.City, ranked.CityPosition;

--------------------

-- Activity 4
-- Cumulative number of invoices for each Client.
SELECT
    i.ClientId,
    i.InvoiceId,
    i.InvoiceDate,
    COUNT(*) OVER (
        PARTITION BY i.ClientId
        ORDER BY i.InvoiceDate, i.InvoiceId
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) RunningInvoiceCount
FROM Invoice i
ORDER BY i.ClientId, i.InvoiceDate, i.InvoiceId;

--------------------

-- Activity 5
-- Running total of paid invoice amounts for each Client.
SELECT
    paid.ClientId,
    paid.InvoiceId,
    paid.InvoiceDate,
    paid.InvoiceTotal,
    SUM(paid.InvoiceTotal) OVER (
        PARTITION BY paid.ClientId
        ORDER BY paid.InvoiceDate, paid.InvoiceId
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) RunningPaidTotal
FROM (
    SELECT
        i.ClientId,
        i.InvoiceId,
        i.InvoiceDate,
        SUM(li.Price * li.Quantity) InvoiceTotal
    FROM Invoice i
    INNER JOIN InvoiceLineItem li ON i.InvoiceId = li.InvoiceId
    WHERE i.InvoiceStatus = 2
    GROUP BY i.ClientId, i.InvoiceId, i.InvoiceDate
) paid
ORDER BY paid.ClientId, paid.InvoiceDate, paid.InvoiceId;

--------------------

-- Activity 6
-- Compare each Workout's MaxMinutes to the maximum in its Level.
SELECT
    w.`Name` WorkoutName,
    w.LevelId,
    w.MaxMinutes,
    MAX(w.MaxMinutes) OVER (
        PARTITION BY w.LevelId
    ) LevelMaxMinutes
FROM Workout w
ORDER BY w.LevelId, w.MaxMinutes DESC, w.`Name`;

--------------------

-- Activity 7
-- Find the previous InvoiceDate per Client.
SELECT
    i.ClientId,
    i.InvoiceId,
    i.InvoiceDate,
    LAG(i.InvoiceDate) OVER (
        PARTITION BY i.ClientId
        ORDER BY i.InvoiceDate, i.InvoiceId
    ) PreviousInvoiceDate,
    DATEDIFF(
        i.InvoiceDate,
        LAG(i.InvoiceDate) OVER (
            PARTITION BY i.ClientId
            ORDER BY i.InvoiceDate, i.InvoiceId
        )
    ) DaysSincePreviousInvoice
FROM Invoice i
ORDER BY i.ClientId, i.InvoiceDate, i.InvoiceId;

--------------------

-- Activity 8
-- Rank Goals by the number of Clients who selected each Goal.
SELECT
    goal_counts.GoalId,
    goal_counts.GoalName,
    goal_counts.ClientCount,
    DENSE_RANK() OVER (
        ORDER BY goal_counts.ClientCount DESC
    ) PopularityRank
FROM (
    SELECT
        g.GoalId,
        g.`Name` GoalName,
        COUNT(cg.ClientId) ClientCount
    FROM Goal g
    LEFT JOIN ClientGoal cg ON g.GoalId = cg.GoalId
    GROUP BY g.GoalId, g.`Name`
) goal_counts
ORDER BY PopularityRank, goal_counts.GoalName;
