# Day 56 — Protecting Production with prevent_destroy

## Objective
Introduce infrastructure guardrails to prevent accidental destruction of critical production resources.Today focused on strengthening production safety.

## What i implemented 
Added Terraform lifecycle protection to critical infrastructure resources:

- Application load balancer 
  file: projects/terraform-web-service/terraform/main.tf 

```hcl
lifecycle {
  prevent_destroy = true
}
```

- Auto scaling group 
  File: projects/terraform-web-service/terraform/main.tf

```hcl
lifecycle {
  prevent_destroy = true
}
```
- VPC
  File: projects/terraform-web-service/terraform/modules/vpc/main.tf

  ```hcl
lifecycle {
  prevent_destroy = true
}
```

Why this matters
In real world production systems:
- Accidental refactors can trigger destroy/recreate
- Misconfigured variables can cause forced replacement
- Junior engineers can unintentionally push destructive changes
-	Terraform plan diffs can hide blast radius inside larger changes

prevent_destroy forces Terraform to fail if a destroy is attempted on protected resources.Instead of silent downtime, the pipeline stops.

Production Mindset Learned

If destruction is truly required:
	1.	Create a break glass PR
	2.	Temporarily remove prevent_destroy on specific resources
	3.	Review the plan carefully
	4.	Require manual approval
	5.	Apply
	6.	Re-enable protections immediately

Never use terraform state rm for deletion, it only removes state and can orphan infrastructure.

Commands Used 

``` bash
terraform fmt -recursive
terraform validate
terraform fmt -recursive
terraform plan -var-file=dev.tfvars -var="my_ip=127.0.0.1/32"
```

Plan showed expected infrastructure creation due to fresh state:
`Plan: 16 to add, 0 to change, 0 to destroy`

Today's lessons:

1. Production safety > speed.
2. Guardrails are not optional.
3. They are part of responsible infrastructure engineering.
