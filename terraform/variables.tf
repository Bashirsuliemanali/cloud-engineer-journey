variable "region" {
  description = "AWS region"
  default     = "eu-west-2"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "my_ip" {
  description = "My public IP for SSH access"
}

variable "ami" {
  description = "AMI ID for EC2"
}