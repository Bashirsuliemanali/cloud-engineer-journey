# Day 53 — CI Guardrails (fmt + validate)

Today I set up a safe Terraform CI workflow that runs automatically on GitHub Actions.

The pipeline performs:
	-	terraform fmt -check
	-	terraform validate
	-	terraform init in CI mode 

This is important because CI should block broken infrastructure code before it reaches main.
Validation doesn’t catch “bad architecture decisions”, but it does catch invalid Terraform configuration that would break deployments.

## Key takeaway
CI is a safety net for teams, it prevents mistakes early and makes infra changes more reliable.