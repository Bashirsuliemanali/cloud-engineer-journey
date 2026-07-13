# Day 8 – Terraform Mental Model & AWS Foundations

## Goal
Understand why Terraform exists and how it fits with AWS.

## Key concepts
- AWS manages services, not intent
- CLI sends commands but doesn’t track state
- Terraform manages desired state

## Terraform responsibilities
- Define infrastructure as code
- Track state
- Plan and apply changes safely

## Mapping
- EC2 instance → aws instance
- Security group → aws security group
- SSH rules → ingress rules
- Tags → metadata for management

## Outcome
Terraform now makes sense conceptually before writing any code.