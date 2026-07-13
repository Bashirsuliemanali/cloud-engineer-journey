# Day 33 – Python Reading Terraform Outputs

Today I used Python to read Terraform outputs in a clean DevOps style workflow. I exported Terraform outputs as JSON using "terraform output -json" and saved it to a file so other tools/scripts can consume it.

At first my outputs file was empty because there were no resources tracked in state, so Terraform had nothing to output. After applying infrastructure, outputs appeared as expected.

I also learned to be careful with IP variables and CIDR formatting. My Terraform security group code already adds "/32", so the variable should be the raw IP only. Once fixed, the plan and apply worked cleanly.

The key takeaway is that Python is useful in DevOps because it can glue tools together and automate passing values between systems, like Terraform outputs into scripts or CI pipelines.