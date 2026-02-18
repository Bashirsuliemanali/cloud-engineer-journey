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

module "ec2" {
  source = "./modules/ec2"

  name              = "bashir-web-dev"
  ami               = var.ami
  instance_type     = var.instance_type
  key_name          = aws_key_pair.this.key_name
  security_group_id = aws_security_group.web_sg.id
  subnet_id         = module.vpc.public_subnet_a_id
}

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

resource "aws_lb_target_group_attachment" "web_attach" {
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = module.ec2.instance_id
  port             = 80
}