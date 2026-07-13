## Day 25 – Terraform Safety Questions Reflection

Today I was tested on why Terraform plan is a required step before apply. The main purpose of plan is to clearly show what changes will happen before anything is applied, giving you the chance to catch mistakes early and avoid accidental destruction.

If a CI/CD pipeline skipped the plan step, changes could be applied blindly. This can lead to outages, security risks, exposed resources, or deleted infrastructure without anyone realising until it’s too late.

Teams block terraform apply on the main branch because it usually represents production. Requiring approval ensures that an experienced engineer reviews the changes before they go live, reducing risk and keeping the system stable.

The key lesson is that Terraform is not just about creating infrastructure, but about managing risk and protecting production systems.