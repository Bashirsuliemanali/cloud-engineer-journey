## Day 44 — Proper Dev / Prod Setup

# Why dev and prod should never be identical

Dev and prod exist for different purposes.
Dev is where learning, testing, and iteration happen. Mistakes are expected there.
Prod is the final, trusted environment where real infrastructure lives and where downtime, mistakes, or replacements have real consequences.

If dev and prod were identical, every developer would effectively have the ability to break production. That leads to outages, corrupted infrastructure, and unnecessary costs. Environment separation protects production from human error.

# What belongs in prod but not in dev

Production environments require:
	•	Bigger instance sizes (real traffic needs more resources)
	•	Stricter security group rules (limited SSH access)
	•	Stronger safety guardrails (like prevent_destroy)

Dev environments should stay lightweight, flexible, and easy to destroy. Prod prioritises stability over convenience.


# Why prevent_destroy belongs in the root

The root configuration represents control and authority.
This is where senior-level decisions live.

Modules are reused and touched by developers frequently. If safety rules live inside modules, they become easier to bypass or accidentally break. Guardrails should be enforced above modules, not inside them.

Keeping prevent_destroy in the root ensures:
	•	Clear ownership
	•	Predictable behaviour
	•	No accidental bypassing of safety rules

# Why environment separation is about people, not technology

Terraform itself is neutral—it does exactly what it’s told.

The real risk comes from people:
	•	rushing changes
	•	applying without reviewing plans
	•	making console changes that cause drift

Environment separation limits who can do what and where.
Senior engineers review and approve production changes not because they’re smarter, but because they’ve learned the cost of mistakes.

This is about trust, responsibility, and reducing blast radius—not about tools.