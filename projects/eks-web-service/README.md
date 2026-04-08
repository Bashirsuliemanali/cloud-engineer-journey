# EKS Web Service

A production style Kubernetes platform built on AWS using Terraform. 
This project provisions a fully working EKS cluster from scratch
networking, IAM, compute, and a live deployed application.

## What This Project Does

Provisions a complete EKS environment on AWS including:
- A custom VPC with public and private subnets across two availability zones
- An EKS cluster with worker nodes running a live nginx application
- IAM roles and policies following least privilege principles
- Remote state management using S3 and DynamoDB locking
- A Kubernetes deployment and LoadBalancer service exposing the app publicly

## Architecture

Internet -> IGW -> Public Subnets (eu-west-2a, eu-west-2b)
|
EKS Worker Nodes
|
EKS Control Plane (AWS Managed)

## Infrastructure Stack

- **AWS** — EKS, VPC, IAM, S3, DynamoDB, ELB
- **Terraform** — all infrastructure provisioned as code
- **Kubernetes** — deployment and service manifests
- **kubectl** — cluster interaction and verification

## Project Structure

eks-web-service/
├── terraform/
│   ├── main.tf          # VPC, subnets, IGW, route tables
│   ├── eks.tf           # EKS cluster and node group
│   ├── iam.tf           # IAM roles and policy attachments
│   ├── outputs.tf       # VPC ID, subnet IDs, role ARNs
│   ├── variables.tf     # Region, project name, environment
│   ├── backend.tf       # Remote state — S3 + DynamoDB locking
│   ├── providers.tf     # AWS provider, version constraints
│   └── dev.tfvars       # Dev environment variable values
└── kubernetes/
├── deployment.yaml  # nginx deployment, 2 replicas
└── service.yaml     # LoadBalancer service, port 80

## How to Run

## Before You Start 
AWS CLI configured, Terraform installed, kubectl installed

```bash
cd terraform
terraform init
terraform fmt -recursive
terraform validate
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"
```

Connect kubectl:
```bash
aws eks update-kubeconfig --region eu-west-2 --name eks-web-service-cluster
```

Deploy the app:
```bash
cd ..
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
kubectl get pods
kubectl get service web-app-service
```

**Always clean up before destroying:**
```bash
kubectl delete -f kubernetes/service.yaml
kubectl delete -f kubernetes/deployment.yaml
cd terraform
terraform destroy -var-file="dev.tfvars"
```

## Key Decisions and Learnings

**Remote state** — Terraform state stored in S3 with DynamoDB locking. 
Prevents two engineers pushing at the same time and corrupting the state file.

**Two IAM roles** — The cluster role is assumed by EKS to manage AWS 
resources. The node role is assumed by EC2 so worker nodes can join the 
cluster, manage pod networking and pull images from ECR.

**Two availability zones** — All subnets spread across eu-west-2a and 
eu-west-2b. If one data centre goes down the cluster stays live.

**NAT Gateway gap** — In production, worker nodes would sit in private 
subnets with a NAT Gateway providing outbound internet access without 
exposing them directly. For this project nodes run in public subnets to 
avoid the NAT Gateway cost (~£32/month). This is a known trade off, not 
an oversight.

**Destroy order matters** — Always delete Kubernetes services before 
running terraform destroy. The LoadBalancer holds onto subnets and blocks 
deletion if not removed first.

## What I'd Add in Production

- NAT Gateway for private node networking
- Explicit security groups for cluster and node traffic control  
- OIDC provider and IRSA for pod level AWS permissions
- Cluster autoscaler
- Prometheus and Grafana monitoring stack
- HTTPS with ACM certificate on the LoadBalancer