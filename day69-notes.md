# Day 69 -Notes 

Ran the full Terraform workflow on the clean project for the first time.
terraform init connected to the S3 backend and downloaded the AWS provider. Hit an error straight away — DynamoDB table name was wrong in backend.tf, had 'terraform-lock' instead of 'terraform-locks'. Went into the AWS console, found the real name, fixed it, re-ran init with -reconfigure flag.
terraform fmt reformatted four files automatically. terraform validate came back clean. terraform plan returned exactly what we predicted — 6 resources to add, 0 to change, 0 to destroy. Two IAM roles and four policy attachments all ready to go.

## Key lesson today — 
read every error Terraform gives you. It tells you exactly what's wrong and usually tells you how to fix it. Don't panic, just read.