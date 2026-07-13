# Day 29 – Terraform Drift Detection

Today I learned what infrastructure drift is and why it happens. Drift occurs when real infrastructure changes outside of Terraform, such as manual updates in the AWS console or automated changes.

Terraform detects drift during terraform plan by refreshing real resources and comparing them against the state file and configuration. Even if no code changes were made, terraform plan can still show differences caused by drift.

Drift is dangerous because it reduces trust in infrastructure as code and can lead to unexpected changes during apply. This is why teams restrict manual changes and treat Terraform as the single source of truth.

The key lesson today is that drift should be detected, reviewed carefully, and resolved deliberately rather than ignored.