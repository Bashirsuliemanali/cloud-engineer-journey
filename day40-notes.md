# Day 40 – Terraform Mindset Shift

Since Day 1, my mindset around Terraform has changed significantly. I now slow down and read plans properly instead of assuming that correct code will always behave as expected. I’ve adopted a “why is this happening?” approach, which helps me understand Terraform rather than react to it. Terraform plan feels like a safety net — as long as I use it, I’m not guessing.

A boring apply is a good sign because it means there are no surprises. The plan has already been reviewed and understood, so apply becomes calm and predictable rather than stressful.

Before running apply, I now ask whether anything changed that I didn’t intend, what the blast radius looks like, and whether any downtime would be acceptable. I think about the wider system impact instead of focusing only on completing my own task.

I’m also much less likely to make mistakes like running blind applies. Using fmt, validate, and plan consistently has made precaution part of my workflow, and I now see it as a strength rather than a slowdown.