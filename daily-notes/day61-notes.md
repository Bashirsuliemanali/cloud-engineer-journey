# Day 61 – Custom Domain, HTTPS, and ACM on AWS

## Focus of the Day

Today was focused on turning the Terraform AWS web service into a more production ready deployment by adding:

- custom domain routing
- HTTPS with ACM
- ALB TLS termination
- HTTP to HTTPS redirect
- Cloudflare DNS integration

This was the day the project moved from “working infrastructure” to a real internet facing deployment pattern.

## What Was Implemented

### 1. Custom Domain Routing
The application was connected to a real custom domain:

- `bashircloud.com`
- `www.bashircloud.com`

Traffic flow became:

Cloudflare DNS  
→ AWS Application Load Balancer  
→ Target Group  
→ Auto Scaling Group  
→ EC2 running nginx

### 2. ACM Certificate
A public certificate was requested in **eu-west-2 (London)** using AWS Certificate Manager.

Domains covered:
- `bashircloud.com`
- `www.bashircloud.com`

Validation method:
- DNS validation

ACM validation CNAME records were added in Cloudflare and the certificate status changed to:

- `Issued`


### 3. HTTPS Listener Added to ALB
A new ALB listener was added on port `443` using the ACM certificate.
This allowed the load balancer to terminate TLS and serve the application securely over HTTPS.

### 4. HTTP Redirect to HTTPS
The existing HTTP listener on port `80` was updated.
Instead of forwarding traffic directly to the target group, it now performs a redirect:

- HTTP → HTTPS
- Status code: `301`


### 5. Security Group Update
The ALB security group was updated to allow inbound traffic on:

- port `80`
- port `443`

This made secure web access possible.

## Verification Performed

The following checks were completed successfully:

```bash
curl -I http://bashircloud.com
curl -I https://bashircloud.com
curl -I https://www.bashircloud.com
```
## Results:
-	http://bashircloud.com → 301 Moved Permanently
-	https://bashircloud.com → 200 OK
-	https://www.bashircloud.com → 200 OK

This confirmed that:
-	DNS was working
-	HTTPS was live
-	redirect behaviour was correct
-	nginx was reachable through the full production path

## Problems Faced

1. Wrong ACM Region

The certificate was initially being requested in the wrong AWS region.

Key lesson:
	•	ALB certificates must be created in the same region as the load balancer
	•	CloudFront certificates are the ones that use us-east-1

For this project, ACM had to be requested in:
	•	eu-west-2

2. DNS Confusion Between Cloudflare and Route53

The project used Cloudflare DNS in front of AWS.

Key lesson:
	•	Cloudflare remained the DNS authority
	•	Route53 records alone would not fix resolution unless nameservers were delegated
	•	For this setup, Cloudflare CNAME records were the active DNS layer

3. ALB Recreation Changed DNS Name

After destroying and recreating infrastructure, the ALB DNS hostname changed.
This required manually updating the Cloudflare root record to point to the new ALB hostname.

Key lesson:
	•	ALB DNS names are not stable across destroy/recreate cycles
	•	manual DNS updates are acceptable for learning
	•	long-term automation will be needed later

4. Local DNS Cache Confusion

At one point:
	•	browser worked
	•	dig worked
	•	curl failed with Could not resolve host

This turned out to be local DNS / resolver inconsistency.
DNS flush helped:
```bash 
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
```

## Key Lessons Learned
	•	HTTPS on AWS ALB requires ACM in the same region as the ALB
	•	Cloudflare DNS and Route53 are different layers and must not be confused
	•	DNS debugging requires separating:
	     •	resolver issues
	     •	authoritative DNS issues
	     •	origin infrastructure issues
	•	ALB DNS changes on recreation, so external DNS must be updated if not automated
  •	Production web infrastructure should always redirect HTTP to HTTPS

## Architecture Achieved

Final working architecture for the day:

Cloudflare DNS
      - AWS ALB (HTTP redirect + HTTPS listener)
      - Target Group
      - Auto Scaling Group
      - EC2
      - nginx

## Personal Reflection

This was one of the most real world days so far.

It involved:
	•	DNS
	•	certificates
	•	HTTPS
	•	redirect behaviour
	•	cloud debugging
	•	resolver issues
	•	ALB lifecycle awareness

The project now feels much closer to a true production deployment rather than a simple Terraform lab.
