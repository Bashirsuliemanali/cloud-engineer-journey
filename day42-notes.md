## Day 42 – Apply & Destroy Discipline 

# Why should you always check plan before apply?
Because plan shows exactly what Terraform is about to do. If you skip it, you’re applying blind and risking deletes, replacements, or costs you didn’t intend.

# What do green (+) and red (-) mean in plan?
Green (+) means Terraform will create resources.
Red (-) means Terraform will destroy resources.
Seeing only green before apply is usually safe. Red means slow down and read carefully.

# Why is apply meant to feel boring?
If plan was reviewed properly, apply should be calm and predictable. Boring apply means no surprises, no panic, no damage.

# Why should you verify resources after apply?
Because Terraform success doesn’t always mean the service works. You still need to check:
	•	Instance is running
	•	Public IP works
	•	nginx actually loads

Reality is better than assumptions.

# Why must destroy also be planned?
Destroy can be just as dangerous as apply. Running plan before destroy confirms only the intended resources (EC2, SG, key pair) are being removed and nothing extra.

# What professional habit was reinforced today?
Terraform isn’t about speed.
It’s about:
	•	Reading plans
	•	Verifying outcomes
	•	Destroying intentionally
	•	Keeping costs and risk under control

This is how real teams operate in production.