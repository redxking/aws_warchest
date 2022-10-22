#
# Data: SSM Parameters - VPC
#
data "external" "vpc_private_subnet_ids" {
  program = ["python", "${path.module}/../../../scripts/tf_data_external_ssm_parameter.py"]

  query = {
    aws_region         = var.region
    ssm_parameter_name = "/infra/${var.environment}/networking/private_subnet_ids"
  }
}

data "external" "systems_manager_security_group_id" {
  program = ["python", "${path.module}/../../../scripts/tf_data_external_ssm_parameter.py"]

  query = {
    aws_region         = var.region
    ssm_parameter_name = "/infra/${var.environment}/networking/systems_manager_security_group_id"
  }
}

data "external" "transit_gateway_security_group_id" {
  program = ["python", "${path.module}/../../../scripts/tf_data_external_ssm_parameter.py"]

  query = {
    aws_region         = var.region
    ssm_parameter_name = "/infra/${var.environment}/networking/transit_gateway_security_group_id"
  }
}