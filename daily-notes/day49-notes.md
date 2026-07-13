# Day 49 — Observability Basics (CloudWatch Alarms)
Today I learned that production reliability starts with visibility.
When an ALB returns 503, the most common cause is “no healthy targets” in the target group, not a random internet issue.

I added CloudWatch alarms for:
	•	TargetGroup UnHealthyHostCount 
	•	 ALB 5XX responses

This reinforced a simple incident flow:
check target group health - check security groups reachability - check nginx/app - check autoscaling capacity.

I applied and verified the ALB URL returned HTTP 200, then destroyed all resources to avoid costs.