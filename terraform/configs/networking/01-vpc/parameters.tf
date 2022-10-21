################################################################################
# SSM Parameters: Static values (arguments)
################################################################################
resource "aws_ssm_parameter" "azs" {
  description = "A list of availability zones specified as argument to this module"
  name        = "/infra/${var.environment}/networking/vpc_availability_zones"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.azs))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "name" {
  description = "The name of the VPC specified as argument to this module"
  name        = "/infra/${var.environment}/networking/vpc_name"
  type        = "String"
  value       = module.vpc.name

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

################################################################################
# SSM Parameters: VPC 
################################################################################
resource "aws_ssm_parameter" "vpc_id" {
  description = "The ID of the VPC"
  name        = "/infra/${var.environment}/networking/vpc_id"
  type        = "String"
  value       = module.vpc.vpc_id

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "vpc_arn" {
  description = "The ARN of the VPC"
  name        = "/infra/${var.environment}/networking/vpc_arn"
  type        = "String"
  value       = module.vpc.vpc_arn

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  name        = "/infra/${var.environment}/networking/vpc_cidr_block"
  type        = "String"
  value       = module.vpc.vpc_cidr_block

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  name        = "/infra/${var.environment}/networking/default_security_group_id"
  type        = "String"
  value       = module.vpc.default_security_group_id

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "default_network_acl_id" {
  description = "The ID of the default network ACL"
  name        = "/infra/${var.environment}/networking/default_network_acl_id"
  type        = "String"
  value       = module.vpc.default_network_acl_id

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "default_route_table_id" {
  description = "The ID of the default route table"
  name        = "/infra/${var.environment}/networking/default_route_table_id"
  type        = "String"
  value       = module.vpc.default_route_table_id

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "vpc_instance_tenancy" {
  description = "Tenancy of instances spin up within VPC"
  name        = "/infra/${var.environment}/networking/vpc_instance_tenancy"
  type        = "String"
  value       = module.vpc.vpc_instance_tenancy

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "vpc_enable_dns_support" {
  description = "Whether or not the VPC has DNS support"
  name        = "/infra/${var.environment}/networking/vpc_enable_dns_support"
  type        = "String"
  value       = var.vpc_enable_dns_support

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "vpc_enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  name        = "/infra/${var.environment}/networking/vpc_enable_dns_hostnames"
  type        = "String"
  value       = var.vpc_enable_dns_hostnames

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC"
  name        = "/infra/${var.environment}/networking/vpc_main_route_table_id"
  type        = "String"
  value       = module.vpc.vpc_main_route_table_id

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "vpc_ipv6_association_id" {
  count       = local.create_related_ipv6_resources ? 1 : 0

  description = "The association ID for the IPv6 CIDR block"
  name        = "/infra/${var.environment}/networking/vpc_ipv6_association_id"
  type        = "String"
  value       = module.vpc.vpc_ipv6_association_id

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "vpc_ipv6_cidr_block" {
  count       = local.create_related_ipv6_resources ? 1 : 0

  description = "The IPv6 CIDR block"
  name        = "/infra/${var.environment}/networking/vpc_ipv6_cidr_block"
  type        = "String"
  value       = module.vpc.vpc_ipv6_cidr_block

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "vpc_secondary_cidr_blocks" {
  count       = local.create_related_secondary_cidr_resources ? 1 : 0

  description = "List of secondary CIDR blocks of the VPC"
  name        = "/infra/${var.environment}/networking/vpc_secondary_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.vpc_secondary_cidr_blocks))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "vpc_owner_id" {
  description = "The ID of the AWS account that owns the VPC"
  name        = "/infra/${var.environment}/networking/vpc_owner_id"
  type        = "String"
  value       = module.vpc.vpc_owner_id

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

################################################################################
# SSM Parameters: Subnet (Private) 
################################################################################
resource "aws_ssm_parameter" "private_subnet_ids" {
  count       = local.create_related_private_subnet_resources ? 1 : 0

  description = "List of IDs of private subnets"
  name        = "/infra/${var.environment}/networking/private_subnet_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.private_subnets)) 

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "private_subnet_arns" {
  count       = local.create_related_private_subnet_resources ? 1 : 0

  description = "List of ARNs of private subnets"
  name        = "/infra/${var.environment}/networking/private_subnet_arns"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.private_subnet_arns))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "private_subnets_cidr_blocks" {
  count       = local.create_related_private_subnet_resources ? 1 : 0

  description = "List of cidr_blocks of private subnets"
  name        = "/infra/${var.environment}/networking/private_subnets_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.private_subnets_cidr_blocks))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "private_subnets_ipv6_cidr_blocks" {
  count       = local.create_related_ipv6_resources ? 1 : 0

  description = "List of IPv6 cidr_blocks of private subnets in an IPv6 enabled VPC"
  name        = "/infra/${var.environment}/networking/private_subnets_ipv6_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.private_subnets_ipv6_cidr_blocks))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "private_route_table_ids" {
  count       = local.create_related_private_subnet_resources ? 1 : 0

  description = "List of IDs of private route tables"
  name        = "/infra/${var.environment}/networking/private_route_table_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.private_route_table_ids))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "private_nat_gateway_route_ids" {
  count       = local.create_related_private_subnet_resources && local.create_related_nat_gateway_resources ? 1 : 0

  description = "List of IDs of the private nat gateway route"
  name        = "/infra/${var.environment}/networking/private_nat_gateway_route_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.private_nat_gateway_route_ids))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "private_nat_gateway_route_ids" {
  count       = local.create_related_private_subnet_resources && local.create_related_nat_gateway_resources ? 1 : 0

  description = "List of IDs of the private nat gateway route"
  name        = "/infra/${var.environment}/networking/private_nat_gateway_route_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.private_nat_gateway_route_ids))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "private_route_table_association_ids" {
  count       = local.create_related_private_subnet_resources ? 1 : 0

  description = "List of IDs of the private route table association"
  name        = "/infra/${var.environment}/networking/private_route_table_association_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.private_route_table_association_ids))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

################################################################################
# SSM Parameters: Subnet (Public) 
################################################################################
resource "aws_ssm_parameter" "public_subnet_ids" {
  count       = local.create_related_public_subnet_resources ? 1 : 0

  description = "List of IDs of public subnets"
  name        = "/infra/${var.environment}/networking/public_subnet_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.public_subnets))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "public_subnet_arns" {
  count       = local.create_related_public_subnet_resources ? 1 : 0

  description = "List of ARNs of public subnets"
  name        = "/infra/${var.environment}/networking/public_subnet_arns"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.public_subnet_arns))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "public_subnets_cidr_blocks" {
  count       = local.create_related_public_subnet_resources ? 1 : 0

  description = "List of cidr_blocks of public subnets"
  name        = "/infra/${var.environment}/networking/public_subnets_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.public_subnets_cidr_blocks)) 

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "public_subnets_ipv6_cidr_blocks" {
  count       = local.create_related_ipv6_resources ? 1 : 0

  description = "List of IPv6 cidr_blocks of public subnets in an IPv6 enabled VPC"
  name        = "/infra/${var.environment}/networking/public_subnets_ipv6_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.public_subnets_ipv6_cidr_blocks))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "public_route_table_ids" {
  count       = local.create_related_public_subnet_resources ? 1 : 0

  description = "List of IDs of public route tables"
  name        = "/infra/${var.environment}/networking/public_route_table_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.public_route_table_ids))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "public_internet_gateway_route_id" {
  count       = local.create_related_internet_gateway_resources ? 1 : 0

  description = "ID of the internet gateway route"
  name        = "/infra/${var.environment}/networking/public_internet_gateway_route_id"
  type        = "String"
  value       = module.vpc.public_internet_gateway_route_id

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "public_route_table_association_ids" {
  count       = length(module.vpc.public_route_table_association_ids) > 0 ? 1 : 0

  description = "List of IDs of the public route table association"
  name        = "/infra/${var.environment}/networking/public_route_table_association_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.public_route_table_association_ids))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

################################################################################
# SSM Parameters: Subnet (Database) 
################################################################################
resource "aws_ssm_parameter" "database_subnet_ids" {
  count       = local.create_related_database_subnet_resources ? 1 : 0

  description = "List of IDs of database subnets"
  name        = "/infra/${var.environment}/networking/database_subnet_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.database_subnets))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "database_subnet_arns" {
  count       = local.create_related_database_subnet_resources ? 1 : 0

  description = "List of ARNs of database subnets"
  name        = "/infra/${var.environment}/networking/database_subnet_arns"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.database_subnet_arns))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "database_subnets_cidr_blocks" {
  count       = local.create_related_database_subnet_resources ? 1 : 0

  description = "List of cidr_blocks of database subnets"
  name        = "/infra/${var.environment}/networking/database_subnets_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.database_subnets_cidr_blocks)) 

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "database_subnets_ipv6_cidr_blocks" {
  count       = local.create_related_ipv6_resources ? 1 : 0

  description = "List of IPv6 cidr_blocks of database subnets in an IPv6 enabled VPC"
  name        = "/infra/${var.environment}/networking/database_subnets_ipv6_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.database_subnets_ipv6_cidr_blocks))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}
resource "aws_ssm_parameter" "database_route_table_ids" {
  count       = local.create_related_database_subnet_resources ? 1 : 0

  description = "List of IDs of database route tables"
  name        = "/infra/${var.environment}/networking/database_route_table_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.database_route_table_ids))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "database_route_table_association_ids" {
  count       = local.create_related_database_subnet_resources ? 1 : 0

  description = "List of IDs of the database route table association"
  name        = "/infra/${var.environment}/networking/database_route_table_association_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.database_route_table_association_ids))
  
  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

################################################################################
# SSM Parameters: Subnet (Redshift) 
################################################################################
resource "aws_ssm_parameter" "redshift_subnet_ids" {
  count       = local.create_related_redshift_subnet_resources ? 1 : 0

  description = "List of IDs of redshift subnets"
  name        = "/infra/${var.environment}/networking/redshift_subnet_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.redshift_subnets))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "redshift_subnet_arns" {
  count       = local.create_related_redshift_subnet_resources ? 1 : 0

  description = "List of ARNs of redshift subnets"
  name        = "/infra/${var.environment}/networking/redshift_subnet_arns"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.redshift_subnet_arns))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "redshift_subnet_cidr_blocks" {
  count       = local.create_related_redshift_subnet_resources ? 1 : 0

  description = "List of cidr_blocks of redshift subnets"
  name        = "/infra/${var.environment}/networking/redshift_subnet_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.redshift_subnets_cidr_blocks)) 

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "redshift_subnet_ipv6_cidr_blocks" {
  count       = local.create_related_ipv6_resources ? 1 : 0

  description = "List of IPv6 cidr_blocks of redshift subnets in an IPv6 enabled VPC"
  name        = "/infra/${var.environment}/networking/redshift_subnet_ipv6_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.redshift_subnets_ipv6_cidr_blocks))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "redshift_route_table_ids" {
  count       = local.create_related_redshift_subnet_resources ? 1 : 0

  description = "List of IDs of redshift route tables"
  name        = "/infra/${var.environment}/networking/redshift_route_table_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.redshift_route_table_ids))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "redshift_route_table_association_ids" {
  count       = local.create_related_redshift_subnet_resources ? 1 : 0

  description = "List of IDs of the redshift route table association"
  name        = "/infra/${var.environment}/networking/redshift_route_table_association_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.redshift_route_table_association_ids))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "redshift_public_route_table_association_ids" {
  count       = length(module.vpc.redshift_public_route_table_association_ids) > 0 ? 1 : 0

  description = "List of IDs of the public redshidt route table association"
  name        = "/infra/${var.environment}/networking/redshift_public_route_table_association_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.redshift_public_route_table_association_ids))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

################################################################################
# SSM Parameters: Subnet (Elasticache) 
################################################################################
resource "aws_ssm_parameter" "elasticache_subnet_ids" {
  count       = local.create_related_elasticache_subnet_resources ? 1 : 0

  description = "List of IDs of elasticache subnets"
  name        = "/infra/${var.environment}/networking/elasticache_subnet_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.elasticache_subnets))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "elasticache_subnet_arns" {
  count       = local.create_related_elasticache_subnet_resources ? 1 : 0

  description = "List of ARNs of elasticache subnets"
  name        = "/infra/${var.environment}/networking/elasticache_subnet_arns"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.elasticache_subnet_arns))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "elasticache_subnet_cidr_blocks" {
  count       = local.create_related_elasticache_subnet_resources ? 1 : 0

  description = "List of cidr_blocks of elasticache subnets"
  name        = "/infra/${var.environment}/networking/elasticache_subnet_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.elasticache_subnets_cidr_blocks))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "elasticache_subnet_ipv6_cidr_blocks" {
  count       = local.create_related_ipv6_resources ? 1 : 0

  description = "List of IPv6 cidr_blocks of elasticache subnets in an IPv6 enabled VPC"
  name        = "/infra/${var.environment}/networking/elasticache_subnet_ipv6_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.elasticache_subnets_cidr_blocks))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "elasticache_route_table_ids" {
  count       = local.create_related_elasticache_subnet_resources ? 1 : 0

  description = "List of IDs of elasticache route tables"
  name        = "/infra/${var.environment}/networking/elasticache_route_table_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.elasticache_route_table_ids))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "elasticache_route_table_association_ids" {
  count       = length(module.vpc.elasticache_route_table_association_ids) > 0 ? 1 : 0

  description = "List of IDs of the elasticache route table association"
  name        = "/infra/${var.environment}/networking/elasticache_route_table_association_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.elasticache_route_table_association_ids))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

################################################################################
# SSM Parameters: Subnet (Intra) 
################################################################################
resource "aws_ssm_parameter" "intra_subnet_ids" {
  count       = local.create_related_intra_subnet_resources ? 1 : 0

  description = "List of IDs of intra subnets"
  name        = "/infra/${var.environment}/networking/intra_subnet_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.intra_subnets))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "intra_subnet_arns" {
  count       = local.create_related_intra_subnet_resources ? 1 : 0

  description = "List of ARNs of intra subnets"
  name        = "/infra/${var.environment}/networking/intra_subnet_arns"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.intra_subnet_arns))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "intra_subnets_cidr_blocks" {
  count       = local.create_related_intra_subnet_resources ? 1 : 0

  description = "List of cidr_blocks of intra subnets"
  name        = "/infra/${var.environment}/networking/intra_subnets_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.intra_subnets_cidr_blocks))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "intra_subnets_ipv6_cidr_blocks" {
  count       = local.create_related_ipv6_resources ? 1 : 0

  description = "List of IPv6 cidr_blocks of intra subnets in an IPv6 enabled VPC"
  name        = "/infra/${var.environment}/networking/intra_subnets_ipv6_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.intra_subnets_ipv6_cidr_blocks))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "intra_route_table_ids" {
  count       = local.create_related_intra_subnet_resources ? 1 : 0

  description = "List of IDs of intra route tables"
  name        = "/infra/${var.environment}/networking/intra_route_table_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.intra_route_table_ids))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "intra_route_table_association_ids" {
  count       = length(module.vpc.intra_route_table_association_ids) > 0 ? 1 : 0

  description = "List of IDs of the intra route table association"
  name        = "/infra/${var.environment}/networking/intra_route_table_association_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.intra_route_table_association_ids))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

################################################################################
# SSM Parameters: Additional Attributes 
################################################################################
resource "aws_ssm_parameter" "dhcp_options_id" {
  count       = length(module.vpc.dhcp_options_id) > 0 ? 1 : 0

  description = "The ID of the DHCP options"
  name        = "/infra/${var.environment}/networking/dhcp_options_id"
  type        = "String"
  value       = join(",", tolist(module.vpc.dhcp_options_id))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "nat_ids" {
  count       = length(module.vpc.public_route_table_association_ids) > 0 ? 1 : 0

  description = "List of allocation ID of Elastic IPs created for AWS NAT Gateway"
  name        = "/infra/${var.environment}/networking/nat_ids"
  type        = "String"
  value       = join(",", tolist(module.vpc.public_route_table_association_ids))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "nat_public_ips" {
  count       = length(module.vpc.nat_public_ips) > 0 ? 1 : 0

  description = "List of public Elastic IPs created for AWS NAT Gateway"
  name        = "/infra/${var.environment}/networking/nat_public_ips"
  type        = "String"
  value       = join(",", tolist(module.vpc.nat_public_ips))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "natgw_ids" {
  count       = length(module.vpc.natgw_ids) > 0 ? 1 : 0

  description = "List of NAT Gateway IDs"
  name        = "/infra/${var.environment}/networking/natgw_ids"
  type        = "String"
  value       = join(",", tolist(module.vpc.natgw_ids))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "igw_id" {
  count       = local.create_related_internet_gateway_resources ? 1 : 0

  description = "The ID of the Internet Gateway"
  name        = "/infra/${var.environment}/networking/igw_id"
  type        = "String"
  value       = module.vpc.igw_id

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "igw_arn" {
  count       = local.create_related_internet_gateway_resources ? 1 : 0

  description = "The ARN of the Internet Gateway"
  name        = "/infra/${var.environment}/networking/igw_arn"
  type        = "String"
  value       = module.vpc.igw_arn

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "egress_only_internet_gateway_id" {
  count       = length(module.vpc.egress_only_internet_gateway_id) > 0 ? 1 : 0

  description = "The ID of the egress only Internet Gateway"
  name        = "/infra/${var.environment}/networking/egress_only_internet_gateway_id"
  type        = "String"
  value       = join(",", tolist(module.vpc.egress_only_internet_gateway_id))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "cgw_ids" {
  count       = length(module.vpc.cgw_ids) > 0 ? 1 : 0

  description = "List of IDs of Customer Gateway"
  name        = "/infra/${var.environment}/networking/cgw_ids"
  type        = "String"
  value       = join(",", tolist(module.vpc.cgw_ids))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "cgw_arns" {
  count       = length(module.vpc.cgw_arns) > 0 ? 1 : 0

  description = "List of ARNs of Customer Gateway"
  name        = "/infra/${var.environment}/networking/cgw_arns"
  type        = "String"
  value       = join(",", tolist(module.vpc.cgw_arns)) 

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "vgw_id" {
  count       = local.create_related_vpn_gateway_resources ? 1 : 0

  description = "The ID of the VPN Gateway"
  name        = "/infra/${var.environment}/networking/vgw_id"
  type        = "String"
  value       = join(",", tolist(module.vpc.vgw_id))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "vgw_arn" {
  count       = local.create_related_vpn_gateway_resources ? 1 : 0

  description = "The ARN of the VPN Gateway"
  name        = "/infra/${var.environment}/networking/vgw_arn"
  type        = "String"
  value       = join(",", tolist(module.vpc.vgw_arn))

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

# VPC flow log
resource "aws_ssm_parameter" "vpc_flow_log_id" {
  count       = local.create_related_flow_log_resources ? 1 : 0

  description = "The ID of the Flow Log resource"
  name        = "/infra/${var.environment}/networking/vpc_flow_log_id"
  type        = "String"
  value       = module.vpc.vpc_flow_log_id

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "vpc_flow_log_destination_arn" {
  count       = local.create_related_flow_log_resources ? 1 : 0

  description = "The ARN of the destination for VPC Flow Logs"
  name        = "/infra/${var.environment}/networking/vpc_flow_log_destination_arn"
  type        = "String"
  value       = module.vpc.vpc_flow_log_destination_arn

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "vpc_flow_log_destination_type" {
  count       = local.create_related_flow_log_resources ? 1 : 0

  description = "The type of the destination for VPC Flow Logs"
  name        = "/infra/${var.environment}/networking/vpc_flow_log_destination_type"
  type        = "String"
  value       = module.vpc.vpc_flow_log_destination_type

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}

resource "aws_ssm_parameter" "vpc_flow_log_cloudwatch_iam_role_arn" {
  count       = local.create_related_flow_log_resources ? 1 : 0

  description = "The ARN of the IAM role used when pushing logs to Cloudwatch log group"
  name        = "/infra/${var.environment}/networking/vpc_flow_log_cloudwatch_iam_role_arn"
  type        = "String"
  value       = module.vpc.vpc_flow_log_cloudwatch_iam_role_arn

  # Tag(s)
  tags        = local.tags 

  # Dependency(s)
  depends_on  = [module.vpc]
}
