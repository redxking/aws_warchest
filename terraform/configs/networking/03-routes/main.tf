locals {
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
resource "aws_route" "transit_gateway_route_rfc1918" {
  for_each = toset(var.transit_gateway_rfc1918_cidr)

  route_table_id            = module.vpc.intra_route_table_ids[0]
  destination_cidr_block    = each.value
  transit_gateway_id        = var.transit_gateway_id[var.region]
  depends_on                = [module.vpc]
}

resource "aws_route" "private_route_transit_gateway" {
  for_each = toset(module.vpc.private_route_table_ids)

  route_table_id            = each.value 
  destination_cidr_block    = "0.0.0.0/0"
  transit_gateway_id        = var.transit_gateway_id[var.region]
  depends_on                = [module.vpc]
}