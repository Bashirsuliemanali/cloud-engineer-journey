# Day 13 – Terraform State Locking with DynamoDB

Today I added state locking to my Terraform setup using DynamoDB.

## What I did
- Created a DynamoDB table called terraform-locks
- Partition key: LockID (String)
- Updated backend.tf to include the DynamoDB table
- Re-ran terraform init -migrate-state to apply the backend change safely

## Why state locking matters
- Prevents two Terraform runs from modifying infrastructure at the same time
- Stops state corruption in team environments
- Terraform now acquires a lock before reading or writing state

## Key takeaway
Remote state without locking is risky.  
S3 + DynamoDB locking is the standard, production ready setup for Terraform.