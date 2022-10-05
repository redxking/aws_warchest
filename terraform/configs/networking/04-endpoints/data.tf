# Define any data sources here

#
# Data: SSM Parameters - VPC
#
data "aws_ssm_parameter" "vpc_id" {
  name   = "/infra/${var.environment}/networking/vpc_id"
}

data "aws_ssm_parameter" "vpc_private_subnet_ids" {
  name   = "/infra/${var.environment}/networking/private_subnet_ids"
}

data "aws_ssm_parameter" "vpc_public_route_table_ids" {
  name   = "/infra/${var.environment}/networking/public_route_table_ids"
}

data "aws_ssm_parameter" "vpc_private_route_table_ids" {
  name   = "/infra/${var.environment}/networking/private_route_table_ids"
}

data "aws_ssm_parameter" "vpc_intra_route_table_ids" {
  name   = "/infra/${var.environment}/networking/intra_route_table_ids"
}

data "aws_ssm_parameter" "default_security_group_id" {
  name   = "/infra/${var.environment}/networking/default_security_group_id"
}

data "aws_ssm_parameter" "systems_manager_security_group_id" {
  name   = "/infra/${var.environment}/networking/systems_manager_security_group_id"
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

      values = [data.aws_ssm_parameter.vpc_id.value]
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

      values = [data.aws_ssm_parameter.vpc_id.value]
    }
  }
}