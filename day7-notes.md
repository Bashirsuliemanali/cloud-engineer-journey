# Day 7 – AWS CLI + EC2 + Linux Fundamentals

## Goal
Launch and operate an EC2 instance using the AWS CLI and manage it via SSH.

## What I did
- Verified AWS CLI authentication with STS
- Created an EC2 key pair via CLI
- Created a security group and allowed SSH + HTTP
- Launched an EC2 instance using the AWS CLI
- SSH’d into the instance using a .pem key
- Identified OS and user (Amazon Linux 2023)
- Installed and ran nginx using dnf and systemctl
- Served a live web page from EC2

## Result
- EC2 instance accessible via SSH
- Nginx running and reachable over HTTP

## Key learnings
- Difference between console vs CLI workflows
- How security groups control traffic
- Basic Linux service management
- How cloud infrastructure and Linux connect