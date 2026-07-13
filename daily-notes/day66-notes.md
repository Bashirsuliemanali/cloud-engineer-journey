# Day 66 – EKS Terraform Skeleton

## Focus of the Day
Today was about setting up the Terraform foundation for Project 2: `eks-web-service`.

The goal was not to build the cluster yet, but to create a clean starting point so the EKS project can grow in a structured way instead of becoming messy early.

## What Was Done
- initialized the Terraform working directory for the new EKS project
- added the AWS provider configuration
- added the base Terraform version and required provider block
- defined the first core variables for the EKS project
- created `dev.tfvars` for the development setup
- set up placeholder `main.tf` and `outputs.tf`
- validated the Terraform skeleton successfully

## Files Added / Prepared
Inside `projects/eks-web-service/terraform`:

- `providers.tf`
- `variables.tf`
- `dev.tfvars`
- `main.tf`
- `outputs.tf`

`backend.tf` was left empty for now so the backend decision can be made intentionally later.

## Variables Added
The Terraform skeleton now includes variables for:
- AWS region
- EKS cluster name
- worker node instance type
- desired node count
- minimum node count
- maximum node count

This gives the project a cleaner starting point before any actual AWS resources are created.

## Commands Run
```bash
terraform init
terraform fmt -recursive
terraform validate
```
## Result:
-	Terraform initialized successfully
-	formatting completed
-	configuration validated successfully

## Key Learning

Today reinforced that EKS should not be rushed.

Before creating the cluster itself, it is important to have:
-	clear file structure
-	clean variable definitions
-	consistent naming
-	a valid Terraform base

That makes the later infrastructure work much easier.


