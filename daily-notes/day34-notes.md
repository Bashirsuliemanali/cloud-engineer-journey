# Day 34 – Terraform Structure & Responsibility

Today focused on Terraform structure rather than new resources.

I reinforced the separation between root modules (control) and child modules (execution). The root module defines environment level decisions like region, AMI, instance type, and access rules, while the EC2 module only consumes inputs and creates infrastructure.

I ran terraform fmt, validate, and plan before applying, reviewing the plan carefully to ensure no unexpected changes or destroys. This reinforced why plan review is more important than writing code.

After verifying behaviour, infrastructure was destroyed to maintain good cost and state discipline.

Key takeaway - clean Terraform is about predictable behaviour, not speed.