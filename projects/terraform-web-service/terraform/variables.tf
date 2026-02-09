variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami" {
  description = "AMI ID"
  type        = string
}

variable "my_ip" {
  description = "Your public IP in CIDR format (e.g. 1.2.3.4/32)"
  type        = string
}

variable "public_key_path" {
  description = "Path to your SSH public key"
  type        = string
}