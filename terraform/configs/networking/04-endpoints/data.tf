# Define any data sources here

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

data "external" "vpc_private_subnet_ids" {
  program = ["python", "${path.module}/../../../scripts/tf_data_external_ssm_parameter.py"]

  query = {
    aws_region         = var.region
    ssm_parameter_name = "/infra/${var.environment}/networking/private_subnet_ids"
  }
}

data "external" "vpc_public_route_table_ids" {
  program = ["python", "${path.module}/../../../scripts/tf_data_external_ssm_parameter.py"]

  query = {
    aws_region         = var.region
    ssm_parameter_name = "/infra/${var.environment}/networking/public_route_table_ids"
  }
}

data "external" "vpc_private_route_table_ids" {
  program = ["python", "${path.module}/../../../scripts/tf_data_external_ssm_parameter.py"]

  query = {
    aws_region         = var.region
    ssm_parameter_name = "/infra/${var.environment}/networking/private_route_table_ids"
  }
}

data "external" "vpc_intra_route_table_ids" {
  program = ["python", "${path.module}/../../../scripts/tf_data_external_ssm_parameter.py"]

  query = {
    aws_region         = var.region
    ssm_parameter_name = "/infra/${var.environment}/networking/intra_route_table_ids"
  }
}

data "external" "default_security_group_id" {
  program = ["python", "${path.module}/../../../scripts/tf_data_external_ssm_parameter.py"]

  query = {
    aws_region         = var.region
    ssm_parameter_name = "/infra/${var.environment}/networking/default_security_group_id"
  }
}

data "external" "systems_manager_security_group_id" {
  program = ["python", "${path.module}/../../../scripts/tf_data_external_ssm_parameter.py"]

  query = {
    aws_region         = var.region
    ssm_parameter_name = "/infra/${var.environment}/networking/systems_manager_security_group_id"
  }
}


#
# Data: VPC Endpoint Policies
#
data "aws_iam_policy_document" "dynamodb_endpoint_policy" {
  statement {
    effect    = "Deny"
    actions   = ["dynamodb:*"]
    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringNotEquals"
      variable = "aws:sourceVpce"

      values = [data.external.vpc_id.result["value"]]
    }
  }
}

data "aws_iam_policy_document" "generic_endpoint_policy" {
  statement {
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringNotEquals"
      variable = "aws:SourceVpc"

      values = [data.external.vpc_id.result["value"]]
    }
  }
}