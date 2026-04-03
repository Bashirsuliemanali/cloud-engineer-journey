variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-west-2"
}


variable "project_name" {
  description = "project name used for naming resources"
  type        = string
  default     = "eks-web-service"
}


variable "environment" {
  description = "environment name"
  type        = string
  default     = "dev"
}