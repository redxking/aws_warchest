# Define any data sources here

data "aws_ssm_parameter" "vpc_id" {
  name   = "/infra/${var.environment}/networking/vpc_id"
}

data "aws_ssm_parameter" "vpc_cidr" {
  name   = "/infra/${var.environment}/networking/vpc_cidr_block"
}