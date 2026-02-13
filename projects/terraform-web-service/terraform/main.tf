provider "aws" {
  region = var.region
}

resource "aws_key_pair" "this" {
  key_name   = "bashir-web-dev-key"
  public_key = file(var.public_key_path)
}

module "vpc" {
  source = "./modules/vpc"

  name               = "bashir-web"
  vpc_cidr           = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  availability_zone  = "eu-west-2a"
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
  subnet_id         = module.vpc.public_subnet_id
}