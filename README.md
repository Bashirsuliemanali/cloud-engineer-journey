# Cloud Engineer Journey (AWS + Terraform)

## Overview
This repository documents my hands on journey learning cloud engineering with a focus on AWS and Terraform. 
The goal is to build real infrastructure using Infrastructure as Code, follow safe workflows, and understand how cloud systems work in practice.

## What I’ve Built
- AWS EC2 infrastructure provisioned using Terraform
- Security groups with restricted SSH and HTTP access
- Server bootstrapping using user_data (nginx)
- Remote Terraform state using S3 with DynamoDB state locking
- Environment separation using workspaces and tfvars
- Modular Terraform structure for reuse and clarity
- Safe workflows using plan, apply, and destroy

## Tools & Technologies
- AWS (EC2, S3, IAM, Security Groups, DynamoDB)
- Terraform
- Linux (Amazon Linux)
- Git & GitHub

## Repository Structure
- `/terraform` – Terraform infrastructure code
- `dayX-notes.md` – Daily notes and reflections from each learning block

## Notes
This repository focuses on hands on learning and documenting progress rather than finished production projects.

### Day 30 – Terraform Consolidation & Confidence

Day 30 was a consolidation and reflection checkpoint. I focused on understanding why Terraform works the way it does, not just how to run commands.

By this point, I’m confident explaining state, remote backends, locking, drift, safe refactoring, and production guardrails. The main takeaway is that Terraform is about managing risk and change safely, not just provisioning infrastructure.