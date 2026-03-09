# Day 63 – Observability Polish and Monitoring Story

## Focus of the Day

Today was focused on improving the project’s observability story.

The infrastructure was already working, but the goal was to make monitoring more complete and easier to explain from an operations point of view.

Instead of only checking whether the site was alive, the project now monitors:
- backend health
- user facing failures
- performance degradation

## What Was Added

A new CloudWatch alarm was added for:

- **TargetResponseTime**

This alarm triggers if average target response time becomes greater than 1 second.

This complements the existing alarms:

- **UnHealthyHostCount**
- **HTTPCode_ELB_5XX_Count**

Together, these now provide a cleaner production monitoring baseline.

## Monitoring Coverage

### 1. UnHealthyHostCount
Purpose:
Detect when backend targets become unhealthy.

What it helps catch:
- broken health checks
- nginx not running
- cloud-init / bootstrap failures
- rollout issues
- instance level service failures

### 2. HTTPCode_ELB_5XX_Count
Purpose:
Detect user facing ALB errors.

What it helps catch:
- no healthy targets
- failed backend registration
- bad rollout transitions
- target group failures seen by clients

### 3. TargetResponseTime
Purpose:
Detect when the service is still up but responding slowly.

What it helps catch:
- slow application response
- overloaded instances
- startup delays
- backend performance degradation

## Verification Performed

The infrastructure was redeployed and tested.

Verified successfully:

```bash
curl -I https://bashircloud.com
curl -I https://bashircloud.com/health
curl https://bashircloud.com/health
```
## Results:
-	root domain returned 200 OK
-	/health returned 200 OK
-	body returned healthy

This confirmed the application and health endpoint were both functioning correctly while observability was being improved.

## Operational Interpretation

The project now has a stronger monitoring story:
-	backend health alarm = is the target alive?
-	5XX alarm = are users seeing failures?
-	response time alarm = is the service becoming slow?

This is much more useful than only monitoring uptime.

## Troubleshooting Flow Learned

If these alarms trigger, the investigation path should be:

If unhealthy hosts alarm fires
-	check target group health
-	check health check path
-	check nginx status
-	check cloud-init / instance bootstrap

If ALB 5XX alarm fires
-	check whether there are healthy targets
-	inspect target draining / registration state
-	review recent rollout changes

If response time alarm fires
-	confirm service still returns 200
-	inspect instance load / startup behaviour
-	determine whether slowdown is temporary or sustained

## Key Lesson

Observability is not just “an alarm exists”

Good observability means:
-	knowing what the alarm measures
-	knowing what kind of failure it signals
-	knowing what the first debugging step should be

That turns monitoring into something operationally useful.

