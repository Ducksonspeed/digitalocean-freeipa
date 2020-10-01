provider "aws" {
  region     = "${var.aws_region}"
}

data "aws_caller_identity" "current" { }

# First, we need a role to play with Lambda
resource "aws_iam_role" "iam_role_for_lambda" {
  name = "iam_role_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

module "lambda_post" {
  source  = "./lambda"
  name    = "hello_lambda"
  handler = "post_handler"
  runtime = "python2.7"
  role    = "${aws_iam_role.iam_role_for_lambda.arn}"
}

resource "aws_api_gateway_rest_api" "hello_api" {
  name = "Hello API"
}

# The API requires at least one "endpoint", or "resource" in AWS terminology.
# The endpoint created here is: /hello
resource "aws_api_gateway_resource" "rtx_api" {
  rest_api_id = "${aws_api_gateway_rest_api.hello_api.id}"
  parent_id   = "${aws_api_gateway_rest_api.hello_api.root_resource_id}"
  path_part   = "/"
}


# We can deploy the API now! (i.e. make it publicly available)
resource "aws_api_gateway_deployment" "rtx_api_deployment" {
  rest_api_id = "${aws_api_gateway_rest_api.hello_api.id}"
  stage_name  = "production"
  description = "Deploy methods: ${module.hello_get.http_method} ${module.hello_post.http_method}"
}
