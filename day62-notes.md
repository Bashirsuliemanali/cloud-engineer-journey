# Day 62 – Root Cause Debugging, Baseline Recovery, and Clean `/health` Rollout

## Focus of the Day

Today was focused on recovering the project from a broken rollout, identifying the real root cause, restoring a known good baseline, and then reintroducing a proper `/health` endpoint in a controlled way.

The key theme of the day was:

- stop stacking assumptions
- return to a known good state
- verify one layer at a time
- only then roll forward

This was one of the most realistic debugging days so far.

## Starting Problem

The application had previously worked, but after making health endpoint and launch template changes, the deployment became unstable.

Symptoms included:

- `502 Bad Gateway` from the ALB
- targets stuck in `initial`, `draining`, or `unhealthy`
- long transition windows that were not acceptable for production style behaviour
- confusion between DNS, ALB, target group, ASG, and instance level causes

This forced a reset in approach.

## What Was Done

### 1. Reverted to Known Good Baseline
Before continuing with `/health`, the configuration was restored to the last stable version:

- nginx default homepage
- target group health check on `/`
- HTTPS and domain routing preserved
- no `/health` dependency during recovery

This allowed the stack to be rebuilt from a trusted baseline.

### 2. Rebuilt Infrastructure Cleanly
The full Terraform stack was recreated from clean state.

This included:

- VPC
- subnets
- security group
- ALB
- target group
- launch template
- Auto Scaling Group
- ACM-backed HTTPS listener
- Cloudflare DNS to ALB routing

The goal was to re establish a stable production baseline before further changes.

### 3. Isolated the Real Failure
Instead of continuing to guess, the problem was narrowed down layer by layer.

The process included:

- checking target health
- checking ASG instance state
- checking ALB direct response
- SSHing into the active instance
- checking `cloud-init`
- checking nginx service status
- checking localhost response on the instance itself

This proved the issue was not Cloudflare or the ALB.

The real issue was:

- the EC2 `user_data` script was malformed
- cloud-init script execution failed
- nginx was never installed or started on the new instance
- the ALB therefore had no healthy backend target

### 4. Fixed the `user_data` Script Properly
The heredoc formatting in Terraform was corrected.

The working version used a clean script structure so cloud-init could execute it correctly.

After fixing the script:

- `cloud-init status` returned `done`
- `nginx.service` was active and running
- `curl http://localhost/` returned `200 OK`

That restored the baseline.

### 5. Learned That Launch Template Changes Do Not Update Running ASG Instances
After adding `/health` to user data, the existing running instance still did not have the endpoint.

This revealed another important lesson:

- changing the launch template does **not** automatically replace the current ASG instance

To move forward cleanly:

- the current instance was manually terminated
- the Auto Scaling Group launched a new instance from the updated launch template
- the new instance was then tested directly

This was critical to getting the new `/health` endpoint onto a real running instance.

### 6. Added `/health` the Right Way
The `/health` endpoint was added in a controlled way by writing a direct file:

- endpoint path: `/health`
- expected body: `healthy`

Important detail:
- the health endpoint was verified on the instance itself **before** changing the target group health check

This avoided repeating the earlier mistake of changing ALB health checks before confirming the application path actually existed.

### 7. Switched Target Group Health Check to `/health`
Only after confirming the new instance returned a clean response on:

```bash
curl http://localhost/health
```
was the target group updated from:	`•	/`
to: `•	/health`

After apply, target health returned to:
`healthy`

This confirmed the endpoint and load balancer health checks were aligned correctly.

### Final Verification

The following was successfully confirmed:

Instance level verification
-	cloud-init status = done
-	nginx.service = active
-	curl -I http://localhost/health = 200 OK
-	curl http://localhost/health = healthy

Load balancer verification
-	target group showed the live target as healthy
-	ALB direct checks returned valid responses

### Public verification
```bash
curl -I https://bashircloud.com/health
curl https://bashircloud.com/health
```
Results:
-	200 OK
-	body = healthy

This confirmed the entire public path was working:
Cloudflare DNS
- AWS ALB
- Target Group
- Auto Scaling Group
- EC2
- nginx
- /health

### Key Lessons Learned

1. Broken user_data formatting can silently break deployments

A small heredoc formatting issue in Terraform was enough to stop cloud-init from installing nginx properly.

2. Always verify the application locally before changing external health checks

The correct order is:
- verify app path on instance
-	verify instance behavior
-	then update ALB / target group checks

3. Launch template changes do not automatically refresh existing instances

An updated launch template does not mean the running instance is updated.
A new instance must actually be launched from that template.

4. Debugging should move layer by layer

The clean order is:
- instance
-	target group
-	load balancer
-	domain
-	external client

Not all at once

5. Production thinking means rejecting long bad gateway windows. A rollout that eventually heals is not automatically good enough. User facing downtime still matters and should be minimized.

### Architecture at End of Day

Final verified architecture:

Cloudflare DNS
- HTTPS on ALB via ACM
- Target Group health check on /health
- Auto Scaling Group
- EC2 with nginx
- public /health endpoint returning healthy

### Personal Reflection

This was one of the most important engineering days so far.

Not because of a new feature, but because it forced:
-	discipline
-	patience
-	layer by layer debugging
-	recovery to a known good baseline
-	controlled forward change

Today reinforced an important principle to me:

A clean recovery and correctly verified rollout is better than rushing changes into a broken stack.
