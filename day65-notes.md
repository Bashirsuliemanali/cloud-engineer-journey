# Day 65 – EKS Project Kickoff

## Focus of the Day
Today was the kickoff for Project 2: `eks-web-service`.

The goal was not to rush into building the cluster, but to set the project up properly and understand the basic Kubernetes concepts first

## What Was Done
- created the new project folder structure
- added a starter README
- separated Terraform and Kubernetes folders
- locked the first 5 core Kubernetes concepts:
  - cluster
  - node
  - pod
  - deployment
  - service
- defined the first phase goal for the project

## Key Concepts Learned
- A cluster is the overall Kubernetes environment
- A node is a worker machine in the cluster
- A pod is the smallest deployable unit and usually runs the app container
- A Deployment manages pods and keeps the desired number running
- A Service gives pods a stable way to be reached

## Architecture Direction
Planned request flow:

User  
- Load Balancer / Ingress  
- Kubernetes Service  
- Deployment  
- Pods  
- nginx container

## Phase 1 Goal
Build a simple EKS-based web service in clear stages, starting with the cluster foundation and then deploying a basic app before adding more advanced Kubernetes features.

## Reflection
Today was about setting a clean base instead of rushing. Project 2 starts with more structure and clarity than Project 1 did, which should make the build smoother.