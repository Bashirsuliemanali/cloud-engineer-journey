## Day 47 — ALB in Front of EC2 (Stable Entry Point)

Today I put an Application Load Balancer (ALB) in front of my EC2 nginx web server.

# What I built
	•	Internet-facing ALB (public entry point)
	•	Target group (HTTP:80) with health check on /
	•	Listener (HTTP:80) forwarding to the target group
	•	Target group attachment pointing at the EC2 instance

# Verification
	•	I tested the ALB endpoint with curl and got HTTP/1.1 200 OK
	•	I confirmed in the browser that nginx loads via the ALB DNS

# Key lesson
	•	Users should hit the ALB DNS, not the EC2 public IP
	•	ALB is the foundation for scaling, reliability, and adding HTTPS later

# Discipline
	•	After testing, I destroy the infrastructure to avoid AWS costs.