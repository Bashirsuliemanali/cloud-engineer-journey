# Day 55 — Manual Approval for Prod Apply (GitHub Environments)

Today I set up a production style Terraform workflow where apply is never automatic.

The pipeline now runs in this order:
	1.	fmt + validate (code quality)
	2.	plan (shows exactly what will change)
	3.	Manual approval gate using GitHub Environments
	4.	apply only after approval

The key lesson:
Production safety is about people and process, not just Terraform.
Even perfect code can be dangerous if it’s applied at the wrong time or without review.

What I check before approving a prod apply
- The plan has no unexpected destroys/replacements and matches the intended change.
- The change is actually needed for prod.
- The workflow is clean - checks passed, correct workspace/env, correct tfvars, backend/locking ok.