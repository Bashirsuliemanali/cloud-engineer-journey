# Day 17 – Environment config with tfvars + AMI variable

Today I finished wiring my Terraform setup so the same code can be used across environments without editing files.

## What I did
- Added a new root variable for the AMI (var.ami)
- Updated the EC2 module call so the AMI is no longer hardcoded
- Created "dev.tfvars" to hold environment specific values
- Passed dynamic values (my_ip) at runtime

## How I run Terraform now
I use a mix of:
- -var-file for environment config
- -var for dynamic values like my public IP

Example:
- "terraform plan -var-file=dev.tfvars -var="my_ip="
- "terraform apply -var-file=dev.tfvars -var="my_ip="

## Result
- Terraform applied cleanly in the dev workspace
- EC2 instance was created via the module
- nginx loaded successfully in the browser

## Key takeaway
Same Terraform code, different environments, no hardcoding.
This is how real dev/prod setups are managed.