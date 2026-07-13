# Day 6 – CloudFront + Private S3 (Origin Access Control)

## Goal
Serve a static website securely via CloudFront while keeping the S3 bucket private.

## What I did
- Switched CloudFront origin from S3 website endpoint to S3 bucket endpoint
- Created and attached an Origin Access Control (OAC)
- Blocked all public access to the S3 bucket
- Updated S3 bucket policy to allow CloudFront access only
- Set default root object to `index.html`
- Created a CloudFront cache invalidation

## Result
- S3 direct access returns AccessDenied
- Website loads correctly via CloudFront HTTPS URL

## Key learnings
- Difference between S3 website endpoint vs bucket endpoint
- Why CloudFront returns 403 when permissions or root object are misconfigured
- How OAC secures S3 access in production setups