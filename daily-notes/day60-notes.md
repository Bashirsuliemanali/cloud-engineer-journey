# Day 60 – Outage Simulation & Production Debugging

## Focus of the Day

Today was a live outage simulation focused on:
	•	Investigating 503 errors from an ALB
	•	Diagnosing unhealthy targets
	•	Understanding health check failures
	•	Security group misconfiguration
	•	Production safe remediation
	•	Blue/Green strategy for forced replacements

The goal was to build calm, structured incident thinking.

### Scenario 1 – ALB Returning 503

Situation

Users reported 503 errors from the ALB.

Target Group showed:
	•	Instance unhealthy
	•	Reason: Health checks failed

Lesson

503 from ALB usually means:

No healthy targets available.

Correct Debug Order
	1.	Check Target Group health
	2.	Confirm instance is reachable
	3.	Check health check path/port
	4.	Review security groups
	5.	Then review CloudWatch metrics

CloudWatch tells you something broke.
Target Group health tells you why.

### Scenario 2 – Security Group Misconfiguration

Root Cause

Instance security group did not allow inbound HTTP from the ALB security group.

ALB could not reach the instance on port 80.

Correct Fix (Least Privilege)
	•	Add inbound rule:
	•	Port 80
	•	Source: ALB security group
	•	Remove broad 0.0.0.0/0 if present 

Slack Communication Example

“Root cause identified: missing ALB - instance SG rule.
Applying least-privilege fix. Expect targets healthy shortly.”

Lesson

Security tightening without understanding traffic flow can cause outages.

### Scenario 3 – Health Check 404

Situation

Target Group health check path was /health
nginx only served /

Health check returned 404 - targets marked unhealthy.

Immediate Fix (Production First)

Revert health check path to / to restore availability.

Long Term Improvement

Implement a proper /health endpoint in the application.

Lesson

Not all outages involve destroy or replacement.
Small configuration mismatches can break traffic.

### Scenario 4 – Health Check Grace Period Risk
Reducing:
`health_check_grace_period = 60 → 10`
Can cause:
	•	Instances marked unhealthy too quickly
	•	Termination loop
	•	Capacity instability

Grace period must reflect real boot time.

### Scenario 5 – Forced ALB Replacement

Terraform showed:
`-/+ aws_lb.web_alb (forces replacement)`
Due to subnet changes.

Risk

Replacing the ALB in production changes the entry point.
If users rely on ALB DNS, downtime is likely.

Safe Strategy

Blue/Green approach:
	1.	Create new ALB
	2.	Attach target group
	3.	Validate healthy targets
	4.	Switch traffic via Route 53
	5.	Decommission old ALB

Never replace entry-point infrastructure directly in prod.





