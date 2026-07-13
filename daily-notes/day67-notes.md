# Day 67 – EKS VPC, IAM, and Cluster Build

## Focus of the Day
Today was the first real infrastructure build day for the EKS project.

The goal was to move from a Terraform skeleton into an actual working AWS EKS control plane, while keeping the build clean and understandable.

The focus was on:
- networking
- IAM roles
- EKS cluster creation
- local kubeconfig access

## What Was Built

### 1. Custom VPC Module
A fresh VPC module was created for the EKS project.

It includes:
- custom VPC
- 2 public subnets across 2 Availability Zones
- Internet Gateway
- public route table
- route table associations

### 2. EKS Cluster IAM Role
An IAM role was created for the EKS control plane.

This allows AWS to manage the cluster itself.

The main policy attached was:
- `AmazonEKSClusterPolicy`

### 3. EKS Node IAM Role
A separate IAM role was created for worker nodes.

This allows EC2 nodes to:
- join the Kubernetes cluster
- work with the EKS networking plugin
- pull images from container registries

Policies attached:
- `AmazonEKSWorkerNodePolicy`
- `AmazonEKS_CNI_Policy`
- `AmazonEC2ContainerRegistryReadOnly`

### 4. EKS Cluster Resource
The EKS cluster itself was created successfully using the custom VPC subnets.

The cluster was deployed in:
- `eu-west-2`

Cluster name:
- `bashir-eks-dev`

### 5. Local kubeconfig Access
Local access to the cluster was configured using:

```bash
aws eks update-kubeconfig --name bashir-eks-dev --region eu-west-2
```

### Verification steps:
- kubectl config current-context returned the EKS cluster ARN
-	kubectl get nodes returned no nodes, which is expected because the node group has not been created yet

## Verification Performed

Cluster verification:
```bash
aws eks describe-cluster \
  --name bashir-eks-dev \
  --region eu-west-2 \
  --query 'cluster.[name,status,version,endpoint]' \
  --output table
  ```
  Confirmed:
- cluster name correct
-	status = ACTIVE
-	Kubernetes version visible
-	cluster endpoint live

## Key Lessons Learned

1. EKS cluster does not mean workloads are ready

The control plane can be active while there are still no worker nodes.

That is why:
-	kubectl worked
-	but kubectl get nodes returned nothing

2. IAM is a core dependency

EKS cannot be built cleanly without understanding:
-	cluster role
-	node role
-	policy attachments

3. Building EKS in layers is the right approach

Today only covered:
-	networking
-	IAM
-	control plane



