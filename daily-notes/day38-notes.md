# Day 38 – Predicting Terraform Changes Before Plan

Today I learned that Terraform only ever performs four actions: no-op, in-place update, create, or replace. Understanding which action will happen is critical because replacement is the most dangerous and has the highest blast radius.

I learned that small-looking changes can cause replacement. For example, changing an AMI or renaming a resource often forces Terraform to destroy and recreate infrastructure because it treats the change as a new object.

Predicting Terraform behaviour before running "terraform plan" is a senior-level habit. Plan should confirm what you already expect, not surprise you. If a plan shows something unexpected, that’s a signal to stop and investigate.

If Terraform plan reveals changes I didn’t intend, the correct response is to slow down, read the plan carefully, and avoid applying. High blast radius changes should be reviewed or escalated rather than rushed, because unexpected infrastructure changes can lead to downtime, cost, and security issues.