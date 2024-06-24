provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = "cc_fraud_analysis"
      Owner       = "Todd Lee Jeff"
      Provisioner = "Terraform"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.50.0"
    }
  }
  required_version = "1.8.5"
}