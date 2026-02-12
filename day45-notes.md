# Day 45 – IAM Discipline & Least Privilege Thinking

Today I shifted from “making infrastructure work” to thinking about access control and blast radius.

Instead of defaulting to AdministratorAccess, I focused on understanding why least privilege is critical in real environments.

Key lessons:
	•	AdministratorAccess removes all guardrails and increases blast radius.
	•	CI/CD pipelines should have dedicated machine roles with tightly scoped permissions.
	•	Human access and machine access should never be treated the same.
	•	Leaked access keys can silently compromise infrastructure.
	•	Temporary credentials are safer than long-lived static keys.
	•	Security must be part of infrastructure design from the beginning.

This day reinforced that Terraform engineering is not just about deployment — it is about responsible control.
