# Day 10 – Terraform user-data & Immutable Infrastructure

Today was about doing things the right way with Terraform.

The goal was to make sure an EC2 instance comes online already configured, without me having to SSH in and manually install anything. I used Terraform user-data to automatically install and start nginx when the instance boots.

At first, nginx didn’t show up even though Terraform said everything matched the configuration. After debugging properly, I learned that user-data only runs on the first boot of an instance. Because the instance already existed, cloud-init had already finished and the script never ran.

The correct fix wasn’t to force it or keep SSH’ing in — it was to destroy and recreate the instance so Terraform could apply the configuration from a clean state. Once I did that, nginx loaded immediately in the browser without any manual setup.

This helped everything click.

## Key things I learned
- user-data runs once, on first boot
- Terraform state can say “no changes” even when reality doesn’t match expectations
- Sometimes destroy + recreate is the right solution, not a mistake
- This is what people mean by immutable infrastructure
- If infrastructure can’t be recreated automatically, it’s not really automated

By the end of today, I had a fully reproducible EC2 setup where one Terraform apply brings everything up exactly as expected.