# Project 4 — EKS Monitoring Stack (Prometheus + Grafana)

## What is this project?

This project sets up a full monitoring stack on a live EKS cluster 
running on AWS. I used Terraform to build the infrastructure and 
Helm to deploy Prometheus and Grafana onto the cluster.

Prometheus watches everything — CPU, memory, pod health, node 
status — and Grafana turns all that data into live dashboards I 
can actually read. Think of it like CCTV for your infrastructure. 
Prometheus is the camera, Grafana is the screen.

## Why I built this

Any engineer can build infrastructure. Not everyone can tell you 
if it's healthy. This project closes that gap. When something goes 
wrong at 3am, I'm not blind — I can see exactly what broke and 
where.

## What I used

- Terraform — built the VPC, subnets, IAM roles, EKS cluster 
  and node group from scratch
- Helm — deployed the full monitoring stack in one command
- Prometheus — scrapes and stores metrics from every node and pod
- Grafana — visualises everything in real time
- kube-prometheus-stack — comes pre-packaged with 20+ Kubernetes 
  dashboards out of the box
- AWS EKS — managed Kubernetes running in eu-west-2
- Two availability zones — eu-west-2a and eu-west-2b for high 
  availability

## Project structure

eks-monitoring/
└── terraform/
├── providers.tf
├── variables.tf
├── backend.tf
├── main.tf
├── eks.tf
├── outputs.tf
└── dev.tfvars

## How to run it

```bash
# Build the infrastructure
cd terraform
terraform init
terraform apply -var-file="dev.tfvars"

# Connect kubectl
aws eks update-kubeconfig --name eks-monitoring-cluster \
  --region eu-west-2

# Add Helm repo
helm repo add prometheus-community \
  https://prometheus-community.github.io/helm-charts
helm repo update

# Create the monitoring namespace
kubectl create namespace monitoring

# Deploy the stack
helm install monitoring \
  prometheus-community/kube-prometheus-stack \
  --namespace monitoring

# Open Grafana
kubectl --namespace monitoring port-forward \
  svc/monitoring-grafana 3000:80

# Then go to http://localhost:3000 — username: admin
```

## What I learned

- Helm makes complex Kubernetes deployments clean — the whole 
  monitoring stack goes up in one command, everything pre-wired
- Namespaces keep things organised — monitoring lives in its own 
  space separate from everything else
- Prometheus needs proper RAM — t3.micro wasn't enough, moved to 
  t3.small and it ran clean. Always size your nodes for the 
  actual workload
- node-exporter runs as a DaemonSet — one pod per node 
  automatically, every node gets monitored without any 
  extra config
- Real observability means you stop guessing when things break 
  and start knowing

## Honest notes

I kept nodes in public subnets to avoid the NAT Gateway cost 
(roughly $32/month). In a real production setup nodes would sit 
in private subnets behind a NAT Gateway — that's the secure way 
to do it and I'd implement it properly on the job.