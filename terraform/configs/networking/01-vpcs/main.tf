locals {
  tags = merge(
    { namespace: var.namespace },
    { environment: var.environment },
    { region: var.region },
    { provisioner: var.provisioner }
  )
}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = lookup(var.vpc_cidr, var.region)
  azs  = lookup(var.vpc_availability_zones, var.region, null)
  
  enable_dns_hostnames   = var.vpc_enable_dns_hostnames 
  enable_vpn_gateway     = var.vpc_enable_vpn_gateway
  
  enable_nat_gateway     = var.vpc_enable_nat_gateway
  single_nat_gateway     = var.vpc_sinlge_nat_gateway
  one_nat_gateway_per_az = var.vpc_one_nat_gateway_per_az

  database_subnets                = lookup(var.vpc_database_subnet_cidr, var.region, null)
  database_subnet_suffix          = var.vpc_database_subnet_suffix
  create_database_subnet_group    = var.vpc_create_database_subnet_group

  elasticache_subnets             = lookup(var.vpc_elasticache_subnet_cidr, var.regaion, null)
  elasticache_subnet_suffix       = var.vpc_elasticache_subnet_suffix
  create_elasticache_subnet_group = var.vpc_create_elasticache_subnet_group

  intra_subnets                   = lookup(var.vpc_intra_subnet_cidr, var.region, null)
  intra_subnet_suffix             = var.vpc_intra_subnet_suffix
  
  private_subnets                 = lookup(var.vpc_private_subnet_cidr, var.region, null)
  private_subnet_suffix           = var.vpc_private_subnet_suffix
  
  public_subnets                  = lookup(var.vpc_public_subnet_cidr, var.region, null)
  public_subnet_suffix            = var.vpc_public_subnet_suffix

  redshift_subnets                = lookup(var.vpc_redshift_subnet_cidr, var.region, null)
  redshift_subnet_suffix          = var.vpc_redshift_subnet_suffix
  create_redshift_subnet_group    = var.vpc_create_redshift_subnet_group 

  tags = local.tags 
}