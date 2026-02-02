# Day 16 – Terraform Modules (clean structure)

Today I refactored my Terraform code into a reusable module.

## What I did
- Created a module under `modules/ec2`
- Moved the EC2 resource into the module
- Defined clear inputs in the module (`ami`, `instance_type`, `key_name`, `security_group_id`, `name`)
- Exposed the EC2 public IP via a module output
- Wired the module into root `main.tf`

## Why modules matter
- Keeps Terraform code clean and readable
- Makes infrastructure reusable across environments
- This is how real teams structure Terraform projects

## Result
- Terraform validates successfully
- Plan shows expected resources to create
- No errors after introducing modules