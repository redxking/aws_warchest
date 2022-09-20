resource "aws_ssm_parameter" "vpc_id" {
  description = "The ID of the VPC"
  name        = "/infra/${var.environment}/networking/vpc_id"
  type        = "String"
  value       = try(module.vpc.vpc_id, "")
}

resource "aws_ssm_parameter" "vpc_arn" {
  description = "The ARN of the VPC"
  name        = "/infra/${var.environment}/networking/vpc_arn"
  type        = "String"
  value       = try(module.vpc.vpc_arn, "")
}

resource "aws_ssm_parameter" "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  name        = "/infra/${var.environment}/networking/vpc_cidr_block"
  type        = "String"
  value       = try(module.vpc.vpc_cidr_block, "")
}

resource "aws_ssm_parameter" "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  name        = "/infra/${var.environment}/networking/default_security_group_id"
  type        = "String"
  value       = try(module.vpc.default_security_group_id, "")
}
