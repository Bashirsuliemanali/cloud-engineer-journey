Big day. Infrastructure went live for the first time on the clean project.
Wrote outputs.tf — learned that outputs expose useful values after apply like VPC ID, subnet IDs and role ARNs. These will be referenced when i build the EKS cluster and node group next.
Ran terraform apply — 18 resources created in AWS. Zero errors. Verified the outputs came back with real AWS IDs — VPC ID, subnet IDs, role ARNs all confirmed.
Also learned that in a real job you'd run terraform apply -var-file="dev.tfvars" instead of relying on defaults. Next session i will add dev.tfvars to match real world practice.
Went into AWS console and verified every resource is live — VPC, subnets, IGW, route tables, IAM roles. 