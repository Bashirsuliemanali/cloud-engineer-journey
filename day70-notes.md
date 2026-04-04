# Day 3

Completed the full networking setup in main.tf and got a clean plan against real AWS.

## What I built today:

VPC — 10.0.0.0/16 CIDR block, DNS hostnames and DNS support enabled. Both needed for EKS nodes to communicate properly inside the cluster.
Internet Gateway — attached to the VPC using a resource reference aws_vpc.main.id. Learned that this is an implicit dependency — Terraform sees the reference and automatically creates the VPC before the IGW.
4 subnets — 2 public and 2 private, spread across eu-west-2a and eu-west-2b. Public subnets have map_public_ip_on_launch = true so resources get a public IP automatically. Private subnets have it set to false — no direct internet exposure. Each subnet has its own unique CIDR block so IP ranges never overlap.
2 route tables — public route table has 0.0.0.0/0 pointing to the IGW, that single route is what makes it public. Private route table has no route to the IGW deliberately — EKS worker nodes sit in private subnets and should never be directly reachable from the internet.
4 route table associations — the link that connects each subnet to its correct route table.
terraform plan result — 18 to add, 0 to change, 0 to destroy. 6 IAM resources plus 12 networking resources. All clean.