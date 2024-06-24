module "lambda_function_authorizor" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "${var.environment}_authorizer"
  description   = "${var.environment} function to authorize api gateway"
  handler       = "app.lambda_handler"
  publish       = true
  runtime       = "python3.11"
  timeout       = 30

  create_package = true

  #   environment_variables = {
  #     EXAMPLE      = "test"
  #   }

  source_path = [
    {
      path             = "${path.module}/lambda_authorizer"
      pip_requirements = false
    }
  ]

  attach_policies = true
  policies        = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole", ]

  allowed_triggers = {
    AllowExecutionFromAPIGateway = {
      service    = "apigateway"
      source_arn = "${module.api_gateway.api_execution_arn}/*/*"
    }
  }

  cloudwatch_logs_retention_in_days = 3

  tags = var.tags
}
