terraform {
  backend "s3" {
    bucket         = "bashir-terraform-state-2026"
    key            = "terraform-web-service/dev.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}