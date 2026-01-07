# Day 2 and 3 - EC2 fundamentals 

## What is EC2?
EC2 is a virtual computer you can rent from AWS to run websites, applications, APIs, and experiments without owning physical hardware.

## EC2 Lifecycle 
- Running: The virtual computer is active.
- Stopped: The virtual computer has be paused and isnt costing you anything. Storage does still continue.  
- Terminated: The virtual computer has been deleted for good.

## Why Public IPs change
Public IPs change when an EC2 instance is stopped and started because AWS recycles public IPs. By default, EC2 public IPs are temporary unless you use an Elastic IP.

## What is a security group?
A security group is a virtual firewall that controls what inbound and outbound traffic is allowed to an EC2 instance.

## PORTS I KNOW SO FAR
- 22: SSH (secure shell)
- 80: HTTP (web)
- 443: HTTPS (secure web)
