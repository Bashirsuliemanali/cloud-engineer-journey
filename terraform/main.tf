terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}
resource "aws_security_group" "bashir_sg" {
  name        = "bashir-terraform-sg-${terraform.workspace}"
  description = "Allow SSH and HTTP"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bashir-terraform-sg"
    Name = "bashir-${terraform.workspace}-ec2"
  }
}
resource "aws_key_pair" "bashir_key" {
  key_name   = "bashir-terraform-key-${terraform.workspace}"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDTEL22OrkDZY4TR6IJv8CiVxFlo3i39aPEGRtSk65JN bashirsulieman@icloud.com"
}

module "ec2" {
  source = "./modules/ec2"

  ami               = "ami-0d8bacd515f0c2693"
  instance_type     = var.instance_type
  key_name          = aws_key_pair.bashir_key.key_name
  security_group_id = aws_security_group.bashir_sg.id
  name              = "bashir-terraform-ec2-${terraform.workspace}"
}