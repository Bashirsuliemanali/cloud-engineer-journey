# Day 4 - S3 Fundamentals 

## What is S3?
S3 is an object storage service provided by AWS that allows you to store and retrieve files such as media, logs, backups, and static website content.

## How S3 is different from EC2
S3 is a storage service, not a virtual computer. You cannot SSH into S3 or run applications on it like EC2. EC2 is used to run software, while S3 is used to store data securely and durably.

## What is a bucket?
A bucket is a top-level container in S3 used to store objects such as files, media, static website content, logs, and data.

# Are S3 buckets public by default?
No. S3 buckets are private by default. Objects and buckets only become public if access is explicitly configured by the user. This prevents accidental data exposure.