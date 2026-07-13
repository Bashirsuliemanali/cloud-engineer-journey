# Day 37 – Terraform Blast Radius & Safe Changes

Today I learned about blast radius in Terraform, which refers to how much damage a single change can cause. Even a small line of code can trigger major changes, which is why "terraform plan" is essential to understand the impact before applying anything.

I also learned that small changes can have big consequences because Terraform does exactly what you tell it to do. For example, renaming a resource can cause Terraform to destroy and recreate infrastructure, leading to downtime, increased costs, and potential reputation damage.

An example of a high blast-radius change is replacing a security group. This can force instance replacement or expose services, making applications unavailable or insecure.

Teams reduce risk by reviewing plans carefully, separating responsibilities between writing and applying changes, and having senior engineers review high-impact plans before they are applied. Slowing down and reviewing plans properly is how teams avoid unnecessary outages and mistakes.