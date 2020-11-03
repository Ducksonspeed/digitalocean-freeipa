provider "digitalocean" {
  token = file(var.credentials)
}


terraform {
  backend "s3" {
    encrypt = true
    # cannot contain interpolations
    # bucket = "${aws_s3_bucket.terraform-state-s3-alex-personal-infra.bucket}"
    bucket = "terraform-state-s3-alex-personal-infra"
    # region = "${aws_s3_bucket.terraform-state-s3-alex-personal-infra.region}"
    region = "eu-west-2"
    # dynamodb_table = "alexinf-iac-terraform-state-lock-dynamo"
    key = "terraform-state-digitalocean-docker/terraform.tfstate"
  }
}