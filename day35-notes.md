# Day 35 – Terraform Guardrails Done Properly

Today I learned the right way to think about Terraform guardrails. A key lesson is that shared modules should stay reusable and environment-agnostic. Modules should not enforce production only rules because that makes them harder to reuse across dev/test/prod and can block normal workflows.

I also learned that lifecycle settings like "prevent_destroy" need to be deterministic during planning, so Terraform expects them to be predictable. The best place for production safety is at the root/environment layer and enforced by workflow controls like protected branches and approval gates in CI/CD.

Another key takeaway is that blocking destroy in the wrong place can backfire, because teams may bypass Terraform using manual console changes, which creates drift and increases risk. Guardrails should protect production without breaking normal dev workflows.