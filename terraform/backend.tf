terraform {
  backend "s3" {
    bucket = "bsc.sandbox.terraform.state"
    key    = "cc_fraud_analysis/terraform.tfstate"
    region = "us-east-2"
  }
}
