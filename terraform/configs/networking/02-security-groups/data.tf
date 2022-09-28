#
# Data: SSM Parameters - VPC
#
data "aws_ssm_parameter" "vpc_id" {
  name   = "/infra/${var.environment}/networking/vpc_id"
}

data "aws_ssm_parameter" "vpc_cidr_block" {
  name   = "/infra/${var.environment}/networking/vpc_cidr_block"
}