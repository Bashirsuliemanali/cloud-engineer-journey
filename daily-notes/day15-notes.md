# Day 15 – Terraform destroy discipline & environment control

Today I focused on infrastructure lifecycle control, not just creation.

## What I did
- Verified I was in the dev Terraform workspace
- Destroyed the entire dev environment using terraform destroy
- Confirmed all resources were removed cleanly

## Why this matters
- Infrastructure should be reproducible, not permanent
- Destroying via Terraform keeps state consistent
- This avoids cloud cost leaks and manual cleanup

## Key takeaway
If I can destroy it safely, I can always recreate it.
That’s real infrastructure-as-code discipline.