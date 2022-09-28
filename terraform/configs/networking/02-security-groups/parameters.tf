resource "aws_ssm_parameter" "transit_gateway_security_group_arn" {
  count       = length(module.transit_gateway_sg.security_group_arn) > 0 ? 1 : 0

  description = "The ARN of the security group (Transit Gateway)"
  name        = "/infra/${var.environment}/networking/transit_gateway_security_group_arn"
  type        = "String"
  value       = module.transit_gateway_sg.security_group_arn 
}

resource "aws_ssm_parameter" "transit_gateway_security_group_id" {
  count       = length(module.transit_gateway_sg.security_group_id) > 0 ? 1 : 0

  description = "The ID of the security group (Transit Gateway)"
  name        = "/infra/${var.environment}/networking/transit_gateway_security_group_id"
  type        = "String"
  value       = module.transit_gateway_sg.security_group_id
}

resource "aws_ssm_parameter" "transit_gateway_security_group_vpc_id" {
  count       = length(module.transit_gateway_sg.security_group_vpc_id) > 0 ? 1 : 0

  description = "The VPC ID of the security group (Transit Gateway)"
  name        = "/infra/${var.environment}/networking/transit_gateway_security_group_vpc_id"
  type        = "String"
  value       = module.transit_gateway_sg.security_group_vpc_id
}

resource "aws_ssm_parameter" "transit_gateway_security_group_owner_id" {
  count       = length(module.transit_gateway_sg.security_group_owner_id) > 0 ? 1 : 0

  description = "The Owner ID of the security group (Transit Gateway)"
  name        = "/infra/${var.environment}/networking/transit_gateway_security_group_owner_id"
  type        = "String"
  value       = module.transit_gateway_sg.security_group_owner_id
}

resource "aws_ssm_parameter" "transit_gateway_security_group_name" {
  count       = length(module.transit_gateway_sg.security_group_name) > 0 ? 1 : 0

  description = "The Name of the security group (Transit Gateway)"
  name        = "/infra/${var.environment}/networking/transit_gateway_security_group_name"
  type        = "String"
  value       = module.transit_gateway_sg.security_group_name
}

resource "aws_ssm_parameter" "systems_manager_security_group_arn" {
  count       = length(module.systems_manager_sg.security_group_arn) > 0 ? 1 : 0

  description = "The ARN of the security group (Systems Manager)"
  name        = "/infra/${var.environment}/networking/systems_manager_security_group_arn"
  type        = "String"
  value       = module.systems_manager_sg.security_group_arn 
}

resource "aws_ssm_parameter" "systems_manager_security_group_id" {
  count       = length(module.systems_manager_sg.security_group_id) > 0 ? 1 : 0

  description = "The ID of the security group (Systems Manager)"
  name        = "/infra/${var.environment}/networking/systems_manager_security_group_id"
  type        = "String"
  value       = module.systems_manager_sg.security_group_id 
}

resource "aws_ssm_parameter" "systems_manager_security_group_vpc_id" {
  count       = length(module.systems_manager_sg.security_group_vpc_id) > 0 ? 1 : 0

  description = "The VPC ID of the security group (Systems Manager)"
  name        = "/infra/${var.environment}/networking/systems_manager_security_group_vpc_id"
  type        = "String"
  value       = module.systems_manager_sg.security_group_vpc_id 
}

resource "aws_ssm_parameter" "systems_manager_security_group_owner_id" {
  count       = length(module.systems_manager_sg.security_group_owner_id) > 0 ? 1 : 0

  description = "The Owner ID of the security group (Systems Manager)"
  name        = "/infra/${var.environment}/networking/systems_manager_security_group_owner_id"
  type        = "String"
  value       = module.systems_manager_sg.security_group_owner_id 
}

resource "aws_ssm_parameter" "systems_manager_security_group_name" {
  count       = length(module.systems_manager_sg.security_group_name) > 0 ? 1 : 0

  description = "The Name of the security group (Systems Manager)"
  name        = "/infra/${var.environment}/networking/systems_manager_security_group_name"
  type        = "String"
  value       = module.systems_manager_sg.security_group_name 
}

resource "aws_ssm_parameter" "route53_resolver_security_group_arn" {
  count       = length(module.route53_resolver_sg.security_group_arn) > 0 ? 1 : 0

  description = "The ARN of the security group (Route53 Resolver)"
  name        = "/infra/${var.environment}/networking/route53_resolver_security_group_arn"
  type        = "String"
  value       = module.route53_resolver_sg.security_group_arn 
}

resource "aws_ssm_parameter" "route53_resolver_security_group_id" {
  count       = length(module.route53_resolver_sg.security_group_id) > 0 ? 1 : 0

  description = "The ID of the security group (Route53 Resolver)"
  name        = "/infra/${var.environment}/networking/route53_resolver_security_group_id"
  type        = "String"
  value       = module.route53_resolver_sg.security_group_id 
}

resource "aws_ssm_parameter" "route53_resolver_security_group_vpc_id" {
  count       = length(module.route53_resolver_sg.security_group_vpc_id) > 0 ? 1 : 0

  description = "The VPC ID of the security group (Route53 Resolver)"
  name        = "/infra/${var.environment}/networking/route53_resolver_security_group_vpc_id"
  type        = "String"
  value       = module.route53_resolver_sg.security_group_vpc_id 
}

resource "aws_ssm_parameter" "route53_resolver_security_group_owner_id" {
  count       = length(module.route53_resolver_sg.security_group_owner_id) > 0 ? 1 : 0

  description = "The Owner ID of the security group (Route53 Resolver)"
  name        = "/infra/${var.environment}/networking/route53_resolver_security_group_owner_id"
  type        = "String"
  value       = module.route53_resolver_sg.security_group_owner_id 
}

resource "aws_ssm_parameter" "route53_resolver_security_group_name" {
  count       = length(module.route53_resolver_sg.security_group_name) > 0 ? 1 : 0

  description = "The Name of the security group (Route53 Resolver)"
  name        = "/infra/${var.environment}/networking/route53_resolver_security_group_name"
  type        = "String"
  value       = module.route53_resolver_sg.security_group_name 
}