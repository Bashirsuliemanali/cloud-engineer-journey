# Terraform Web Service (AWS)

## Overview
This project deploys a scalable nginx web service on AWS using Terraform.

I built it to practice more than just getting an EC2 instance online. The aim was to work through a more production-style setup with proper networking, a load balancer, autoscaling, HTTPS, remote state, and some basic monitoring.

It covers:
- modular Terraform structure
- remote state and locking with S3 and DynamoDB
- VPC, subnets, route tables, and internet access
- ALB, target group, launch template, and Auto Scaling Group
- custom domain and HTTPS
- CloudWatch alarms for health, errors, and response time
- safer workflows like plan review and break-glass changes

## Architecture
Request flow:

Client -> Cloudflare DNS -> AWS ALB -> Target Group -> Auto Scaling Group -> EC2 (nginx)

Main resources in the project:
- Custom VPC
- 2 public subnets across 2 Availability Zones
- Internet Gateway and public route table
- Security group for SSH, HTTP, and HTTPS
- Application Load Balancer
- Target Group
- Launch Template
- Auto Scaling Group
- ACM certificate for HTTPS
- CloudWatch alarms
- S3 backend and DynamoDB locking for Terraform state

## Project Structure
projects/terraform-web-service/
README.md
terraform/
  main.tf
  variables.tf
  outputs.tf
  backend.tf
  dev.tfvars
  prod.tfvars
  modules/
    vpc/
    ec2/
  keys/

## Environments
-	dev: quicker testing, SSH limited to my IP
-	prod: stricter guardrails and more intentional changes

State is separated so different environments and projects can live safely in the same backend setup.

## Domain and HTTPS

The project is connected to a real custom domain:
-	bashircloud.com
-	www.bashircloud.com

HTTPS is handled with:
-	AWS Certificate Manager
-	ALB TLS termination
-	HTTP to HTTPS redirect
-	Cloudflare DNS

## How to Run (Dev)

Run everything from:
projects/terraform-web-service/terraform

```bash
terraform init
terraform fmt -recursive
terraform validate

terraform plan -var-file=dev.tfvars -var="my_ip=$(curl -4 -s ifconfig.me)/32"
terraform apply -var-file=dev.tfvars -var="my_ip=$(curl -4 -s ifconfig.me)/32"
```
### Verify 
```bash
terraform output -raw alb_url
curl -I "$(terraform output -raw alb_url)"
curl -I https://bashircloud.com
curl -I https://bashircloud.com/health
```

### Destroy (Cost Discipline)
```bash
terraform destroy -var-file=dev.tfvars -var="my_ip=$(curl -4 -s ifconfig.me)/32"
```
## Safety and Guardrails

Terraform is powerful, so I tried to build good habits into this project:
-	always review plan before apply
-	watch for replacements and unintended destroys
-	use remote state and locking to avoid collisions
-	treat break-glass changes as temporary and controlled

## CI/CD Workflow (GitHub Actions)

This project includes Terraform workflows in GitHub Actions.

### Terraform CI
-	runs terraform fmt -check
-	runs terraform validate
-	helps stop broken Terraform from reaching main

### Terraform Plan on Pull Request
-	runs terraform init
-	runs terraform plan
-	shows the expected infrastructure changes before approval

### Manual Approval for Apply

For production-style changes, apply should not be blind.

The idea is simple:
-	review the plan
-	question destructive changes
-	make applies intentional

## Observability

This project includes CloudWatch alarms for three useful signals:
-	UnHealthyHostCount - backend targets failing health checks
-	HTTPCode_ELB_5XX_Count - user-facing ALB errors
-	TargetResponseTime - slower backend responses even when the app is still up

### Troubleshooting flow
-	If targets become unhealthy, check the health check path, nginx status, and cloud-init output
-	If ALB 5XXs increase, check target registration state and recent rollout behaviour
-	If response time increases, inspect instance health and startup or runtime performance

This helps surface problems earlier instead of only finding out through users.

## Health Checks

The app exposes a simple /health endpoint.

That path is used by the target group health check so the load balancer is not relying on the homepage alone to decide whether the app is healthy.

## Common Mistakes and Fixes

### ALB error: “At least two subnets in two different AZs must be specified”
Make sure the ALB uses two public subnets in different Availability Zones.

### Terraform lock errors
If a lock gets stuck after an interrupted run, investigate before forcing unlock. Disabling locking is not the right fix in a real workflow.

### file(var.public_key_path) fails in CI
Make sure the key exists in the expected path and matches what is referenced in tfvars.

### 502 Bad Gateway during rollout
Check target health first. Then check:
-	whether nginx is running
-	whether cloud-init completed properly
-	whether the health check path exists
-	whether the ASG has actually launched a fresh instance from the updated launch template

## Lessons Learned

A few of the biggest lessons from this project:
-	small Terraform formatting mistakes can break instance bootstrapping in ways that are not obvious
-	launch template changes do not automatically refresh running ASG instances
-	DNS, ALB, target group, and instance issues need to be debugged one layer at a time
-	safe infrastructure work is not just about building, but also about controlled teardown and recovery

## Final Status

This project now includes:
-	Terraform-managed AWS infrastructure
-	custom VPC and networking
-	ALB, target group, launch template, and Auto Scaling Group
-	custom domain with Cloudflare DNS
-	HTTPS with ACM
-	/health endpoint for cleaner health checks
-	CloudWatch alarms for health, failures, and response time
-	break-glass workflow for protected resource teardown

This turned into a much stronger AWS/Terraform project than a basic single instance demo, and gave me a lot more practice with debugging and production-style thinking.