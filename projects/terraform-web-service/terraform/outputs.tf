output "alb_dns_name" {
  value = aws_lb.web_alb.dns_name
}

output "alb_url" {
  value = "http://${aws_lb.web_alb.dns_name}"
}

output "asg_name" {
  value = aws_autoscaling_group.web_asg.name
}