#
# Output(s): VPC Security Groups - Common
#
output "transit_gateway_security_group_arn" {
  description = "The ARN of the security group (Transit Gateway)"
  value       = module.transit_gateway_sg.security_group_arn 
}

output "transit_gateway_security_group_id" {
  description = "The ID of the security group (Transit Gateway)"
  value       = module.transit_gateway_sg.security_group_id
}

output "transit_gateway_security_group_vpc_id" {
  description = "The VPC ID (Transit Gateway)"
  value       = module.transit_gateway_sg.security_group_vpc_id 
  sensitive   = true
}

output "transit_gateway_security_group_owner_id" {
  description = "The owner ID (Transit Gateway)"
  value       = module.transit_gateway_sg.security_group_owner_id 
}

output "transit_gateway_security_group_name" {
  description = "The name of the security group (Transit Gateway)"
  value       = module.transit_gateway_sg.security_group_name 
}

output "transit_gateway_security_group_description" {
  description = "The description of the security group (Transit Gateway)"
  value       = module.transit_gateway_sg.security_group_description 
}

output "systems_manager_security_group_arn" {
  description = "The ARN of the security group (Systems Manager)"
  value       = module.systems_manager_sg.security_group_arn 
}

output "systems_manager_security_group_id" {
  description = "The ID of the security group (Systems Manager)"
  value       = module.systems_manager_sg.security_group_id
}

output "systems_manager_security_group_vpc_id" {
  description = "The VPC ID (Systems Manager)"
  value       = module.systems_manager_sg.security_group_vpc_id 
  sensitive   = true
}

output "systems_manager_security_group_owner_id" {
  description = "The owner ID (Systems Manager)"
  value       = module.systems_manager_sg.security_group_owner_id 
}

output "systems_manager_security_group_name" {
  description = "The name of the security group (Systems Manager)"
  value       = module.systems_manager_sg.security_group_name 
}

output "systems_manager_security_group_description" {
  description = "The description of the security group (Systems Manager)"
  value       = module.systems_manager_sg.security_group_description 
}

output "route53_resolver_security_group_arn" {
  description = "The ARN of the security group (Route53 Resolver)"
  value       = module.route53_resolver_sg.security_group_arn 
}

output "route53_resolver_security_group_id" {
  description = "The ID of the security group (Route53 Resolver)"
  value       = module.route53_resolver_sg.security_group_id
}

output "route53_resolver_security_group_vpc_id" {
  description = "The VPC ID (Route53 Resolver)"
  value       = module.route53_resolver_sg.security_group_vpc_id 
  sensitive   = true
}

output "route53_resolver_security_group_owner_id" {
  description = "The owner ID (Route53 Resolver)"
  value       = module.route53_resolver_sg.security_group_owner_id 
}

output "route53_resolver_security_group_name" {
  description = "The name of the security group (Route53 Resolver)"
  value       = module.route53_resolver_sg.security_group_name 
}

output "route53_resolver_security_group_description" {
  description = "The description of the security group (Route53 Resolver)"
  value       = module.route53_resolver_sg.security_group_description 
}

#
# Output(s): VPC Security Groups - Custom
#
