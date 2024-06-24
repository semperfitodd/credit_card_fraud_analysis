module "lambda_function_records" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "${var.environment}_records_function"
  description   = "${var.environment} function to run records through fraud detection"
  handler       = "app.lambda_handler"
  publish       = true
  runtime       = "python3.11"
  timeout       = 30

  #   environment_variables = {
  #     EXAMPLE      = "test"
  #   }

  source_path = [
    {
      path             = "${path.module}/lambda_records"
      pip_requirements = false
    }
  ]

  attach_policies = true
  policies        = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]

  #   attach_policy_statements = true
  #   policy_statements = {
  #     dynamo = {
  #       effect    = "Allow",
  #       actions   = ["dynamodb:*"],
  #       resources = [module.dynamo_daily.dynamodb_table_arn]
  #     }
  #   }

  allowed_triggers = {
    AllowExecutionFromAPIGateway = {
      service    = "apigateway"
      source_arn = "${module.api_gateway.api_execution_arn}/*/*"
    }
  }

  cloudwatch_logs_retention_in_days = 3

  tags = var.tags
}