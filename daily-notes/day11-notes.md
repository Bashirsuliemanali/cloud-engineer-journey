# Day 11 – Terraform tidy up (variables + outputs) + lock down SSH

Today was about cleaning up my Terraform project so it looks like real-world code, not just “it works”.

## What I changed
- I moved the public IP output out of main.tf into outputs.tf.
- I added variables in variables.tf so I’m not hardcoding everything in one file:
  - region
  - instance_type
  - my_ip
- I updated main.tf to use variables instead of fixed values.

## Security upgrade (big!)
Before, SSH was open to the whole internet (0.0.0.0/0).  
I changed it so only my public IP can SSH in:

- SSH (22) → "${var.my_ip}/32"
- HTTP (80) stays open so the nginx page loads

This is way more realistic and safer.

## Result
- Terraform plan showed: "0 to add, 1 to change, 0 to destroy"
- Apply updated only the security group rule
- Instance stayed up, nginx still loads, and the output IP prints cleanly.

## Key lessons
- main.tf is the blueprint, variables make it flexible
- outputs should live in outputs.tf
- always run terraform plan before apply
- locking SSH to your IP is basic security hygiene