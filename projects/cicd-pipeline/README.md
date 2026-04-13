# CI/CD Pipeline — Automated Deployment to EKS

A fully automated CI/CD pipeline that builds, containerises and deploys 
a Python Flask application to AWS EKS using GitHub Actions.

Every push to main triggers the pipeline automatically. Zero manual steps.

## What This Project Does

- Builds a Docker image from a Python Flask app
- Pushes the image to AWS ECR automatically
- Authenticates to AWS using OIDC — no hardcoded credentials anywhere
- Deploys the updated image to an EKS cluster via kubectl
- Full pipeline runs in under 2 minutes from push to live

## Architecture

Push to GitHub triggers GitHub Actions.
GitHub Actions builds a Docker image and pushes it to ECR.
kubectl then updates the EKS deployment with the new image.
App is live automatically. Zero manual steps.

## Stack

- **Python + Flask** — lightweight web app
- **Docker** — containerises the app
- **AWS ECR** — stores container images
- **AWS EKS** — runs the containerised app
- **GitHub Actions** — orchestrates the full pipeline
- **Terraform** — provisions ECR and IAM infrastructure
- **OIDC** — secure AWS authentication, no static credentials

## Project Structure

```
cicd-pipeline/
├── app.py
├── Dockerfile
├── terraform/
│   ├── main.tf
|   ├── iam.tf        
│   ├── outputs.tf
│   ├── variables.tf
│   ├── backend.tf
│   ├── providers.tf
│   └── dev.tfvars
└── .github/
    └── workflows/
        └── deploy.yml
```

## How It Works

### OIDC Authentication
GitHub Actions never stores AWS credentials. Instead it uses OIDC to 
request temporary credentials at runtime. AWS verifies the request came 
from my specific repository before issuing credentials. Secure by design.

### Pipeline Steps
1. Checkout latest code
2. Authenticate to AWS via OIDC
3. Login to ECR
4. Build Docker image tagged with commit SHA
5. Push image to ECR
6. Update kubeconfig to connect kubectl to EKS
7. Deploy new image to running deployment

### Rolling Updates
Kubernetes replaces pods one at a time during deployment. 
The app stays live throughout. Zero downtime.

## Key Learnings

**OIDC over static credentials** — never store AWS access keys in GitHub. 
OIDC issues temporary credentials per pipeline run. If they leak they're 
already expired.

**Commit SHA tagging** — every image is tagged with the Git commit SHA. 
Full traceability — I can always tell exactly which code is running in 
production.

**t3.micro pod limits** — each t3.micro node supports maximum 4 pods. 
In production use larger instance types to avoid capacity issues during 
rolling updates.

**EKS access entries** — GitHub Actions needs explicit cluster access via 
EKS access entries. IAM permissions alone aren't enough to run kubectl 
commands against a cluster.

## What I'd Add in Production

- Automated tests before the build step — fail fast on broken code
- Image vulnerability scanning gate — block deployment if critical CVEs found
- notifications on pipeline success and failure
- Separate staging and production environments
- Helm charts instead of raw kubectl for deployment management