# Module 4: AI-Assisted Development with GitLab Duo

**Duration:** 2 Hours

---

# Module Overview

Modern support and development teams are expected to deliver solutions faster while maintaining quality, security, and reliability. AI-assisted development tools such as GitLab Duo can help engineers create code, generate tests, improve documentation, refactor existing solutions, and support CI/CD processes.

GitLab Duo acts as an AI-powered development assistant that helps engineers reduce repetitive work, accelerate learning, and increase productivity. However, AI-generated code must always be reviewed, tested, and approved before use in production environments. 【1-129840】

---

# Learning Objectives

By the end of this module, learners will be able to:

- Explain the purpose of GitLab Duo
- Use AI to generate code from requirements
- Create unit tests using AI assistance
- Refactor existing code using AI recommendations
- Generate technical documentation
- Use AI to support CI/CD pipeline development
- Apply governance and review practices to AI-generated code
- Recognize the limitations of AI-assisted development

---

# Why AI-Assisted Development Matters

Production Support and DevOps teams spend significant time performing repetitive development activities:

- Creating utility scripts
- Troubleshooting log files
- Writing tests
- Documenting solutions
- Supporting CI/CD pipelines
- Maintaining legacy scripts

AI can accelerate these activities while allowing engineers to focus on analysis, design, testing, and operational decision-making.

---

# Real World Analogy

Imagine having a junior developer sitting beside you.

This developer:

✅ Writes code quickly

✅ Suggests solutions

✅ Creates first drafts

✅ Produces documentation

✅ Explains existing code

However:

❌ They require supervision

❌ They make mistakes

❌ They don't fully understand your environment

❌ They cannot approve their own work

GitLab Duo should be viewed in the same way.

---

# Topic 1: Code Generation

## What Is AI Code Generation?

Code generation is the process of using AI to create source code from natural language descriptions.

Instead of writing every line manually, developers describe what they need and GitLab Duo generates a starting solution.

---

## Analogy

Think of code generation like using GPS navigation.

GPS provides a recommended route.

You still decide:

- Whether the route is appropriate
- Whether road closures exist
- Whether the directions make sense

Similarly, GitLab Duo provides a recommended coding solution.

The engineer remains responsible for validation.

---

## Production Support Example

### Scenario

A support analyst needs to verify that required files arrive every morning.

### Prompt

```text
Create a Python script that:

- Checks for orders.csv
- Checks for payments.csv
- Checks for customers.csv
- Creates a report listing missing files
- Records execution time
```

---

## Example Output

```python
import os
from datetime import datetime

files = [
    "orders.csv",
    "payments.csv",
    "customers.csv"
]

timestamp = datetime.now()

for file in files:
    if os.path.exists(file):
        print(f"{file} exists")
    else:
        print(f"{file} missing")
```

---

## Discussion Questions

- Is error handling included?
- Should results be logged?
- What happens if permissions are missing?
- Is notification required?

These questions demonstrate why human review is essential. 【1-129840】

---

## Best Practices for Code Generation

Always:

- Define requirements clearly
- Provide sufficient context
- Review generated code
- Test before deployment
- Follow coding standards
- Use version control

Never:

- Copy directly into production
- Assume generated code is correct
- Skip peer review

---

# Topic 2: Unit Test Generation

## What Are Unit Tests?

Unit tests verify that individual functions or components behave as expected.

They help prevent defects from reaching production.

---

## Analogy

Think of unit tests like inspecting parts on an assembly line.

Instead of inspecting the entire car, each component is checked individually before assembly.

Unit tests perform the same function for software.

---

## Example Function

```python
def calculate_total(amount, tax):
    return amount + tax
```

---

## Prompt

```text
Generate pytest unit tests for this function.
```

---

## Example Output

```python
def test_basic_calculation():
    assert calculate_total(100, 10) == 110

def test_zero_tax():
    assert calculate_total(100, 0) == 100

def test_negative_values():
    assert calculate_total(-100, 10) == -90
```

---

## Human Review Discussion

Ask learners:

What tests are still missing?

Possible answers:

- Null values
- Unexpected data types
- Large numbers
- Error handling
- Edge cases

---

## Benefits of AI Test Generation

AI can help:

- Create test scaffolding
- Suggest edge cases
- Improve code coverage
- Accelerate testing activities

However, engineers must verify that generated tests truly validate business requirements.

---

# Topic 3: Refactoring

## What Is Refactoring?

Refactoring means improving code without changing its functionality.

The goal is to make code:

- Easier to read
- Easier to maintain
- Easier to support
- More efficient

---

## Analogy

Imagine reorganizing a server room.

The servers continue functioning exactly the same way, but everything becomes:

- Cleaner
- Better labeled
- Easier to troubleshoot

Refactoring applies the same principle to software.

---

## Example

### Original Code

```python
x = 0

with open("app.log") as file:
    for line in file:
        if "ERROR" in line:
            x += 1

print(x)
```

---

## Prompt

```text
Refactor this code to improve readability and maintainability.

Follow Python best practices.
```

---

## Example Output

```python
error_count = 0

with open("app.log", "r") as log_file:
    for line in log_file:
        if "ERROR" in line:
            error_count += 1

print(error_count)
```

---

## Benefits of Refactoring

Improves:

- Readability
- Maintainability
- Team collaboration
- Knowledge transfer

---

## Support Team Example

Many support teams inherit scripts written years ago.

