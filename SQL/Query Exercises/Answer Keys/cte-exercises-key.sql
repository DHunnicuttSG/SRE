USE PersonalTrainer;

-- Activity 1
-- Select longer Workouts through a simple CTE.
WITH WorkoutDurations AS (
    SELECT
        WorkoutId,
        `Name`,
        LevelId,
        MinMinutes,
        MaxMinutes
    FROM Workout
)
SELECT
    WorkoutDurations.`Name` WorkoutName,
    WorkoutDurations.MinMinutes,
    WorkoutDurations.MaxMinutes
FROM WorkoutDurations
WHERE WorkoutDurations.MaxMinutes >= 60
ORDER BY WorkoutDurations.MaxMinutes DESC, WorkoutDurations.`Name`;

--------------------

-- Activity 2
-- Include Clients with no Goals and display a zero count for them.
WITH GoalCounts AS (
    SELECT
        cg.ClientId,
        COUNT(*) GoalCount
    FROM ClientGoal cg
    GROUP BY cg.ClientId
)
SELECT
    c.ClientId,
    c.FirstName,
    c.LastName,
    COALESCE(gc.GoalCount, 0) GoalCount
FROM Client c
LEFT JOIN GoalCounts gc ON c.ClientId = gc.ClientId
ORDER BY c.LastName, c.FirstName;

--------------------

-- Activity 3
-- Clients with more than $1,000 in paid invoice totals.
-- 146 rows
WITH PaidTotals AS (
    SELECT
        i.ClientId,
        SUM(li.Price * li.Quantity) PaidTotal
    FROM Invoice i
    INNER JOIN InvoiceLineItem li ON i.InvoiceId = li.InvoiceId
    WHERE i.InvoiceStatus = 2
    GROUP BY i.ClientId
)
SELECT
    c.ClientId,
    c.FirstName,
    c.LastName,
    pt.PaidTotal
FROM Client c
INNER JOIN PaidTotals pt ON c.ClientId = pt.ClientId
WHERE pt.PaidTotal > 1000.00
ORDER BY c.LastName, c.FirstName;

--------------------

-- Activity 4
-- Show each Goal with its Client and Workout counts.
WITH ClientCounts AS (
    SELECT
        cg.GoalId,
        COUNT(*) ClientCount
    FROM ClientGoal cg
    GROUP BY cg.GoalId
),
WorkoutCounts AS (
    SELECT
        wg.GoalId,
        COUNT(*) WorkoutCount
    FROM WorkoutGoal wg
    GROUP BY wg.GoalId
)
SELECT
    g.GoalId,
    g.`Name` GoalName,
    COALESCE(cc.ClientCount, 0) ClientCount,
    COALESCE(wc.WorkoutCount, 0) WorkoutCount
FROM Goal g
LEFT JOIN ClientCounts cc ON g.GoalId = cc.GoalId
LEFT JOIN WorkoutCounts wc ON g.GoalId = wc.GoalId
ORDER BY g.`Name`;

--------------------

-- Activity 5
-- Workouts whose MaxMinutes is above their Level's average.
WITH WorkoutLevelAverages AS (
    SELECT
        w.WorkoutId,
        w.`Name`,
        w.LevelId,
        w.MaxMinutes,
        AVG(w.MaxMinutes) OVER (
            PARTITION BY w.LevelId
        ) AverageMaxMinutes
    FROM Workout w
)
SELECT
    WorkoutLevelAverages.`Name` WorkoutName,
    WorkoutLevelAverages.LevelId,
    WorkoutLevelAverages.MaxMinutes,
    WorkoutLevelAverages.AverageMaxMinutes
FROM WorkoutLevelAverages
WHERE WorkoutLevelAverages.MaxMinutes > WorkoutLevelAverages.AverageMaxMinutes
ORDER BY WorkoutLevelAverages.LevelId, WorkoutLevelAverages.MaxMinutes DESC;

--------------------

-- Activity 6
-- Recursively display ExerciseCategory hierarchy paths.
WITH RECURSIVE CategoryTree AS (
    SELECT
        ec.ExerciseCategoryId,
        ec.ParentCategoryId,
        ec.`Name`,
        0 Depth,
        CAST(ec.`Name` AS CHAR(1000)) CategoryPath
    FROM ExerciseCategory ec
    WHERE ec.ParentCategoryId IS NULL

    UNION ALL

    SELECT
        child.ExerciseCategoryId,
        child.ParentCategoryId,
        child.`Name`,
        parent.Depth + 1,
        CONCAT(parent.CategoryPath, ' > ', child.`Name`)
    FROM ExerciseCategory child
    INNER JOIN CategoryTree parent
        ON child.ParentCategoryId = parent.ExerciseCategoryId
)
SELECT
    CategoryTree.ExerciseCategoryId,
    CategoryTree.ParentCategoryId,
    CategoryTree.`Name` CategoryName,
    CategoryTree.Depth,
    CategoryTree.CategoryPath
FROM CategoryTree
ORDER BY CategoryTree.CategoryPath;

--------------------

-- Activity 7
-- Return the highest-total invoice or tied invoices per Client.
WITH InvoiceTotals AS (
    SELECT
        i.ClientId,
        i.InvoiceId,
        i.InvoiceDate,
        SUM(li.Price * li.Quantity) InvoiceTotal
    FROM Invoice i
    INNER JOIN InvoiceLineItem li ON i.InvoiceId = li.InvoiceId
    GROUP BY i.ClientId, i.InvoiceId, i.InvoiceDate
),
RankedInvoices AS (
    SELECT
        InvoiceTotals.ClientId,
        InvoiceTotals.InvoiceId,
        InvoiceTotals.InvoiceDate,
        InvoiceTotals.InvoiceTotal,
        RANK() OVER (
            PARTITION BY InvoiceTotals.ClientId
            ORDER BY InvoiceTotals.InvoiceTotal DESC
        ) InvoiceRank
    FROM InvoiceTotals
)
SELECT
    RankedInvoices.ClientId,
    RankedInvoices.InvoiceId,
    RankedInvoices.InvoiceDate,
    RankedInvoices.InvoiceTotal,
    RankedInvoices.InvoiceRank
FROM RankedInvoices
WHERE RankedInvoices.InvoiceRank = 1
ORDER BY RankedInvoices.ClientId, RankedInvoices.InvoiceId;
