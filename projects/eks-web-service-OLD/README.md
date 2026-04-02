# EKS Web Service

## Overview
This project is the next step in my cloud and DevOps journey after finishing my Terraform AWS web service project.

The goal here is to move from traditional EC2-based deployment into Kubernetes and EKS, while keeping the same production-style mindset:
- clear architecture
- safe changes
- health checks
- observability
- real debugging

This project will be built in phases so the setup stays understandable and intentional.

## Planned Scope
This project is planned to include:
- an EKS cluster on AWS
- managed node groups
- a simple web app deployed to Kubernetes
- Kubernetes Deployment and Service objects
- Ingress / load balancer access
- health checks and scaling basics
- production-style documentation and troubleshooting notes

## Project Structure
projects/eks-web-service/
README.md
terraform/
  main.tf
  variables.tf
  outputs.tf
  backend.tf 
  providers.tf
  dev.tfvars
kubernetes/
  deployment.yaml
  service.yaml
  ingress.yaml

## Status 
Phase 1 Goal:

Build a simple EKS-based web service in clear stages, starting with the cluster foundation and then deploying a basic app before adding more advanced Kubernetes features.