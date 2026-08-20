# Production Support, SRE, and DevOps Glossary

A practical glossary of terms commonly used in **Production Support**, **Site Reliability Engineering (SRE)**, and **DevOps** roles.

---

# A

## Alert
A notification triggered when a monitored system exceeds a predefined threshold or condition.

**Example:** CPU utilization exceeds 90% for 10 minutes.

## Availability
The percentage of time a system is operational and accessible to users.

**Formula:**
```
Availability = (Uptime / Total Time) × 100
```

## Application Performance Monitoring (APM)
Tools used to monitor application health, performance, and user experience.

**Examples:** Dynatrace, AppDynamics, New Relic.

---

# B

## Backup
A copy of data maintained for recovery in case of failure, corruption, or accidental deletion.

## Blameless Postmortem
A review conducted after an outage that focuses on process and system improvements rather than assigning blame.

## Blue-Green Deployment
A deployment strategy where two identical environments exist:

- **Blue** = Current production environment
- **Green** = New release environment

Traffic is switched to the Green environment after validation.

---

# C

## Capacity Planning
The process of ensuring infrastructure can meet current and future demand.

## Change Management
A controlled process for introducing modifications into production environments.

## CI/CD
**Continuous Integration / Continuous Delivery (Deployment)**

Practices that automate software building, testing, and deployment.

## Configuration Drift
When environments that should be identical gradually become different due to unmanaged changes.

## Container
A lightweight package that contains an application and all its dependencies.

**Example:** Docker containers.

## Canary Deployment
A deployment strategy where a small percentage of users receive the new version before it is released to everyone.

---

# D

## Deployment Pipeline
An automated sequence of steps used to build, test, and deploy software.

## Disaster Recovery (DR)
Processes and procedures used to recover systems after major failures or outages.

## Downtime
The period when a service is unavailable.

---

# E

## Escalation
The process of involving higher-level support or engineering teams when an issue cannot be resolved at the current level.

## Error Budget
In SRE, the amount of unreliability a service is allowed while still meeting its reliability targets.

**Formula:**
```
Error Budget = 100% - SLO
```

## Event
Any observable occurrence within a system.

**Examples:**
- Server restart
- Deployment completion
- Login failure

---

# F

## Failover
Automatic transfer of operations to a backup system when the primary system fails.

## Fault Tolerance
The ability of a system to continue operating despite component failures.

## Feature Flag
A mechanism for enabling or disabling functionality without deploying new code.

---

# H

## High Availability (HA)
Architecture designed to minimize downtime and maximize system uptime.

## Hotfix
An urgent production change implemented to resolve a critical issue.

## Health Check
An automated test used to determine whether a system is functioning properly.

---

# I

## Incident
An unplanned interruption or degradation of service.

## Incident Commander
The person responsible for coordinating response efforts during a major incident.

## Infrastructure as Code (IaC)
Managing infrastructure through code instead of manual configuration.

**Examples:**
- Terraform
- CloudFormation
- ARM Templates

---

# K

## Kubernetes (K8s)
An open-source container orchestration platform used to deploy and manage containers at scale.

## Known Error
A documented issue with an identified root cause and workaround.

---

# L

## Load Balancer
A device or service that distributes incoming traffic across multiple servers.

## Log Aggregation
Collecting logs from multiple systems into a centralized platform.

**Examples:**
- Splunk
- ELK Stack (Elasticsearch, Logstash, Kibana)

## Latency
The time required for a request to be processed and receive a response.

---

# M

## Mean Time to Detect (MTTD)
The average time required to identify an issue.

## Mean Time to Acknowledge (MTTA)
The average time between alert generation and incident acknowledgement.

## Mean Time to Resolution (MTTR)
The average time required to restore service after an incident.

## Monitoring
Continuous observation of system performance and health.

---

# O

## On-Call
A support model where engineers are available to respond to incidents outside normal business hours.

## Observability
The ability to understand system behavior through logs, metrics, and traces.

## Outage
A period during which a service is unavailable.

---

# P

## Playbook
A documented set of instructions for handling operational situations.

## Postmortem
A review conducted after an incident to identify causes and improvements.

## Production Environment
The live environment serving real users.

## Patch Management
The process of applying updates and fixes to systems.

---

# R

## RCA (Root Cause Analysis)
A structured investigation of the underlying cause of an incident.

## Recovery Point Objective (RPO)
The maximum acceptable amount of data loss.

**Example:** RPO = 15 minutes.

## Recovery Time Objective (RTO)
The target time required to restore service after a disruption.

**Example:** RTO = 1 hour.

## Reliability
The ability of a system to perform consistently over time.

## Rollback
Reverting a deployment to a previous stable version.

## Runbook
Step-by-step operational instructions used by support teams during incidents.

---

# S

## Service Level Agreement (SLA)
A contractual commitment regarding service performance.

**Example:** 99.9% uptime guarantee.

## Service Level Indicator (SLI)
A measurable indicator of service performance.

**Examples:**
- Request latency
- Error rate
- Availability

## Service Level Objective (SLO)
A target value for an SLI.

**Example:** 99.95% availability.

## Synthetic Monitoring
Automated testing that simulates user activity to verify service health.

## Severity (Sev)
A classification of incident impact.

**Typical Scale:**
- **Sev 1** = Critical outage
- **Sev 2** = Major degradation
- **Sev 3** = Minor issue
- **Sev 4** = Low impact

---

# T

## Telemetry
Operational data collected from systems, including metrics, logs, and traces.

## Tracing
Tracking a request as it moves through distributed systems.

## Throughput
The volume of transactions or requests processed during a specific period.

---

# U

## Uptime
The amount of time a system remains operational and available.

---

# V

## Version Control
A system for tracking code changes over time.

**Examples:**
- Git
- Azure DevOps Repos
- GitHub

---

# W

## War Room
A dedicated communication channel or meeting established during a major incident.

## Workaround
A temporary solution used until a permanent fix can be implemented.

---

# Must-Know Terms for Interviews

If you're interviewing for Production Support, SRE, or DevOps roles, make sure you can confidently explain:

1. Incident Management
2. Root Cause Analysis (RCA)
3. MTTD, MTTA, and MTTR
4. SLA, SLI, and SLO
5. Error Budgets
6. Observability
7. Monitoring vs. Alerting
8. High Availability (HA)
9. Disaster Recovery (RTO/RPO)
10. CI/CD
11. Infrastructure as Code (IaC)
12. Containers and Kubernetes
13. Blue-Green Deployments
14. Canary Deployments
15. Rollbacks
16. Change Management
17. Runbooks and Playbooks
18. On-Call Support
19. Load Balancing
20. Fault Tolerance

These concepts form the foundation of most modern Production Support, SRE, and DevOps roles.