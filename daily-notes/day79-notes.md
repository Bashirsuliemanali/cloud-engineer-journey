Day 79

Project 4 done today. Alhamdulillah.

Provisioned a fresh EKS cluster using Terraform with t3.small 
nodes across eu-west-2a and eu-west-2b. The reason for t3.small 
over t3.micro is simple — Prometheus needs the RAM. Learned that 
the hard way, t3.micro wasn't cutting it.

Installed Helm and added the prometheus-community repo. Deployed 
the full kube-prometheus-stack into its own monitoring namespace 
with one command. That's the power of Helm — one line and the 
whole stack is up, pre-wired, ready to go.

Connected kubectl to the cluster, created the monitoring 
namespace to keep everything isolated, and watched all 7 pods 
come up healthy — Prometheus, Grafana, Alertmanager, 
kube-state-metrics, node-exporter on both nodes.

Opened Grafana in the browser. Logged in and went straight to 
the Kubernetes / Compute Resources / Cluster dashboard. Saw the 
live data — CPU at 2.39%, memory at 41.7%, both namespaces 
showing pods and workloads in real time. That's my cluster being 
monitored live on AWS.

Key thing I took from today — observability is what separates 
someone who builds infrastructure from someone who runs it. 
Anyone can spin up a cluster. Not everyone can tell you if it's 
healthy at 3am without logging in.