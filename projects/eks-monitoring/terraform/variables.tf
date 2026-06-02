variable "aws_region" {
  description = " What awsregion the instance runs in"
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  description = "project name used for naming resources"
  type        = string
  default     = "eks-monitoring"
}

variable "environment" {
  description = "environment name"
  type        = string
  default     = "dev"
}