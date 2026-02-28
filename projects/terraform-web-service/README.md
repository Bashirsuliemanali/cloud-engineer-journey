# Terraform Web Service (Production Style AWS Deployment)

## Overview
This project deploys a scalable nginx web service on AWS using Terraform, structured to reflect real world engineering practices.

It demonstrates:
- modular Terraform design
- remote state and locking (S3 + DynamoDB)
- safe workflows (plan first, review changes)
- basic production architecture (VPC + ALB + ASG)
- observability basics (CloudWatch alarms)

## Architecture
**Request flow:**
Client - **ALB (:80 listener)** = **Target Group (health checks)** - **Auto Scaling Group** - **EC2 (nginx)**

**Provisioned resources high level:**
- Custom VPC (non-default)
- 2 public subnets (Multi-AZ)
- Internet Gateway + public route table + associations
- Security group (scoped SSH in dev, HTTP for web traffic)
- Application Load Balancer (ALB) + listener + target group + attachment
- Launch Template + Auto Scaling Group
- CloudWatch alarms (ALB 5XX + unhealthy targets)
- Remote Terraform state (S3) + state locking (DynamoDB)

## Repository Structure
- projects/terraform-web-service/
- README.md
- terraform/
    - main.tf
    - variables.tf
    - outputs.tf
    - backend.tf
    - dev.tfvars
    - prod.tfvars
    - modules/
      - vpc/
      - ec2/
    - keys/

## Environments
- **dev**: fast iteration, scoped access (SSH limited to your IP)
- **prod**: stricter guardrails and intentional changes

State is separated by backend key naming, allowing one bucket to hold multiple envs/projects safely.

## How to Run (Dev)
Run all commands from:
`projects/terraform-web-service/terraform`

```bash
terraform init
terraform fmt -recursive
terraform validate

terraform plan -var-file=dev.tfvars -var="my_ip=$(curl -4 -s ifconfig.me)/32"
terraform apply -var-file=dev.tfvars -var="my_ip=$(curl -4 -s ifconfig.me)/32"
```
## Verify 
```bash
terraform output -raw alb_url
curl -I "$(terraform output -raw alb_url)"
```
## Destroy (Cost Dicipline)
```bash 
terraform destroy -var-file=dev.tfvars -var="my_ip=$(curl -4 -s ifconfig.me)/32"
```
## Safety and Guardrails 
Terraform is powerful, so this project follows safety habits:
-	Always review plan before apply
-	Watch for replacement actions and unintended destroys
-	Use remote state + locking to prevent concurrent writes
-	Treat “break-glass” changes as temporary and reviewed

## CI/CD Workflow (GitHub Actions)

This project includes automated Terraform workflows using GitHub Actions. 

Two workflows are configured:

### 1. Terraform CI (push & PR validation)
- Runs `terraform fmt -check`
- Runs `terraform validate`
- Prevents invalid configuration from merging into main
- Does not require AWS credentials

Purpose:
To block syntactically invalid or unsafe Terraform from entering the codebase.

### 2. Terraform Plan on Pull Request
- Authenticates securely using GitHub Secrets
- Runs `terraform init`
- Executes `terraform plan`
- Shows infrastructure changes before approval

Purpose:
To surface destructive changes (replacements, deletes) before they are applied.

### Manual Approval for Apply
Production style changes require manual review before apply.

This mirrors real world engineering workflows where:
- Plan is reviewed
- Destructive changes are questioned
- Applies are intentional

## Observability
CloudWatch alarms monitor:
- ALB 5XX errors
- Unhealthy target count in the target group

This ensures failures are visible early instead of discovered by users.

## Common Mistakes and Fixes 
**ALB error:** “At least two subnets in two different AZs must be specified”

Fix: ensure ALB subnets include two public subnets in different AZs.

**Terraform Lock Errors** 
- If a lock is stuck (e.g., previous run crashed), investigate before forcing unlock.
Do not disable locking in real production workflows.

**file(var.public_key_path)” fails in CI**
- Ensure the key exists in repo at the correct relative path and is referenced consistently in tfvars
