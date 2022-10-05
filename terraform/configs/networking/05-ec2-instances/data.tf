#
# Data: SSM Parameters - VPC
#
data "aws_ssm_parameter" "vpc_private_subnet_ids" {
  name   = "/infra/${var.environment}/networking/private_subnet_ids"
}

data "aws_ssm_parameter" "systems_manager_security_group_id" {
  name   = "/infra/${var.environment}/networking/systems_manager_security_group_id"
}

data "aws_ssm_parameter" "transit_gateway_security_group_id" {
  name   = "/infra/${var.environment}/networking/transit_gateway_security_group_id"
}