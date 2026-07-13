# Day 57 – Break-Glass Changes & Zero-Downtime Mindset

Today was about handling risky changes safely instead of rushing.

I learned how “break-glass” should work in real teams:
you temporarily relax a guardrail only for a specific, reviewed reason,
then you re-enable protections immediately after.

I deployed the web stack again (VPC + ALB + ASG + CloudWatch alarms),
verified the target health was HEALTHY, and confirmed nginx was reachable
through the ALB DNS.

Key lessons:
- Guardrails like `prevent_destroy` are there to stop expensive mistakes.
- If you need to destroy, the correct workflow is: PR then reviewed plan then manual approval then apply.
- `create_before_destroy` is used to reduce downtime when replacement is needed,
  but it does not replace good planning.
- Terraform commands don’t need memorising — engineers use patterns + references,
  but they must understand the impact (replace vs update vs destroy).

Todays outcome: I’m getting better at slowing down, reading plans, and thinking like production.