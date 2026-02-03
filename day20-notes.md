# What is Terraform state?
Terraform state is what Terraform believes already exists in your infrastructure. 
Instead of starting from scratch every time, Terraform uses the state file to compare what exists in AWS with what is written in your code, then decides what needs to be created, updated, or destroyed.

# Why plan is non-negotiable
Terraform plan is used to see exactly what changes will happen before applying them. 
It shows what will be created, changed, or destroyed so you can catch mistakes early. 
It’s always better to review the plan than to fix broken infrastructure after.

# EC2 replacements
Some changes will cause an EC2 instance to be replaced, such as changing the AMI or user_data, because the instance needs to be rebuilt from scratch.

Other changes, like updating security group rules or changing the allowed IP address, do not recreate the instance. These changes can be applied in place, which is important when teams need to access infrastructure from different locations.