# Terraform Web Service (Production Style AWS Deployment)

## Overview

This project demonstrates a production style AWS infrastructure deployment using Terraform.

It is intentionally structured to reflect real world engineering practices rather than a basic EC2 demo.

The infrastructure includes:
	-	Custom VPC (not default)
	-	Multi-AZ public subnets
	-	Internet Gateway + route tables
	-	Security groups with scoped access
	-	Application Load Balancer (ALB)
	-	Target group with health checks
	-	Auto Scaling Group (ASG)
	-	Launch template for instance configuration
	-	Remote Terraform state (S3 + DynamoDB locking)
	-	CloudWatch alarms for observability

This project demonstrates structured, safe infrastructure management with clear separation of concerns.

## Architecture Flow

User - ALB (Listener :80)
ALB  - Target Group
Target Group -  Auto Scaling Group
ASG  - EC2 instances running nginx

Infrastructure is deployed using Terraform with remote state and locking enabled.

## IAM & Access Strategy

This project follows a least privilege mindset:

- Human users should not use AdministratorAccess by default.
- CI/CD pipelines must use dedicated machine roles with restricted permissions.
- Production environments should not be directly modifiable by all developers.
- Access keys should never be committed to code and must be rotated if exposed.
- Temporary credentials are preferred over long lived static keys.

Security is part of infrastructure design, not an afterthought.

## Environments
Dev: used for controlled testing and validation.
Prod: structured for stricter configuration and protection (prevent_destroy mindset).

State is separated using unique keys within the same S3 bucket.

## How to run (dev)

All commands are run from the Terraform directory.

```bash
terraform init
terraform fmt -recursive 
terraform validate
terraform plan -var-file=dev.tfvars -var="my_ip=$(curl -4 -s ifconfig.me)/32"
terraform apply -var-file=dev.tfvars -var="my_ip=$(curl -4 -s ifconfig.me)/32"
```

After verification, resources should be destroyed to avoid unnecessary costs:

```bash
terraform destroy -var-file=dev.tfvars -var="my_ip=$(curl -4 -s ifconfig.me)/32"
```

## Observability

CloudWatch alarms monitor:
- Unhealthy target count in the target group
- ALB 5XX errors

This ensures failures are visible instead of discovered by users.

## Lessons Learned
- Infrastructure safety comes from structure, not speed.
- Plan must be reviewed before apply.
- Load balancers require multi AZ design.
- Observability is essential in production environments.
- Destroying unused infrastructure prevents cost creep 

## What This Project Demonstrates
- Terraform modular structure
- Environment separation
- Remote state + locking
- Safe change workflows
- Load-balanced, scalable web architecture
- Production mindset


 
 
 
