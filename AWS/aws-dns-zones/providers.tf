provider "aws" {
    profile = var.profile
    shared_credentials_file = file(var.aws_secret)
    region = var.region
}


terraform {
  backend "s3" {
    encrypt = true
    # cannot contain interpolations
    # bucket = "${aws_s3_bucket.terraform-state-s3-alex-personal-infra.bucket}"
    bucket = "terraform-state-s3-alex-personal-infra"
    # region = "${aws_s3_bucket.terraform-state-s3-alex-personal-infra.region}"
    region = "eu-west-2"
    dynamodb_table = "terraform-state-lock-dynamo"
    key = "terraform-state-aws-dns-zones/terraform.tfstate"
  }
}







  





