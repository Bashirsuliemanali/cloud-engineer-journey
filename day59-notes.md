# Day 59 – Production Plan Review & Outage Thinking

Today was focused on developing production awareness when reviewing Terraform plans.
Instead of writing new infrastructure, the emphasis was on:
- Reading plans correctly
- Identifying blast radius
-	Spotting hidden downtime risks
-	Thinking like a production engineer
-	Understanding how small changes can cause outages

## Key Lessons Learned

### 1. Launch Template Replacement - Automatic Downtime

Updating an AMI in a launch template does not necessarily cause downtime.

Zero downtime depends on:
-	ASG min/max capacity
-	Health checks passing before termination
-	Proper health_check_grace_period
-	Rolling replacement behaviour

The ASG should handle gradual instance replacement safely.

### 2. Forced ASG Replacement Is Suspicious

```bash 
(forces replacement)
```
on an Auto Scaling Group, this is a red flag.

ASGs rarely need full replacement. Before approving:
-	Identify what attribute changed
-	Check if in place update is possible
-	Evaluate blast radius
-	Confirm zero-downtime strategy

### 3. Target Group Port Changes Can Break Production

```bash
port = 80 → 8080
```
without updating the application configuration can cause:
-	Health check failures
-	All targets becoming unhealthy
-	ALB returning 503 errors

Infrastructure layers must align:
- User → ALB → Target Group → Instance
- Any mismatch breaks traffic flow.

### 4. Deletion Protection Is a Guardrail
Enabling:
```bash
enable_deletion_protection = true
```
is a safe production hardening measure.
However:
- Destroy will fail unless break-glass is performed
-	A documented emergency process is required

### 5. Health Check Path Changes Are Dangerous
Changing:
```bash
path = "/" → "/health"
```
is risky if the application does not expose /health.
If health checks fail:
- Targets become unhealthy
-	ALB stops routing traffic
-	503 errors occur
-	Outage without infrastructure replacement

Not all outages are caused by destroy operations.

### 6. Scaling Desired Capacity
Changing:
```bash
desired_capacity = 1 → 3
```
is generally safe but requires:
-	Subnet capacity
-	EC2 quota availability
-	Healthy AMI and user_data
-	Proper target group health

Scaling can silently fail if instances do not become healthy.

### 7. Health Check Grace Period Risks
Reducing:
```bash
health_check_grace_period = 60 → 10
```
can cause instance churn:
-	Instances marked unhealthy too quickly
-	ASG terminates instances prematurely
-	Continuous launch/terminate loop
-	Capacity instability

Grace period should reflect real boot time.

## Debugging Flow Learned

If ALB returns 503:
	1.	Check Target Group health first
	2.	Verify instances are healthy
	3.	Check health check path and port
	4.	Review security groups
	5.	Then check CloudWatch metrics

CloudWatch tells you something broke.
Target Group health tells you why.

## Production Plan Review Strategy

When reviewing a Terraform plan:
	1.	Start with summary:
  `Plan: X to add, Y to change, Z to destroy`
  2.	Immediately scan for:
	- destroy
  - forces replacement
	3.	Review changes affecting:
	-	Networking
	-	ALB / Target Groups
	-	ASG
	-	Health checks
	-	Scaling
	4.Evaluate blast radius before approving

Automation is powerful.
Apply must never be blind.

