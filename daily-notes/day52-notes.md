# Day 52 – PR Plan Workflow & Manual Approval Gate

Today I extended the CI setup to simulate a real production workflow.

## What Was Added
	1.	A Terraform Plan workflow that runs on Pull Requests.
	2.	A Manual Apply workflow protected by a GitHub Environment.
	3.	Required reviewer approval before deployment.

The plan workflow runs automatically when a PR is opened and shows infrastructure changes before merge.

The apply workflow does not auto-run. It requires manual triggering and environment approval.

## What the Approval Gate Does:

The GitHub Environment pauses execution and requires a human reviewer to approve or reject the deployment.

## This prevents:
	-	Accidental applies
	-	Destructive changes
	-	Unreviewed infrastructure updates

When I rejected the deployment, the workflow stopped immediately.

This simulates how production systems are protected in real engineering teams.

## Key Distinction
	-	CI ensures code correctness.
	-	Plan ensures change visibility.
	-	Environment approval ensures change control.

Automation handles structure.
Humans handle judgment.

## Lessons Learned
	-	Production safety is layered.
	-	Apply should never be automatic without strict controls.
	-	Infrastructure discipline comes from process, not speed.
	-	Approval gates reduce blast radius risk.