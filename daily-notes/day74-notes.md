First ever attempt at walking through the full project from memory without notes. Rusty but the logic was all there. Going to run the walkthrough every session this week until it's completely smooth by Friday 

Cleared up two concepts that were mixed up. The IGW is the front door to the VPC — allows traffic in and out. The Load Balancer is what distributes traffic across pods. Two different resources, two different jobs, easy to confuse but important to separate.

Analogies are locking concepts in faster than anything else. Security group is the nightclub bouncer. NAT Gateway is the one way mirror. Control plane is the manager, worker nodes are the chefs. These stick better than any definition for me. 

Wrote the project README — architecture overview, how to run it, key decisions and learnings, what I'd add in production. The NAT Gateway gap is documented honestly, it's a known trade off not an oversight.

Learned every item on the production improvements list and what each one does. OIDC and IRSA give individual pods their own temporary credentials instead of giving the whole node AWS access. Cluster autoscaler adds and removes nodes based on demand. ACM puts HTTPS on the LoadBalancer.
Project 2 is done. Built from scratch, understood line by line, documented properly.