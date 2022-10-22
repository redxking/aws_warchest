locals {
  tags = merge(
    { Namespace: var.namespace },
    { Environment: var.environment },
    { Region: var.region },
    { Provisioner: var.provisioner }
  )
}


################################################################################
# VPC Endpoints Module
################################################################################
module "vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "3.16.0" 

  vpc_id  = data.external.vpc_id.result["value"] 

  endpoints = {
    s3 = {
      service             = "s3"
      service_type        = "Gateway"
      tags                = { Name = "s3-vpc-endpoint" }
    },
    dynamodb = {
      service             = "dynamodb"
      service_type        = "Gateway"
      route_table_ids     = flatten([
        split(",", data.external.vpc_intra_route_table_ids.result["value"]), 
        split(",", data.external.vpc_private_route_table_ids.result["value"]),
        split(",", data.external.vpc_public_route_table_ids.result["value"])
      ])
      policy              = data.aws_iam_policy_document.dynamodb_endpoint_policy.json
      tags                = { Name = "dynamodb-vpc-endpoint" }
    },
    ssm = {
      service             = "ssm"
      private_dns_enabled = true
      subnet_ids          = split(",", data.external.vpc_private_subnet_ids.result["value"])
      security_group_ids  = [data.external.systems_manager_security_group_id.result["value"]]
    },
    ssmmessages = {
      service             = "ssmmessages"
      private_dns_enabled = true
      subnet_ids          = split(",", data.external.vpc_private_subnet_ids.result["value"])
      security_group_ids  = [data.external.systems_manager_security_group_id.result["value"]]
    },
    lambda = {
      service             = "lambda"
      private_dns_enabled = true
      subnet_ids          = split(",", data.external.vpc_private_subnet_ids.result["value"])
    },
    ecs = {
      service             = "ecs"
      private_dns_enabled = true
      subnet_ids          = split(",", data.external.vpc_private_subnet_ids.result["value"])
    },
    ecs_telemetry = {
      create              = false
      service             = "ecs-telemetry"
      private_dns_enabled = true
      subnet_ids          = split(",", data.external.vpc_private_subnet_ids.result["value"])
    },
    ec2 = {
      service             = "ec2"
      private_dns_enabled = true
      subnet_ids          = split(",", data.external.vpc_private_subnet_ids.result["value"])
      security_group_ids  = [data.external.systems_manager_security_group_id.result["value"]]
    },
    ec2messages = {
      service             = "ec2messages"
      private_dns_enabled = true
      subnet_ids          = split(",", data.external.vpc_private_subnet_ids.result["value"])
      security_group_ids  = [data.external.systems_manager_security_group_id.result["value"]]
    },
    ecr_api = {
      service             = "ecr.api"
      private_dns_enabled = true
      subnet_ids          = split(",", data.external.vpc_private_subnet_ids.result["value"])
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
    },
    ecr_dkr = {
      service             = "ecr.dkr"
      private_dns_enabled = true
      subnet_ids          = split(",", data.external.vpc_private_subnet_ids.result["value"])
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
    },
    kms = {
      service             = "kms"
      private_dns_enabled = true
      subnet_ids          = split(",", data.external.vpc_private_subnet_ids.result["value"])
      security_group_ids  = [data.external.systems_manager_security_group_id.result["value"]]
    },
    codedeploy = {
      service             = "codedeploy"
      private_dns_enabled = true
      subnet_ids          = split(",", data.external.vpc_private_subnet_ids.result["value"])
    },
    codedeploy_commands_secure = {
      service             = "codedeploy-commands-secure"
      private_dns_enabled = true
      subnet_ids          = split(",", data.external.vpc_private_subnet_ids.result["value"])
    },
  }

  tags = merge(local.tags, {
    Endpoint = "true"
  })
}