GitLab Duo can help:

- Explain old code
- Improve formatting
- Suggest improvements
- Reduce technical debt

---

# Topic 4: Documentation Generation

## Why Documentation Matters

Many support incidents occur because knowledge exists only in someone's memory.

Good documentation enables:

- Faster onboarding
- Consistent support
- Reduced resolution time
- Better operational resilience

---

## Common Documentation Types

- Knowledge Articles
- Runbooks
- SOPs
- Troubleshooting Guides
- README Files
- Deployment Instructions

---

## Analogy

Documentation is like a map.

Without a map:

You may eventually reach your destination.

With a map:

You arrive faster and with fewer mistakes.

---

## Example Scenario

An engineer created a log analysis script.

New team members need instructions.

---

## Prompt

```text
Create a README document for this Python script.

Include:

- Purpose
- Prerequisites
- Installation
- Execution Steps
- Troubleshooting
```

---

## Example Output

```text
Purpose:
Analyzes application logs and identifies errors.

Prerequisites:
Python 3.11 or higher.

Execution:
python log_analyzer.py

Output:
Creates error_report.txt
```

---

## Knowledge Article Example

### Prompt

```text
Convert these incident resolution notes into a knowledge article.

Include:

- Symptoms
- Root Cause
- Resolution
- Validation Steps
```

AI can produce a usable first draft that support teams refine and publish.

---

# Topic 5: CI/CD Support

## What Is CI/CD?

CI/CD stands for:

- Continuous Integration
- Continuous Delivery (or Deployment)

CI/CD automates the process of:

- Building code
- Testing code
- Validating quality
- Deploying software

GitLab supports CI/CD through pipelines. 【1-129840】

---

## Analogy

Imagine airport security.

Every passenger must pass through a series of checkpoints before boarding.

CI/CD pipelines perform similar checkpoints for software.

Code must pass:

- Validation
- Testing
- Security checks
- Approval processes

before reaching production.

---

## Typical GitLab Workflow

```text
Developer Creates Branch
            ↓
Write or Generate Code
            ↓
Run Local Tests
            ↓
Commit Changes
            ↓
Push to GitLab
            ↓
Create Merge Request
            ↓
Run CI/CD Pipeline
            ↓
Peer Review
            ↓
Approval
            ↓
Merge
```

---

## Example Prompt

```text
Generate a GitLab CI pipeline for a Python application.

Requirements:

- Run syntax validation
- Execute unit tests
- Prevent merges if tests fail
```

---

## Example Output

```yaml
stages:
  - test

python_tests:
  stage: test
  image: python:3.11

  script:
    - python -m py_compile app.py
```

---

## Human Validation Required

Before using generated pipeline configurations:

Verify:

- Security requirements
- Branch protection rules
- Testing standards
- Deployment approvals
- Environment variables

---

# Governance and Security

## Why Governance Matters

AI-generated code can contain:

- Errors
- Security issues
- Bad assumptions
- Inefficient logic

Review processes help reduce risk. 【1-129840】

---

## Secure Development Principles

Always:

✅ Review AI-generated code

✅ Use version control

✅ Run automated tests

✅ Conduct peer review

✅ Scan for vulnerabilities

✅ Follow coding standards

✅ Document changes

---

## Avoid

❌ Hardcoded passwords

❌ Access tokens in code

❌ Unreviewed deployments

❌ Direct production releases

❌ Using unapproved AI tools

---

# Practical Exercise 1: Generate a Support Script

## Scenario

Every morning a support analyst validates incoming files.

### Task

Use GitLab Duo to generate a script that:

- Checks three files
- Records a timestamp
- Creates a report

### Discussion

Review the generated solution and identify:

- Missing validations
- Error handling improvements
- Logging requirements

---

# Practical Exercise 2: Generate Unit Tests

## Scenario

An existing script needs validation.

### Task

Use AI to generate unit tests.

### Discussion

Identify:

- Missing test cases
- Edge cases
- Business rules not covered

---

# Practical Exercise 3: Refactor Existing Code

## Scenario

A support team inherited a legacy script.

### Task

Use AI to:

- Explain the script
- Improve readability
- Recommend enhancements

### Discussion

Should every recommendation be accepted?

Why or why not?

---

# Knowledge Check

### Question 1

How does GitLab Duo assist developers?

**Answer:** It can generate code, create tests, explain code, assist with documentation, and support CI/CD workflows.

---

### Question 2

Should AI-generated code be deployed directly to production?

**Answer:** No. It must be reviewed, tested, and approved first.

---

### Question 3

What is the purpose of unit testing?

**Answer:** To verify that software components behave as expected.

---

### Question 4

What is refactoring?

**Answer:** Improving code quality without changing its functionality.

---

### Question 5

How can AI help with documentation?

**Answer:** It can generate README files, knowledge articles, runbooks, and troubleshooting guides.

---

### Question 6

Why are CI/CD pipelines important?

**Answer:** They automate validation and testing processes that improve software quality and reduce risk.

---

# Module Summary

GitLab Duo can significantly increase productivity for Production Support Engineers, DevOps teams, Application Support Analysts, and Developers. It helps accelerate code creation, testing, documentation, and CI/CD development. However, AI-generated content should always be reviewed, tested, and validated through established engineering practices. The most successful teams use AI not as a replacement for expertise, but as a force multiplier that allows engineers to focus on higher-value work.