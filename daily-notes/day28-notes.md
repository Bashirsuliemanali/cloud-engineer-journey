# Day 28 – Refactoring Terraform Safely

Today I learned how Terraform tracks resources using their resource type and name, not just the underlying infrastructure. Renaming a resource in code without handling state causes Terraform to think the old resource was deleted and a new one needs to be created.

I learned that refactoring should be done by moving state instead of recreating infrastructure. Using "terraform state mv" allows Terraform to keep track of existing resources even when names or structure change.

This is critical in real environments because refactors happen often, and destroying live infrastructure accidentally can cause outages.

The main lesson today is that refactoring Terraform must be deliberate, and state should be updated carefully to reflect code changes.