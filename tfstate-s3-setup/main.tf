provider "aws" {
    profile = var.profile
    region = var.region
    shared_credentials_file = file(var.aws_secret)
}

# store tfstate in s3 and locking information in DynamoDB
terraform {
  backend "s3" {
    encrypt = true
    # cannot contain interpolations
    # bucket = "${aws_s3_bucket.terraform-state-s3-alex-personal-infra.bucket}"
    bucket = "terraform-state-s3-alex-personal-infra"
    # region = "${aws_s3_bucket.terraform-state-s3-alex-personal-infra.region}"
    region = "eu-west-2"
    # dynamodb_table = "alexinf-iac-terraform-state-lock-dynamo"
    key = "terraform-state-s3/terraform.tfstate"
  }
}