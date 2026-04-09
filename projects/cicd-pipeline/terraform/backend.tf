terraform {
  backend "s3" {
    bucket         = "bashir-terraform-state-2026"
    key            = "cicd-pipeline/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}