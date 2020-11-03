provider "aws" {
    profile = var.profile
    shared_credentials_file = file(var.aws_secret)
    region = var.region
}


terraform {
  backend "s3" {
    encrypt = true
    bucket = "terraform-state-s3-alex-personal-infra"
    region = "eu-west-2"
    dynamodb_table = "terraform-state-lock-dynamo"
    key = "terraform-state-aws-vault-vpc/terraform.tfstate"
  }
}







  





