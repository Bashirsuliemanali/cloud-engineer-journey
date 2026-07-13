# Day 26 – Terraform Production Guardrails

Today I learned how to add real production guardrails to Terraform instead of just making infrastructure work. I reinforced the habit of always running terraform plan before apply and treating apply as a deliberate action, not something done casually.

I added a lifecycle rule using "prevent_destroy = true" inside the EC2 resource to protect it from accidental deletion. This showed me how Terraform can intentionally block destructive actions and force you to slow down before making risky changes.

I also understood that guardrails live in the code itself, not in the workspace. This means the same protection applies across all environments unless explicitly designed otherwise.

The key lesson today is that production safety matters more than speed, and Terraform should be designed to protect infrastructure by default.