# Day 54 – Production-Style Terraform PR Plan Pipeline

## Objective

Implement a real world Terraform pull request workflow that runs a safe, backend disabled plan before merge.

## What Was Built

CI Workflow
- terraform fmt
- terraform validate
- Triggered on pull requests and pushes to main

PR Plan Workflow
- Runs on pull request to main
- Uses AWS credentials
- Disables remote backend to avoid state lock conflicts
- Executes:
```bash
terraform init -backend=false
terraform plan -lock=false -refresh=false
```
- Explicitly passes variables to prevent local path leakage
- Ensures infrastructure changes are visible before merge

## Problems Faced & Solved
- DynamoDB lock permission errors
- Absolute local path leaking into CI (/Users/...)
- Case sensitivity mismatch (Projects/ vs projects/)
- tfvars not resolving correctly in CI context
- Workflow execution directory confusion

## Key Lessons
- Linux CI runners are case sensitive.
- Never hardcode absolute local paths in Terraform.
- PR plans should disable backend to avoid remote state conflicts. 
- Always isolate failing layer: GitHub - Terraform - AWS.
- Clean branch lifecycle is part of professional workflow. 

## Result 
- Fully green CI and PR Plan pipeline 
- Clean Git history (squash merge)
- Branch protection ready structure 
- Production style infrastructure workflow 