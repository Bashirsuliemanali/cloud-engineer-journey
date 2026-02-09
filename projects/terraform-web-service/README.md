# Terraform Web Service Project 
## Project Overview
This project demonstrates how to provision and manage a simple web service on AWS using Terraform in a production style way. The focus is not just on creating resources, but on doing it safely, predictably, and in a way that reflects real world team workflows.

## Why Terraform?
Terraform allows infrastructure to be defined as code, making changes predictable, reviewable, and repeatable. Instead of relying on manual console changes, this project uses Terraform to manage infrastructure lifecycle in a controlled way.

## Why Separate Environments?
Separating dev and prod environments reduces risk. Changes can be tested safely in dev before being promoted to production, helping prevent outages and unintended consequences.

## Why Remote State?
Remote state ensures Terraform state is stored safely and shared consistently across a team. Using S3 and DynamoDB prevents state loss, enables locking, and avoids conflicting changes.