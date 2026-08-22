# Module: AI Fundamentals for Production Support Teams
## Why AI Matters in Operations

Production support teams spend significant time on repetitive activities such as:

- Reviewing incidents
- Writing status updates
- Creating handover notes
- Investigating logs
- Producing reports
- Writing simple scripts
- Updating knowledge articles

AI tools can reduce the manual effort involved in these activities while allowing engineers to focus on analysis and decision-making. However, AI should be treated as an assistant rather than an autonomous operator. All outputs must be reviewed before use.

Discussion Exercise

Ask learners:

How much of your day is spent finding information versus solving problems?

Most support teams estimate:

- 30% Information gathering
- 20% Documentation
- 30% Troubleshooting
- 20% Meetings and communication

AI can primarily help with the first two categories.

### Enterprise Copilot for Production Support
**Scenario: Shift Handover**

Every support organization struggles with handovers.

A typical handover note may contain:

Ticket 12345 still open.
DB team investigating.
Performance issue in APAC.
No update from vendor.
Need review in morning.

### Prompt Example
Act as a Production Support Lead.

Convert these notes into a professional shift handover.

Include:
- Current Impact
- Status
- Teams Engaged
- Next Actions

Do not add assumptions.

Expected Result  
Current Impact:  
Users in the APAC region are experiencing intermittent performance degradation.

Status:  
Investigation remains in progress. Database team is currently reviewing performance metrics.

Teams Engaged:  
Application Support, Database Team, Vendor Support.

Next Actions:  
Await vendor feedback and review database findings during the next support shift.  

Learning Point

Copilot improves:

Consistency
Professional communication
Executive readability
Handover quality

But engineers still validate accuracy.

---

AI-Powered Incident Management
Scenario

A Sev-1 incident bridge call lasted 2 hours.

The support analyst has:

Teams chat transcripts
Notes from engineers
Incident timeline
Prompt
Summarize this incident.

Provide:

1. Business Impact
2. Technical Findings
3. Actions Taken
4. Current Status
5. Next Steps

Limit to 1 page.

Benefits

Instead of spending 45 minutes writing a summary:

AI produces first draft in seconds
Analyst focuses on accuracy
Stakeholders receive faster communication

---

AI-Assisted Root Cause Analysis
Scenario

Application log contains:

ERROR: Database timeout
ERROR: Connection pool exhausted
ERROR: Retry limit reached

Prompt
Act as a senior application support engineer.

Explain the likely causes of these log messages.

Include:
- Potential dependencies
- Troubleshooting steps
- Escalation criteria

Do not assume root cause.

Discussion

Ask students:

Which suggestions would you trust?
What should be validated?
What evidence would you collect?

This reinforces critical thinking.

Module: Prompt Engineering for Support Engineers
Poor Prompt
Explain this log.


Produces generic results.

Better Prompt
Act as a production support engineer.

Review the following application log.

Identify:

- Errors
- Warnings
- Likely causes
- Troubleshooting steps

Do not invent missing information.

---

### Example Great Prompt - discussion
Act as a Level 3 Support Engineer supporting a banking application.

Analyze the following log entries.

Provide:

- Executive Summary
- Technical Findings
- Severity Assessment
- Recommended Actions

Highlight any assumptions separately.

Teaching Point

Good prompts contain:

Role
Context
Task
Desired output format
Constraints

---
## Scenario: Daily File Validation

Support teams often verify critical files.

Example:

orders.csv
payments.csv
customers.csv

must arrive each morning.

Prompt
Create a Python script that:

- Checks whether all files exist
- Records timestamp
- Creates a report
- Displays missing files

Follow-up Prompt
Improve this script.

Add:
- Logging
- Error handling
- Email notifications

Learning Outcome

Students learn:

AI generates drafts
Engineers improve quality
Human review remains mandatory

---
## AI-Assisted Code Review
Scenario

AI generated:

file_path = "transactions.csv"

if os.path.exists(file_path):
    print("File exists")

Classroom Activity

Ask:

What is missing?

Expected answers:

Error handling
Logging
Configuration file support
Notification capability
Multiple file support
Exit codes

This helps learners understand AI limitations.

---
## AI-Generated Unit Testing Example

Original function:

def calculate_total(a, b):
    return a + b


Prompt:

Generate pytest test cases.


AI generates:

def test_addition():
    assert calculate_total(2,3) == 5

Discussion

Would this test:

Negative values?
Null values?
Large values?

Students learn validation practices.

---
## AI for Knowledge Management
### Real Support Challenge

Every incident gets solved.

But many organizations fail to capture knowledge.

Prompt
Convert this resolution note into a knowledge article.

Include:

- Symptoms
- Root Cause
- Resolution
- Validation Steps
- Escalation Path

Outcome

Engineers can convert ad-hoc notes into reusable documentation in minutes.

---
## RPA Opportunity Identification Workshop
Activity

Present this process:

1. Open Portal
2. Download Report
3. Save File
4. Update Excel Tracker
5. Email Team


Ask students:

Question 1
Is it repetitive?

Question 2
Does it require judgment?

Question 3
How often is it performed?

Question 4
What happens if the application screen changes?

Question 5
Could an API solve it better?

These questions teach automation assessment fundamentals.

---
## AI + Automation Decision Framework

Give students this matrix.

| Task |	Best Tool|
|-----|-----|
| Incident Summary      |Copilot|
| Executive Communication|Copilot|
| Knowledge Article	    |Copilot|
| File Check Script	    |GitLab Duo|
| Log Parsing Script	|GitLab Duo|
| Unit Test Creation	|GitLab Duo|
| Download Web Report	|UiPath|
| Update Legacy System	|UiPath|
| Root Cause Analysis	|Human + AI|
| Production Approval	|Human|

Based on the governance and review principles throughout the source material.

## Capstone Exercise (60-90 Minutes)
### Scenario

A payment system has experienced failures overnight.

Required activities:

Check incoming files
Review logs
Download operations report
Update ticket
Send stakeholder communication
Create KB article

### Student Task

For each activity determine:

Human only
Copilot
GitLab Duo
UiPath/RPA
Human + AI
Expected Outcome

Students leave understanding:

What AI does well
What automation does well
What still requires human expertise
How governance and security influence tool selection
