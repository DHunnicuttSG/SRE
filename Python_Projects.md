# Possible suggestions for projects:

The Academy at mthree have some needs for projects and would like to give you a real world opportunity to create something that we would use here at mthree.  

## TimeTracker App
The instructors and Academy personnel track hours spent doing certain tasks.  Currently, the other instructors and myself go through our outlook meetings and tabulate hours and counts of specific tasks, jobs, meetings, etc.  We would like an application to help report those hours and counts.  

A typical report would look like this:


September Hours:

| |	Hours |  Counts |
|-|---|---|
| Interview Prep	| 6	| 7 |
| C423 Facilitate	| 9	| 3 |
| Global Academy	| 0	| 0 |
| Client Calls	| 3	| 3 |
| HE Reviews/TestPlan Review | 1	| 2 |
| Cohort meetings	| 0.5	| 1 |
| 1-1 Student	| 0.5	| 1 |
| Greece C425	| 50	| 10 |
| Curriculum Dev Java/Python	| 24	| 4 |
| Academy Standup	| 1.25	| 4 |
| Academy Curriculum Meeting	| 1	| 1 |
| Review HE Assessments	| 1	| 1 |
| Holiday	| 8	| 2 |
| Totals	| 105.25	| 39 |
 
This app would probably need a database, sqlite perhaps, tables for category, tracked, etc.  Tables would need to have CRUD capabilities.  A report needs to be generated for each month.  This app can run on individual computers.

## SchedulerApp
This application will be used to schedule interview prep sessions.  We need logins for instructors to share available times and for a scheduler to be able to schedule times.  We have a global company so there is a time zone issue.  All times will need to be local for the individuals.  Scheduler needs a way to match times and schedule.  This app probably needs email access. We will need to run this app on AWS.

## Assessment creater
This is a basic app we will use to create assessments.  We would like to have a bank of questions we can store and access.  We would like to have the ability to create differnt assessments with different topics.  The question types should be Multiple Choice and T/F.  We need to run this app on AWS.  DB will need to be mySQL or other RDBMS.