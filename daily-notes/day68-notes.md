1st April 2026
Came back after a month off. Did a full diagnostic to see where I was at. Networking and IAM were rusty but the core logic was still there — just needed sharpening.
Cleared out the old project. Started completely fresh. Every line typed by me, explained to me. That's the standard from here.
What I actually understand now:
Remote state — S3 holds the state file, DynamoDB stops two people pushing at the same time and corrupting everything. Different projects use the same bucket but different keys so they stay isolated.
Public vs private subnet — the only difference is the route table. Public has a route to the Internet Gateway. Private doesn't. That's it.
IAM — a policy is the permission slip, a role is the identity that holds it, a trust policy controls who can assume that role. STS issues temporary credentials when something assumes a role.
EKS needs two roles. The cluster role is assumed by EKS itself to manage AWS resources. The node role is assumed by EC2 because the worker nodes are EC2 instances. Mix those up and nothing works.
What I built:

providers.tf — AWS provider, version locked to 5.x
variables.tf — region, project name, environment
backend.tf — remote state pointing to S3, DynamoDB locking, encrypted
iam.tf — cluster role and node role, all four policy attachments

Tomorrow:
terraform init then terraform plan. First time running this against real AWS. Then networking.