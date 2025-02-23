terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.87.0"
    }
  }

  required_version = ">= 1.2.0"

  backend "s3" {
    bucket = "tf-remotestate-http-test-lambda"
    key = "state"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "lambda" {
  source = "./modules/lambda"

  suffix    = var.suffix
  image_uri = var.image_uri
  pagerduty_key = var.pagerduty_key
}