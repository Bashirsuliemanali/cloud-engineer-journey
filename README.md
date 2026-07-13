# Bashir Ali — Cloud Engineering Portfolio

Self-taught DevOps Engineer building real AWS infrastructure with Terraform, Kubernetes, and CI/CD. No bootcamp, no shortcuts — every project built, broken, debugged, and documented by me.

## Projects

### [EKS Web Service](projects/eks-web-service)
Provisioned a complete EKS environment from scratch — VPC, IAM, worker nodes, live app. Debugged a real NodeCreationFailure caused by a missing NAT Gateway.

### [CI/CD Pipeline](projects/cicd-pipeline)
Fully automated deployment pipeline — GitHub Actions to ECR to EKS, zero manual steps, OIDC authentication with no static credentials.

### [EKS Monitoring Stack](projects/eks-monitoring)
Prometheus and Grafana on EKS via Helm. Diagnosed and fixed an OOM-kill issue by resizing node types and updating Terraform resource limits.

## Stack

AWS (EKS, VPC, IAM, S3, DynamoDB, ECR) · Terraform · Kubernetes · Docker · GitHub Actions · Python

## Daily progress

Day-by-day build notes are in [`/daily-notes`](daily-notes) if you want to see the full process behind these projects, not just the final result.
