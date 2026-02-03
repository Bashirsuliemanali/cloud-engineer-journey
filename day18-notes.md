# Day 18 - Safe Terraform Workflow

Today I focused on running Terraform the correct way, not just getting things to work. i used Terraform fmt and Terraform validate before doing anything. Then i reviewed the plan carefully to make sure there were no destructive changes. 

I applied using environment variables from dev.tfvars and passed my current IP dynamically for SSH access, which is useful when switching networks.

After verifying nginx was running on the EC2 instance, i destroyed the infrastructure to keep costs down and maintain good discipline.

This reinforced the importance of planning before applying and checking infrastructure changes carefully.