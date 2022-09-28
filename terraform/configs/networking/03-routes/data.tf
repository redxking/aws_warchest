#
# Data: SSM Parameters - VPC
#
data "aws_ssm_parameter" "intra_route_table_ids" {
  name   = "/infra/${var.environment}/networking/intra_route_table_ids"
}

data "aws_ssm_parameter" "private_route_table_ids" {
  name   = "/infra/${var.environment}/networking/private_route_table_ids"
}