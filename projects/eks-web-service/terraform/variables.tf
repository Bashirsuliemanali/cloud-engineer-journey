variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string 
  defualt     = "eu-west-2"
}


variable "project_name" {
  description = "project name used for naming resources"
  type        = string 
  defualt     = "eks-web-service"
}


variable "environment" {
  description = "environment name"
  type        = string 
  default     = "dev"
}