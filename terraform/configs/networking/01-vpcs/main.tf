locals {
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
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = lookup(var.vpc_cidr, var.region)
  azs  = lookup(var.vpc_availability_zones, var.region, null)
  
  # DNS
  enable_dns_hostnames   = var.vpc_enable_dns_hostnames 
  
  # VPC Gateway
  enable_vpn_gateway     = var.vpc_enable_vpn_gateway

  # NAT Gateway
  enable_nat_gateway     = var.vpc_enable_nat_gateway
  single_nat_gateway     = var.vpc_single_nat_gateway
  one_nat_gateway_per_az = var.vpc_one_nat_gateway_per_az

  # Subnet(s)
  database_subnets                = lookup(var.vpc_database_subnet_cidr, var.region, [])
  database_subnet_suffix          = var.vpc_database_subnet_suffix
  database_subnet_tags            = var.vpc_database_subnet_tags
  create_database_subnet_group    = var.vpc_create_database_subnet_group

  elasticache_subnets             = lookup(var.vpc_elasticache_subnet_cidr, var.region, [])
  elasticache_subnet_suffix       = var.vpc_elasticache_subnet_suffix
  elasticache_subnet_tags         = var.vpc_elasticache_subnet_tags
  create_elasticache_subnet_group = var.vpc_create_elasticache_subnet_group

  intra_subnets                   = lookup(var.vpc_intra_subnet_cidr, var.region, [])
  intra_subnet_suffix             = var.vpc_intra_subnet_suffix
  intra_subnet_tags               = var.vpc_intra_subnet_tags

  private_subnets                 = lookup(var.vpc_private_subnet_cidr, var.region, [])
  private_subnet_suffix           = var.vpc_private_subnet_suffix
  private_subnet_tags             = var.vpc_private_subnet_tags

  public_subnets                  = lookup(var.vpc_public_subnet_cidr, var.region, [])
  public_subnet_suffix            = var.vpc_public_subnet_suffix
  public_subnet_tags              = var.vpc_public_subnet_tags

  redshift_subnets                = lookup(var.vpc_redshift_subnet_cidr, var.region, [])
  redshift_subnet_suffix          = var.vpc_redshift_subnet_suffix
  redshift_subnet_tags            = var.vpc_redshift_subnet_tags
  create_redshift_subnet_group    = var.vpc_create_redshift_subnet_group 

  # Flow Logs
  create_flow_log_cloudwatch_iam_role       = true
  create_flow_log_cloudwatch_log_group      = true
  enable_flow_log                           = true
  flow_log_traffic_type                     = "ALL"
  flow_log_destination_type                 = "cloud-watch-logs"
  flow_log_cloudwatch_log_group_name_prefix = "/aws/vpc/${var.vpc_name}/flow/"
  flow_log_cloudwatch_log_group_retention_in_days = var.vpc_flow_log_cloudwatch_log_group_retention

  # Tag(s)
  tags = local.tags 
}

################################################################################
# VPC Security Groups Module(s)
################################################################################
module "transit_gateway_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "transit-gateway-sg"
  description = "Security group for AWS Transit Gateway" 
  vpc_id      = module.vpc.vpc_id 
  
  egress_with_cidr_blocks = [
    {
      description = "Allow All Outbound Traffic"
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  ingress_with_cidr_blocks = [
    {
      description = "Allow All Internal Traffic"
      rule        = "all-all"
      cidr_blocks = "10.0.0.0/8"
    },
    {
      description = "Allow All Internal Traffic"
      rule        = "all-all"
      cidr_blocks = "172.16.0.0/12"
    },
    {
      description = "Allow All Internal Traffic"
      rule        = "all-all"
      cidr_blocks = "192.168.0.0/16"
    }
  ] 
  
  # Tag(s)
  tags = local.tags 
}

module "systems_manager_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "systems-manager-sg"
  description = "Security group for AWS Systems Manager" 
  vpc_id      = module.vpc.vpc_id 
  
  ingress_with_cidr_blocks = [
    {
      description = "Allow SSL Traffic - VPC Local"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = module.vpc.vpc_cidr_block
    }
  ] 
  
  # Tag(s)
  tags = local.tags 
}

module "route53_resolver_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "route53-resolver-sg"
  description = "Security group for AWS Route53 Resolver" 
  vpc_id      = module.vpc.vpc_id 
  
  egress_with_cidr_blocks = [
    {
      description = "Allow All Outbound Traffic"
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  ingress_with_cidr_blocks = [
    {
      description = "Allow All Traffic on Port 53"
      from_port   = 53
      to_port     = 53
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ] 
  
  # Tag(s)
  tags = local.tags 
}


################################################################################
# VPC Routes Module
################################################################################


################################################################################
# VPC Endpoints Module
################################################################################
