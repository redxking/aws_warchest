#
# Data: SSM Parameters - VPC
#
data "external" "vpc_id" {
  program = ["python", "${path.module}/../../../scripts/tf_data_external_ssm_parameter.py"]

  query = {
    aws_region         = var.region
    ssm_parameter_name = "/infra/${var.environment}/networking/vpc_id"
  }
}

data "external" "vpc_cidr_block" {
  program = ["python", "${path.module}/../../../scripts/tf_data_external_ssm_parameter.py"]

  query = {
    aws_region         = var.region
    ssm_parameter_name = "/infra/${var.environment}/networking/vpc_cidr_block"
    default_value      = "172.31.0.0/16"
  }
}