module "api_gateway" {
  source = "terraform-aws-modules/apigateway-v2/aws"

  name          = var.environment
  description   = "API Gateway for ${var.environment} environment"
  protocol_type = "HTTP"

  #     authorizers = {
  #     lambda = {
  #       authorizer_payload_format_version = "2.0"
  #       authorizer_type                   = "REQUEST"
  #       authorizer_uri                    = module.lambda_function_authorizor.lambda_function_invoke_arn
  #       enable_simple_responses           = true
  #       identity_sources                  = ["$request.header.Authorization"]
  #       name                              = "lambda_authorizer"
  #     }
  #   }

  cors_configuration = {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["https://${local.site_domain}"]
  }

  create_certificate    = false
  create_domain_name    = true
  create_domain_records = false

  domain_name                 = local.site_domain
  domain_name_certificate_arn = aws_acm_certificate.this.arn

  disable_execute_api_endpoint = false

  stage_access_log_settings = {
    create_log_group            = true
    log_group_retention_in_days = 3
  }

  stage_default_route_settings = {
    detailed_metrics_enabled = true
    throttling_burst_limit   = 50
    throttling_rate_limit    = 50
  }
  # routes = {
  #     "ANY /" = {
  #       detailed_metrics_enabled = false
  #
  #       integration = {
  #         uri                    = module.lambda_function.lambda_function_arn
  #         payload_format_version = "2.0"
  #         timeout_milliseconds   = 12000
  #       }
  #   "$default" = {
  #       authorization_type = "CUSTOM"
  #       authorizer_key     = "lambda"
  #       integration = {
  #         connection_type = "VPC_LINK"
  #         method          = "ANY"
  #         type            = "HTTP_PROXY"
  #         uri             = data.aws_lb_listener.api.arn
  #         vpc_link_key    = "vpc"
  #       }
  #     }
  #     }

  tags = var.tags
}