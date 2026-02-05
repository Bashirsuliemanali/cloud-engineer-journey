# Day 27 – Terraform State (Why It’s Sacred)

Today I learned why Terraform state is critical and why teams treat it as sacred. State is Terraform’s memory of what already exists in the real world, and it’s used to safely calculate what needs to change.

Without state, Terraform becomes blind and can attempt to recreate or destroy infrastructure incorrectly. This can cause outages, data loss, or unexpected costs.

I also learned why remote state is essential in team environments. S3 is used to store the state file safely and durably, while DynamoDB is used for state locking so only one apply can happen at a time.

The key lesson is that Terraform state should never be edited manually, never committed to Git, and must always be protected because it controls how infrastructure changes are applied.