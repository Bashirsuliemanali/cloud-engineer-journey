# Day 39 – How Terraform Decides Create, Update, or Replace

Today I learned how Terraform decides what actions to take. Terraform compares three things: the configuration files, the state file, and the provider schema. The provider schema defines what AWS allows to be changed in place and what requires replacement.

Changing certain attributes, like an AMI, forces replacement because AWS does not allow them to be updated on an existing instance. Terraform follows these rules rather than guessing or trying unsafe changes.

State drift can make Terraform plans look dangerous because Terraform’s state no longer matches reality. When this happens, Terraform plans changes to reconcile the difference, which can include unexpected replacements or deletions.

Terraform is not wrong when it plans replacement. It follows the provider rules and the current state exactly. If no guardrails prevent replacement, Terraform chooses replacement as the correct path to reach the desired configuration.