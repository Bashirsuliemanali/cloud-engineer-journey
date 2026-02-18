output "instance_public_ip" {
  value = module.ec2.public_ip
}

output "alb_dns_name" {
  value = aws_lb.web_alb.dns_name
}

output "alb_url" {
  value = "http://${aws_lb.web_alb.dns_name}"
}