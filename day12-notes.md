# Day 12 – Terraform Remote State (S3 Backend)

Today I moved my Terraform state from local storage on my laptop to AWS S3, the way it’s done in real teams.

## What I did
- Created an S3 bucket: "bashir-terraform-state-2026"
- Enabled versioning and kept the bucket private (block public access ON)
- Added a Terraform backend config in "backend.tf" so Terraform stores state in S3:
  - key: terraform/state.tfstate
  - region: eu-west-2
- I ran terraform init to switch Terraform to the S3 backend

## Proof it worked
I checked the bucket and the state file exists:
- terraform/state.tfstate

## Why this matters
- Local state is risky (if you lose the file you lose Terraform’s memory)
- Remote state means I can run Terraform from any machine and it still knows what resources exist
- This is the standard approach for real world Terraform use