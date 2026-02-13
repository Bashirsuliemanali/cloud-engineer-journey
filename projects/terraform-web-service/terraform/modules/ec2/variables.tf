variable "ami" {
  description = "AMI ID"
}

variable "instance_type" {
  description = "EC2 instance type"
}

variable "key_name" {
  description = "SSH key pair name"
}

variable "security_group_id" {
  description = "Security group ID"
}

variable "name" {
  description = "Instance name"
}

variable "subnet_id" {
  description = "Subnet to launch EC2 into"
  type        = string
}