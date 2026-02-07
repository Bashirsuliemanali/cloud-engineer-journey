# Day 36 – Terraform Team Workflows & Plan-First Mindset

Today I learned that Terraform is less about deploying infrastructure and more about making informed decisions before anything changes. Terraform’s real power comes from "terraform plan", which shows what WILL happen so teams can act deliberately instead of reacting after something breaks.

I also learned why teams separate responsibilities between who writes Terraform code and who applies it. Many people can write infrastructure code, but applying changes to production requires experience, calm judgement, and accountability. This separation reduces risk, avoids panic decisions, and protects production environments.

Another key takeaway is why not everyone should be able to apply to production. If everyone has apply access, the risks increase significantly — including downtime, lost logs, state corruption, and unexpected costs. One wrong apply can affect customers and the business, not just the code.

Finally, I understood why plan review is more important than code review alone. Code review shows intent, but plan review shows reality. The plan is the final checkpoint before changes go live, making it the most important place to catch destructive or unexpected actions before they happen.

Overall, today reinforced that good Terraform usage is about slowing down, reviewing plans carefully, and treating infrastructure changes with the same discipline as production software.