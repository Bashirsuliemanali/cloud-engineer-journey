terraform {
  backend "s3" {
    bucket          = "bashir-terraform-state-2026"
    key             = "eks-web-service/terraform.tfstate"
    region          = "eu-west-2"
    dynamodb_table  = "terraform-lock"
    encrypt         = true
  }
}