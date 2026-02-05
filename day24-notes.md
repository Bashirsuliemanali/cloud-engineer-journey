# Day 24 – Terraform Workspaces & Environments

Today I learned how Terraform workspaces are used to separate environments like dev and prod without changing the actual code. The same Terraform configuration can be reused, but each workspace keeps its own state file.

I’m currently working in the "dev" workspace, which means all resources and state belong only to that environment. This prevents accidents like changing or deleting production infrastructure while testing.

I also updated resource naming to include the workspace using terraform.workspace, so it’s always clear which environment a resource belongs to.

The main lesson today was that workspaces change state, not code, and environment separation is essential for safe infrastructure management.