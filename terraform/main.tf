terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}
resource "aws_security_group" "bashir_sg" {
  name        = "bashir-terraform-sg"
  description = "Allow SSH and HTTP"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
    Name = "bashir-terraform-sg"
  }
}
resource "aws_key_pair" "bashir_key" {
  key_name   = "bashir-terraform-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDTEL22OrkDZY4TR6IJv8CiVxFlo3i39aPEGRtSk65JN bashirsulieman@icloud.com"
}

resource "aws_instance" "bashir_ec2" {
  ami           = "ami-0d8bacd515f0c2693"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.bashir_sg.id]
  key_name = aws_key_pair.bashir_key.key_name

  tags = {
    Name = "bashir-terraform-ec2"
  }
}
output "instance_public_ip" {
  value = aws_instance.bashir_ec2.public_ip
}