# Day 9 – Terraform First EC2

## Goal
Create and manage an EC2 instance using Terraform.

## What I did
- Installed and initialized Terraform
- Configured AWS provider
- Created EC2 via Terraform
- Added outputs for public IP
- Created and attached security group
- Added SSH key pair (replacement required)
- Applied changes safely and SSH’d into instance

## Key learnings
- Terraform state vs AWS reality
- Some changes force resource replacement
- Plan before apply always
- Infrastructure as Code > CLI for repeatability