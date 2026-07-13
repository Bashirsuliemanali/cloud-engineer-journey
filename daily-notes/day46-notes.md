# Day 46 — VPC Basics (No More Default VPC)

Today was a big step because I stopped relying on the default VPC and built my
own network properly using Terraform.

## What I built
I created a minimal custom VPC setup using a new "modules/vpc" module:

- VPC (10.0.0.0/16)
- Public Subnet (10.0.1.0/24)
- Internet Gateway (so the subnet can reach the internet)
- Public Route Table + Route Table Association (0.0.0.0/0 -> IGW)

Then I deployed my EC2 nginx instance into my own subnet, not AWS default.

## Key learning
The default VPC is convenient, but it’s lazy engineering because you inherit
networking you didn’t design. Real environments need intentional boundaries:
CIDR ranges, subnets, routing, and internet exposure.

## Security group discipline
I kept HTTP open to the world for the web demo:
- Port 80: 0.0.0.0/0

But I restricted SSH access:
- Port 22: locked to my exact IP (my_ip/32)

This makes the demo usable without being reckless.

## Workflow 
I followed the non-negotiables:
- terraform init (new module)
- terraform fmt -recursive
- terraform validate
- terraform plan (and I checked there were no destroys)
- terraform apply, verified nginx loaded
- terraform destroy to keep costs down

## Result
Terraform output gave me an EC2 public IP, I opened it in Safari, and nginx
loaded successfully. After verification, I destroyed everything and confirmed
"terraform state list" was empty.

Boring apply = good sign.