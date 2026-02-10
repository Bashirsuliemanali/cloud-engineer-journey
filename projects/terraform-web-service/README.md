# Terraform Web Service Project 
## Overview

This project demonstrates how to deploy and manage a simple web service on AWS
using Terraform, with a strong focus on safety, structure, and real-world
engineering practices.

The goal is not just to provision infrastructure, but to show how Terraform
is used responsibly in a team environment using remote state, locking,
environment separation, and a clear plan/apply workflow.

## Architecture 

This project provisions:

- An EC2 instance running nginx
- A security group allowing:
  - SSH access (restricted to the developer IP in dev)
  - HTTP access for web traffic
- Terraform remote state stored in Amazon S3
- State locking using Amazon DynamoDB
- A modular Terraform structure with environment-specific variables

The infrastructure is designed to be simple, readable, and safe to operate,
rather than complex or over-engineered.

## How to run (dev)

All commands are run from the Terraform directory.

```bash
terraform fmt -recursive
terraform init
terraform validate
terraform plan -var-file=dev.tfvars -var="my_ip=$(curl -4 -s ifconfig.me)/32"
terraform apply
```

After verification, resources should be destroyed to avoid unnecessary costs:

```bash
terraform destroy -var-file=dev.tfvars -var="my_ip=$(curl -4 -s ifconfig.me)/32"
```

## Cost and Clean-up

This project is for learning and demonstration purposes only.
All infrastructure is destroyed after verification to avoid ongoing AWS costs. 
This mirrors real world engineering discipline and cost awareness.
Cost control is treated as part of the engineering responsibility.
