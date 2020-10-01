resource "aws_lamdba_function" "rtx-sms" {
    function_name = var.app_name
    runtime = var.runtime
    filename = "${file(var.lambdafile)}"
    function_name  = var.function_name
    handler = var.handler

}

resource "aws_api_gateway_rest_api" "rtx-api" {
  name = "rtx-api"
}

resource "aws_api_gateway_resource" "rtx-api-notif" {
  rest_api_id = "${aws_api_gateway_rest_api.rtx-api.id}"
  parent_id   = "${aws_api_gateway_rest_api.rtx-api.root_resource_id}"
  path_part   = "rtx-api"
}


resource "aws_api_gateway_method" "request_method" {
  rest_api_id   = "${var.rest_api_id}"
  resource_id   = "${var.resource_id}"
  http_method   = "${var.method}"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "request_method_integration" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${aws_api_gateway_method.request_method.http_method}"
  type        = "AWS"
  uri         = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.region}:${var.account_id}:function:${var.lambda}/invocations"

  # AWS lambdas can only be invoked with the POST method
  integration_http_method = "POST"
}
  



resource "aws_api_gateway_deployment" "rtx-api-deploy" {
  rest_api_id = "${aws_api_gateway_rest_api.rtx-api.id}"
  stage_name  = "production"
  description = "Deploy methods: ${module.rtx-api.http_method} ${module.hello_post.http_method}"
}


resource "aws_lambda_permission" "allow_api_gateway" {
  function_name = "${var.lambda}"
  statement_id  = "AllowExecutionFromApiGateway"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${var.account_id}:${var.rest_api_id}/*/${var.method}${var.path}"
}