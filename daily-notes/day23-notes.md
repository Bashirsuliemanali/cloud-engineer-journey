# Day 23 – Terraform Modules Done Properly

Today I focused on understanding Terraform modules properly and how they should be structured in a team environment.

I learned that modules should own their resources and expose only what is needed through outputs, instead of the root module reaching directly into resources. This makes the code cleaner, easier to reuse, and safer to maintain as the project grows.

I updated the root outputs to reference the module output instead of the EC2 resource directly, which helped reinforce the separation between interface and implementation.

This made it clearer how root modules act as the entry point for humans and environments, while child modules act as reusable building blocks managed by the team.