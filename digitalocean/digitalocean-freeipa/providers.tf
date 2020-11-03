provider "digitalocean" {
  token = file(var.credentials)
}


terraform {
  backend "s3" {
    encrypt = true
    bucket = "terraform-state-s3-alex-personal-infra"
    region = "eu-west-2"
    dynamodb_table = "terraform-state-lock-dynamo"
    key = "terraform-state-digital-ocean-freeipa/terraform.tfstate"
  }
}