Activity 1
Use an aggregate to count the number of Clients.

Expected result size: 1 row


Activity 2
Use an aggregate to count Client.BirthDate.

The number is different than total Clients. Why?
Expected result size: 1 row


Activity 3
Group Clients by City and count them.

Sort by the number of Clients desc.
Include both City and the client count in the results.
Expected result size: 20 rows
Sample Results:

city	client_count
New Orleans	105
Jefferson	30  


Activity 4
Calculate a total per invoice using only the InvoiceLineItem table.
Group by InvoiceId.
You'll need an expression for the line item total: Price * Quantity.
Aggregate per group using SUM().
Expected result size: 1000 rows
Sample Results:

invoiceid	invoice_total
1	283.12500000
2	105.00000000


Activity 5
Modify the previous query:

Only include totals greater than $500.00.
Sort from lowest total to highest.
Expected result size: 234 rows
Sample Results:

invoiceid	invoice_total
368	502.50000000
557	502.50000000


Activity 6
Calculate the average line item total, grouped by InvoiceLineItem.Description.

Expected result size: 3 rows
Sample Results:

description	invoice_average
Individual Instruction	160.502717391304
Group Instruction	25.482495511670


Activity 7
Select ClientId, FirstName, and LastName from Client for clients who have paid over $1000 total.

Paid is Invoice.InvoiceStatus = 2.
Sort by LastName, then FirstName.
Expected result size: 146 rows
Sample Results:

ClientId	FirstName	LastName	Total
bcf40948-b93b-4c1f-b1c7-ee10c05b9faf	Randal	Aberkirdo	1540.99500000
d0a2212e-6332-4541-9e00-116ddf88fe45	Phyllys	Acome	1115.62500000


Activity 8
Count exercises by category.

Group by ExerciseCategory.Name.
Sort by exercise count descending.
Expected result size: 13 rows
Sample Results:

CategoryName	ExerciseCount
Bodyweight	11
Flexibility	9


Activity 9
Select Exercise.Name along with the minimum, maximum, and average ExerciseInstance.Sets.

Sort by Exercise.Name.
Expected result size: 64 rows
Sample Results:

ExerciseName	MinSets	MaxSets	AvgSets
Air squats	1	2	1.2500
Ananda Balasana	1	10	3.5000


Activity 10
Find the minimum and maximum Client.BirthDate per Workout.

Sort by workout name.
Expected result size: 26 rows
Sample Results:

WorkoutName	EarliestBirthDate	LatestBirthDate
3, 2, 1... Yoga!	1928-04-28	1993-02-07
Agility Training	1935-05-11	2004-02-28


Activity 11
Count client goals.

Be careful not to exclude rows for clients without goals.
Expected result size: 500 rows total; 50 rows with no goals
Sample Results:

ClientId	GoalCount
00268ec4-cdb6-4643-8e94-3aa467419af6	0
04971685-17d8-4973-bf35-42e8a2d4810c	0


Activity 12
Select Exercise.Name, Unit.Name, and minimum and maximum ExerciseInstanceUnitValue.Value for all exercises with a configured ExerciseInstanceUnitValue.

Sort by Exercise.Name, then Unit.Name.
Expected result size: 82 rows
Sample Results:

ExerciseName	UnitName	MinValue	MaxValue
Air squats	Repetitions	25	150
Ananda Balasana	Minutes	5	25


Activity 13
Modify the query above to include ExerciseCategory.Name.

Order by ExerciseCategory.Name, then Exercise.Name, then Unit.Name.
Expected result size: 82 rows
Sample Results:

CategoryName	ExerciseName	UnitName	MinValue	MaxValue
Biking	Street ride	Miles	5	40
Biking	Trail ride	Miles	5	40


Activity 14
Select the minimum and maximum age in years for each Level.

To calculate age in years, use the MySQL function DATEDIFF. (Do online research to see how this function works.)
Expected result size: 4 rows
Sample Results:

LevelName	MinAge	MaxAge
Beginner	15.0466	94.2110
Intermediate	14.0329	95.2575


Activity 15
Stretch Goal!

Count logins by email extension (.com, .net, .org, etc...).

Research SQL functions to isolate a very specific part of a string value.
Expected result size: 27 rows (27 unique email extensions)
Sample Results:

EMAIL_EXT	COUNT(EmailAddress)
com	178
jp	20


Activity 16
Stretch Goal! Match client goals to workout goals.

Select Client FirstName and LastName and Workout.Name for all workouts that match at least 2 of a client's goals.
Sort by the client's last name, then first name.
Expected result size: 139 rows
Sample Results:

WorkoutName	ClientName	GoalCount
Mindfulness, Calm, Strength, Affirmation	Randal Aberkirdo	2
The Need For Speed	Stanislas Abthorpe	2