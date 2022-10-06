locals {
  all_route_table_ids = [
    split(",", data.aws_ssm_parameter.intra_route_table_ids.value),
    split(",", data.aws_ssm_parameter.private_route_table_ids.value)
  ]
  tags = merge(
    { Namespace: var.namespace },
    { Environment: var.environment },
    { Region: var.region },
    { Provisioner: var.provisioner }
  )
}


################################################################################
# VPC Routes Module
################################################################################
resource "aws_route" "transit_gateway_route_10xxx" {
  for_each = nonsensitive(toset(flatten(local.all_route_table_ids)))

  route_table_id            = each.value 
  destination_cidr_block    = "10.0.0.0/8"
  transit_gateway_id        = var.transit_gateway_id[var.region]
}

resource "aws_route" "transit_gateway_route_172xxx" {
  for_each = nonsensitive(toset(flatten(local.all_route_table_ids)))

  route_table_id            = each.value 
  destination_cidr_block    = "172.16.0.0/12"
  transit_gateway_id        = var.transit_gateway_id[var.region]
}

resource "aws_route" "transit_gateway_route_192xxx" {
  for_each = nonsensitive(toset(flatten(local.all_route_table_ids)))

  route_table_id            = each.value 
  destination_cidr_block    = "192.168.0.0/16"
  transit_gateway_id        = var.transit_gateway_id[var.region]
}