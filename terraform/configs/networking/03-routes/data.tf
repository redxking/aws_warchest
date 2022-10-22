#
# Data: SSM Parameters - VPC
#
data "external" "intra_route_table_ids" {
  program = ["python", "${path.module}/../../../scripts/tf_data_external_ssm_parameter.py"]

  query = {
    aws_region         = var.region
    ssm_parameter_name = "/infra/${var.environment}/networking/intra_route_table_ids"
  }
}

data "external" "private_route_table_ids" {
  program = ["python", "${path.module}/../../../scripts/tf_data_external_ssm_parameter.py"]

  query = {
    aws_region         = var.region
    ssm_parameter_name = "/infra/${var.environment}/networking/private_route_table_ids"
  }
}