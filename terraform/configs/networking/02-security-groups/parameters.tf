resource "aws_ssm_parameter" "transit_gateway_security_group_arn" {
  description = "The ARN of the security group (Transit Gateway)"
  name        = "/infra/${var.environment}/networking/transit_gateway_security_group_arn"
  type        = "String"
  value       = module.transit_gateway_sg.security_group_arn 
  
  depends_on  = [module.transit_gateway_sg]
}

resource "aws_ssm_parameter" "transit_gateway_security_group_id" {
  description = "The ID of the security group (Transit Gateway)"
  name        = "/infra/${var.environment}/networking/transit_gateway_security_group_id"
  type        = "String"
  value       = module.transit_gateway_sg.security_group_id
  
  depends_on  = [module.transit_gateway_sg]
}

resource "aws_ssm_parameter" "transit_gateway_security_group_vpc_id" {
  description = "The VPC ID of the security group (Transit Gateway)"
  name        = "/infra/${var.environment}/networking/transit_gateway_security_group_vpc_id"
  type        = "String"
  value       = module.transit_gateway_sg.security_group_vpc_id
  
  depends_on  = [module.transit_gateway_sg]
}

resource "aws_ssm_parameter" "transit_gateway_security_group_owner_id" {
  description = "The Owner ID of the security group (Transit Gateway)"
  name        = "/infra/${var.environment}/networking/transit_gateway_security_group_owner_id"
  type        = "String"
  value       = module.transit_gateway_sg.security_group_owner_id
  
  depends_on  = [module.transit_gateway_sg]
}

resource "aws_ssm_parameter" "transit_gateway_security_group_name" {
  description = "The Name of the security group (Transit Gateway)"
  name        = "/infra/${var.environment}/networking/transit_gateway_security_group_name"
  type        = "String"
  value       = module.transit_gateway_sg.security_group_name
  
  depends_on  = [module.transit_gateway_sg]
}

resource "aws_ssm_parameter" "systems_manager_security_group_arn" {
  description = "The ARN of the security group (Systems Manager)"
  name        = "/infra/${var.environment}/networking/systems_manager_security_group_arn"
  type        = "String"
  value       = module.systems_manager_sg.security_group_arn 
  
  depends_on  = [module.systems_manager_sg]
}

resource "aws_ssm_parameter" "systems_manager_security_group_id" {
  description = "The ID of the security group (Systems Manager)"
  name        = "/infra/${var.environment}/networking/systems_manager_security_group_id"
  type        = "String"
  value       = module.systems_manager_sg.security_group_id 
  
  depends_on  = [module.systems_manager_sg]
}

resource "aws_ssm_parameter" "systems_manager_security_group_vpc_id" {
  description = "The VPC ID of the security group (Systems Manager)"
  name        = "/infra/${var.environment}/networking/systems_manager_security_group_vpc_id"
  type        = "String"
  value       = module.systems_manager_sg.security_group_vpc_id 
  
  depends_on  = [module.systems_manager_sg]
}

resource "aws_ssm_parameter" "systems_manager_security_group_owner_id" {
  description = "The Owner ID of the security group (Systems Manager)"
  name        = "/infra/${var.environment}/networking/systems_manager_security_group_owner_id"
  type        = "String"
  value       = module.systems_manager_sg.security_group_owner_id 
  
  depends_on  = [module.systems_manager_sg]
}

resource "aws_ssm_parameter" "systems_manager_security_group_name" {
  description = "The Name of the security group (Systems Manager)"
  name        = "/infra/${var.environment}/networking/systems_manager_security_group_name"
  type        = "String"
  value       = module.systems_manager_sg.security_group_name 

  depends_on  = [module.systems_manager_sg]
}

resource "aws_ssm_parameter" "route53_resolver_security_group_arn" {
  description = "The ARN of the security group (Route53 Resolver)"
  name        = "/infra/${var.environment}/networking/route53_resolver_security_group_arn"
  type        = "String"
  value       = module.route53_resolver_sg.security_group_arn 

  depends_on  = [module.route53_resolver_sg]
}

resource "aws_ssm_parameter" "route53_resolver_security_group_id" {
  description = "The ID of the security group (Route53 Resolver)"
  name        = "/infra/${var.environment}/networking/route53_resolver_security_group_id"
  type        = "String"
  value       = module.route53_resolver_sg.security_group_id 

  depends_on  = [module.route53_resolver_sg]
}

resource "aws_ssm_parameter" "route53_resolver_security_group_vpc_id" {
  description = "The VPC ID of the security group (Route53 Resolver)"
  name        = "/infra/${var.environment}/networking/route53_resolver_security_group_vpc_id"
  type        = "String"
  value       = module.route53_resolver_sg.security_group_vpc_id 

  depends_on  = [module.route53_resolver_sg]
}

resource "aws_ssm_parameter" "route53_resolver_security_group_owner_id" {
  description = "The Owner ID of the security group (Route53 Resolver)"
  name        = "/infra/${var.environment}/networking/route53_resolver_security_group_owner_id"
  type        = "String"
  value       = module.route53_resolver_sg.security_group_owner_id 

  depends_on  = [module.route53_resolver_sg]
}

resource "aws_ssm_parameter" "route53_resolver_security_group_name" {
  description = "The Name of the security group (Route53 Resolver)"
  name        = "/infra/${var.environment}/networking/route53_resolver_security_group_name"
  type        = "String"
  value       = module.route53_resolver_sg.security_group_name

  depends_on  = [module.route53_resolver_sg]
}