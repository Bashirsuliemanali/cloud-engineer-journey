# S3 Static Website – Day 4

## Overview
This project shows how to host a simple static website using Amazon S3.  
The goal was to understand how S3 works, how public access is controlled, and how AWS handles security by default.

The website is live and publicly accessible using an S3 website endpoint.
## Live Website
🔗 http://bashir-cloud-day4-static-site.s3-website.eu-west-2.amazonaws.com

## What I Built
- An Amazon S3 bucket in the London region (eu-west-2)
- A basic HTML page hosted directly from S3
- Static website hosting enabled
- Public read access configured securely using a bucket policy

## Architecture
- Amazon S3 bucket
- Static website hosting
- Bucket policy allowing public Get Object access only

No servers, no EC2, no SSH — just object storage doing what it’s designed for.

## Key Concepts Learned
- S3 is object storage, not a virtual machine
- Buckets are private by default
- Public access must be explicitly allowed
- Bucket policies control who can do what
- Static websites on S3 require public read permissions to work

## Security Considerations
- The bucket started private by default
- Public access was enabled intentionally
- The bucket policy allows read-only access 
- No write, delete, or admin permissions are exposed

This keeps the setup simple while avoiding unnecessary risk.

## Outcome
The website is accessible via the S3 website endpoint and serves static content correctly.This project helped me understand how AWS handles storage, permissions, and public access in a real world scenario.

## Screenshot
![S3 Static Website Live](site-live.png)