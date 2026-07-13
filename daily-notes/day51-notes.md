# Day 51 – Terraform CI (Safe Automation Guardrails)

Today I introduced Continuous Integration (CI) into my Terraform project using GitHub Actions.

The goal was not deployment — it was protection.

What the CI pipeline runs
 - terraform init -backend=false
 - terraform fmt -check -recursive
 - terraform validate

The backend is intentionally disabled in CI to ensure the workflow does not touch real infrastructure or remote state.

## Why this matters

CI protects the codebase automatically.
	-	terraform fmt -check prevents inconsistent formatting.
	-	terraform validate blocks invalid configurations from merging.
	-	PRs are automatically marked red if checks fail.

This removes human error from the process and enforces discipline before changes reach main.

## Important Distinction
	-	terraform validate checks syntax and configuration structure.
	-	It does NOT evaluate infrastructure impact.
	-	That is the job of terraform plan.

For example:
Removing a security group rule for HTTP is valid Terraform syntax — but dangerous infrastructure logic. Validate would pass. Plan would show the change. Humans interpret impact.

## Key Lessons
	-	Automation protects teams from invalid config entering main.
	-	CI should be safe by default.
	-	Remote backends must be protected in automation.
	-	Formatting and validation are foundational guardrails.
	-	Calm debugging is part of engineering discipline.