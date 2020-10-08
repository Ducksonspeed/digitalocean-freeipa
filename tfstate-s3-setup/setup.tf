resource "aws_s3_bucket" "terraform-state-storage-s3" {
  bucket = "terraform-state-s3-alex-personal-infra"
  acl = "private"

  versioning {

    enabled = false
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    name = "S3 Remote Terraform State Store"
    proj = "alexinf-iac"
    env = "prod"
  }
}


resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    name = "DynamoDB Terraform State Lock Table"
    proj = "alexinf-iac"
    env = "prod"
  }
}



