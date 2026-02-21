provider "aws" {
  region = var.region
}

resource "aws_key_pair" "this" {
  key_name   = "bashir-web-dev-key"
  public_key = file(var.public_key_path)
}

module "vpc" {
  source = "./modules/vpc"

  name = "bashir-web"

  vpc_cidr = "10.0.0.0/16"

  public_subnet_a_cidr = "10.0.1.0/24"
  public_subnet_b_cidr = "10.0.2.0/24"

  availability_zone_a = "eu-west-2a"
  availability_zone_b = "eu-west-2b"
}

resource "aws_security_group" "web_sg" {
  name        = "bashir-web-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bashir-web-sg"
  }
}

/*
module "ec2" {
  source = "./modules/ec2"

  name              = "bashir-web-dev"
  ami               = var.ami
  instance_type     = var.instance_type
  key_name          = aws_key_pair.this.key_name
  security_group_id = aws_security_group.web_sg.id
  subnet_id         = module.vpc.public_subnet_a_id
}
*/

resource "aws_lb_target_group" "web_tg" {
  name     = "bashir-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb" "web_alb" {
  name               = "bashir-web-alb"
  internal           = false
  load_balancer_type = "application"

  subnets = [
    module.vpc.public_subnet_a_id,
    module.vpc.public_subnet_b_id
  ]
  security_groups = [aws_security_group.web_sg.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

/*
resource "aws_lb_target_group_attachment" "web_attach" {
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = module.ec2.instance_id
  port             = 80
}
*/

resource "aws_launch_template" "web_lt" {
  name_prefix   = "bashir-web-lt-"
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.this.key_name

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = base64encode(<<EOF
#!/bin/bash
dnf update -y
dnf install -y nginx
systemctl enable nginx
systemctl start nginx
EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "bashir-web-asg"
    }
  }
}

resource "aws_autoscaling_group" "web_asg" {
  name             = "bashir-web-asg"
  min_size         = 1
  desired_capacity = 1
  max_size         = 2
  vpc_zone_identifier = [
    module.vpc.public_subnet_a_id,
    module.vpc.public_subnet_b_id
  ]

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.web_tg.arn]

  health_check_type         = "ELB"
  health_check_grace_period = 60

  tag {
    key                 = "Name"
    value               = "bashir-web-asg"
    propagate_at_launch = true
  }
}

resource "aws_cloudwatch_metric_alarm" "tg_unhealthy_hosts" {
  alarm_name          = "bashir-web-tg-unhealthy-hosts"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Average"
  threshold           = 0

  dimensions = {
    TargetGroup  = aws_lb_target_group.web_tg.arn_suffix
    LoadBalancer = aws_lb.web_alb.arn_suffix
  }

  alarm_description = "Triggers if any target becomes unhealthy in the target group."
}

resource "aws_cloudwatch_metric_alarm" "alb_5xx" {
  alarm_name          = "bashir-web-alb-5xx"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "HTTPCode_ELB_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Sum"
  threshold           = 0

  dimensions = {
    LoadBalancer = aws_lb.web_alb.arn_suffix
  }

  alarm_description = "Triggers if the ALB returns 5XX responses."
}