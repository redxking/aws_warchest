locals {
  create_related_ipv6_resources                     = var.vpc_enable_ipv6 ? true : false
  create_related_secondary_cidr_resources           = length(lookup(var.vpc_secondary_cidr_blocks, var.region, [])) > 0 ? true : false
  create_related_intra_subnet_resources             = length(lookup(var.vpc_intra_subnet_cidr_blocks, var.region, [])) > 0 ? true : false
  create_related_private_subnet_resources           = length(lookup(var.vpc_private_subnet_cidr_blocks, var.region, [])) > 0 ? true : false
  create_related_public_subnet_resources            = length(lookup(var.vpc_public_subnet_cidr_blocks, var.region, [])) > 0 ? true : false
  create_related_database_subnet_resources          = length(lookup(var.vpc_database_subnet_cidr_blocks, var.region, [])) > 0 ? true : false
  create_related_redshift_subnet_resources          = length(lookup(var.vpc_redshift_subnet_cidr_blocks, var.region, [])) > 0 ? true : false
  create_related_elasticache_subnet_resources       = length(lookup(var.vpc_elasticache_subnet_cidr_blocks, var.region, [])) > 0 ? true : false
  create_related_database_subnet_group_resources    = var.vpc_create_database_subnet_group ? true : false
  create_related_redshift_subnet_group_resources    = var.vpc_create_redshift_subnet_group ? true : false
  create_related_elasticache_subnet_group_resources = var.vpc_create_elasticache_subnet_group ? true : false
  create_related_internet_gateway_resources         = var.vpc_enable_internet_gateway ? true : false
  create_related_nat_gateway_resources              = var.vpc_enable_nat_gateway ? true : false
  create_related_flow_log_resources                 = var.vpc_enable_flow_log ? true : false
  create_related_vpn_gateway_resources              = var.vpc_enable_vpn_gateway ? true : false
  create_related_customer_gateway_resources         = length(var.vpc_customer_gateways) > 0 ? true : false
  tags = merge(
    { Namespace: var.namespace },
    { Environment: var.environment },
    { Region: var.region },
    { Provisioner: var.provisioner }
  )
}

################################################################################
# VPC Module
################################################################################
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.16.0" 

  name = var.vpc_name
  cidr = lookup(var.vpc_cidr_block, var.region)
  azs  = lookup(var.vpc_availability_zones, var.region)

  # IPv6
  enable_ipv6            = var.vpc_enable_ipv6
  
  # DNS
  enable_dns_support     = var.vpc_enable_dns_support
  enable_dns_hostnames   = var.vpc_enable_dns_hostnames 

  # Internet Gateway
  create_igw             = var.vpc_enable_internet_gateway

  # VPN Gateway
  enable_vpn_gateway     = var.vpc_enable_vpn_gateway

  # NAT Gateway
  enable_nat_gateway     = var.vpc_enable_nat_gateway
  single_nat_gateway     = var.vpc_single_nat_gateway
  one_nat_gateway_per_az = var.vpc_one_nat_gateway_per_az

  # Subnet(s)
  database_subnets                = lookup(var.vpc_database_subnet_cidr_blocks, var.region, [])
  database_subnet_suffix          = var.vpc_database_subnet_suffix
  database_subnet_tags            = var.vpc_database_subnet_tags
  create_database_subnet_group    = var.vpc_create_database_subnet_group

  elasticache_subnets             = lookup(var.vpc_elasticache_subnet_cidr_blocks, var.region, [])
  elasticache_subnet_suffix       = var.vpc_elasticache_subnet_suffix
  elasticache_subnet_tags         = var.vpc_elasticache_subnet_tags
  create_elasticache_subnet_group = var.vpc_create_elasticache_subnet_group

  intra_subnets                   = lookup(var.vpc_intra_subnet_cidr_blocks, var.region, [])
  intra_subnet_suffix             = var.vpc_intra_subnet_suffix
  intra_dedicated_network_acl     = var.vpc_intra_subnet_dedicated_network_acl
  intra_inbound_acl_rules         = var.vpc_intra_subnet_inbound_acl_rules
  intra_outbound_acl_rules        = var.vpc_intra_subnet_outbound_acl_rules
  intra_subnet_tags               = var.vpc_intra_subnet_tags
  

  private_subnets                 = lookup(var.vpc_private_subnet_cidr_blocks, var.region, [])
  private_subnet_suffix           = var.vpc_private_subnet_suffix
  private_subnet_tags             = var.vpc_private_subnet_tags

  public_subnets                  = lookup(var.vpc_public_subnet_cidr_blocks, var.region, [])
  public_subnet_suffix            = var.vpc_public_subnet_suffix
  public_subnet_tags              = var.vpc_public_subnet_tags

  redshift_subnets                = lookup(var.vpc_redshift_subnet_cidr_blocks, var.region, [])
  redshift_subnet_suffix          = var.vpc_redshift_subnet_suffix
  redshift_subnet_tags            = var.vpc_redshift_subnet_tags
  create_redshift_subnet_group    = var.vpc_create_redshift_subnet_group 

  # Flow Logs
  enable_flow_log                           = var.vpc_enable_flow_log
  create_flow_log_cloudwatch_iam_role       = var.vpc_create_flow_log_cloudwatch_iam_role
  create_flow_log_cloudwatch_log_group      = var.vpc_create_flow_log_cloudwatch_log_group
  flow_log_traffic_type                     = "ALL"
  flow_log_destination_type                 = "cloud-watch-logs"
  flow_log_cloudwatch_log_group_name_prefix = "/aws/vpc/${var.vpc_name}/flow/"
  flow_log_cloudwatch_log_group_retention_in_days = var.vpc_flow_log_cloudwatch_log_group_retention

  # Tag(s)
  tags     = local.tags
  vpc_tags = var.vpc_tags 
}