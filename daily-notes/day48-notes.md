# Day 48 — ALB Verification + Safe Destroy

Today I validated the full ALB flow end-to-end, not just the EC2.
	•	Ran the usual safety workflow: init - fmt - validate - plan - apply.
	•	Verified the service through the load balancer, not the instance:
	•	curl -I $(terraform output -raw alb_url) returned HTTP 200 OK
	•	Confirmed the ALB URL loads in the browser and serves nginx.
	•	This proved the chain is working:
ALB listener - target group health check - instance attachment - nginx on port 80.
	•	Destroyed everything after verification to keep costs down and keep the repo disciplined.

Key takeaway: success is verifying through the ALB, because that’s what users hit in real life — not the instance IP.