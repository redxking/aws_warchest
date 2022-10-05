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

  vpc_id  = data.aws_ssm_parameter.vpc_id.value 

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
        split(",", data.aws_ssm_parameter.vpc_intra_route_table_ids.value), 
        split(",", data.aws_ssm_parameter.vpc_private_route_table_ids.value),
        split(",", data.aws_ssm_parameter.vpc_public_route_table_ids.value)
      ])
      policy              = data.aws_iam_policy_document.dynamodb_endpoint_policy.json
      tags                = { Name = "dynamodb-vpc-endpoint" }
    },
    ssm = {
      service             = "ssm"
      private_dns_enabled = true
      subnet_ids          = split(",", data.aws_ssm_parameter.vpc_private_subnet_ids.value)
      security_group_ids  = [data.aws_ssm_parameter.systems_manager_security_group_id.value]
    },
    ssmmessages = {
      service             = "ssmmessages"
      private_dns_enabled = true
      subnet_ids          = split(",", data.aws_ssm_parameter.vpc_private_subnet_ids.value)
      security_group_ids  = [data.aws_ssm_parameter.systems_manager_security_group_id.value]
    },
    lambda = {
      service             = "lambda"
      private_dns_enabled = true
      subnet_ids          = split(",", data.aws_ssm_parameter.vpc_private_subnet_ids.value)
    },
    ecs = {
      service             = "ecs"
      private_dns_enabled = true
      subnet_ids          = split(",", data.aws_ssm_parameter.vpc_private_subnet_ids.value)
    },
    ecs_telemetry = {
      create              = false
      service             = "ecs-telemetry"
      private_dns_enabled = true
      subnet_ids          = split(",", data.aws_ssm_parameter.vpc_private_subnet_ids.value)
    },
    ec2 = {
      service             = "ec2"
      private_dns_enabled = true
      subnet_ids          = split(",", data.aws_ssm_parameter.vpc_private_subnet_ids.value)
      security_group_ids  = [data.aws_ssm_parameter.systems_manager_security_group_id.value]
    },
    ec2messages = {
      service             = "ec2messages"
      private_dns_enabled = true
      subnet_ids          = split(",", data.aws_ssm_parameter.vpc_private_subnet_ids.value)
      security_group_ids  = [data.aws_ssm_parameter.systems_manager_security_group_id.value]
    },
    ecr_api = {
      service             = "ecr.api"
      private_dns_enabled = true
      subnet_ids          = split(",", data.aws_ssm_parameter.vpc_private_subnet_ids.value)
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
    },
    ecr_dkr = {
      service             = "ecr.dkr"
      private_dns_enabled = true
      subnet_ids          = split(",", data.aws_ssm_parameter.vpc_private_subnet_ids.value)
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
    },
    kms = {
      service             = "kms"
      private_dns_enabled = true
      subnet_ids          = split(",", data.aws_ssm_parameter.vpc_private_subnet_ids.value)
      security_group_ids  = [data.aws_ssm_parameter.systems_manager_security_group_id.value]
    },
    codedeploy = {
      service             = "codedeploy"
      private_dns_enabled = true
      subnet_ids          = split(",", data.aws_ssm_parameter.vpc_private_subnet_ids.value)
    },
    codedeploy_commands_secure = {
      service             = "codedeploy-commands-secure"
      private_dns_enabled = true
      subnet_ids          = split(",", data.aws_ssm_parameter.vpc_private_subnet_ids.value)
    },
  }

  tags = merge(local.tags, {
    Endpoint = "true"
  })
}