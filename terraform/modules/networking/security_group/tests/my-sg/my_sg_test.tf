##
# Define our Terraform requirements, including providers and their version
# ranges. This is the ONLY place where we should specify provider versions, for
# future-compatibility.
#
# https://www.terraform.io/docs/configuration/terraform.html
##

terraform {
  required_version = ">= 1.0, < 2.0"

  required_providers {
    aws = ">= 2.7.0"
  }
}

provider "aws" {
  access_key                  = "test"
  secret_key                  = "test"
  region                      = "us-east-1"
  s3_force_path_style         = false
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    apigateway     = "http://host.docker.internal:4566"
    apigatewayv2   = "http://host.docker.internal:4566"
    cloudformation = "http://host.docker.internal:4566"
    cloudwatch     = "http://host.docker.internal:4566"
    dynamodb       = "http://host.docker.internal:4566"
    ec2            = "http://host.docker.internal:4566"
    es             = "http://host.docker.internal:4566"
    elasticache    = "http://host.docker.internal:4566"
    firehose       = "http://host.docker.internal:4566"
    iam            = "http://host.docker.internal:4566"
    kinesis        = "http://host.docker.internal:4566"
    lambda         = "http://host.docker.internal:4566"
    rds            = "http://host.docker.internal:4566"
    redshift       = "http://host.docker.internal:4566"
    route53        = "http://host.docker.internal:4566"
    s3             = "http://s3.host.docker.internal.localstack.cloud:4566"
    secretsmanager = "http://host.docker.internal:4566"
    ses            = "http://host.docker.internal:4566"
    sns            = "http://host.docker.internal:4566"
    sqs            = "http://host.docker.internal:4566"
    ssm            = "http://host.docker.internal:4566"
    stepfunctions  = "http://host.docker.internal:4566"
    sts            = "http://host.docker.internal:4566"
    networkmanager = "http://host.docker.internal:4566"
  }
}

locals {
  tags = {
    CreatedBy = "Terratest"
  }
}

module "security_group" {
  source = "../.."

  app_name = "myapp"

  tags = local.tags
}

# tflint-ignore: terraform_documented_outputs
output "example_security_group_name" {
  value = try(module.security_group.example_security_group_name, {})
}