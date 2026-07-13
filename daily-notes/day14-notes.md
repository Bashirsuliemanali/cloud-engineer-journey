# Day 14 – Terraform Workspaces (dev vs default)

Today I started using Terraform workspaces to separate environments properly.

## What I did
- Created a new workspace called "dev"
- Ran Terraform from the dev workspace so it has its own separate state
- Updated resource naming so AWS resources don’t clash between workspaces

## Key lesson
Workspaces separate Terraform state, but AWS still sees resource names globally inside a VPC/account.

So when I first tried to apply in the dev workspace, AWS rejected it because the names already existed from the default workspace:
- Security group name was duplicated
- Key pair name was duplicated

## Fix
I made names workspace-aware:
- Security group: bashir-terraform-sg-${terraform.workspace}
- Key pair: bashir-terraform-key-${terraform.workspace}
- EC2 tag name: bashir-terraform-ec2-${terraform.workspace}

After that, Terraform created clean dev resources with no conflicts.

## Result
- Apply in workspace dev created 3 resources successfully
- The output public IP worked
- nginx loads in the browser (server bootstrapped via user data)

## Extra note
My IP command returned IPv6 at first, so I used "curl -s4 ifconfig.me" to force IPv4 for the SSH CIDR.