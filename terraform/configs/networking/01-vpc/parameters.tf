resource "aws_ssm_parameter" "vpc_id" {
  count       = length(module.vpc.vpc_id) > 0 ? 1 : 0

  description = "The ID of the VPC"
  name        = "/infra/${var.environment}/networking/vpc_id"
  type        = "String"
  value       = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "vpc_arn" {
  count       = length(module.vpc.vpc_arn) > 0 ? 1 : 0

  description = "The ARN of the VPC"
  name        = "/infra/${var.environment}/networking/vpc_arn"
  type        = "String"
  value       = module.vpc.vpc_arn
}

resource "aws_ssm_parameter" "vpc_cidr_block" {
  count       = length(module.vpc.vpc_cidr_block) > 0 ? 1 : 0

  description = "The CIDR block of the VPC"
  name        = "/infra/${var.environment}/networking/vpc_cidr_block"
  type        = "String"
  value       = module.vpc.vpc_cidr_block
}

resource "aws_ssm_parameter" "default_security_group_id" {
  count       = length(module.vpc.default_security_group_id) > 0 ? 1 : 0

  description = "The ID of the security group created by default on VPC creation"
  name        = "/infra/${var.environment}/networking/default_security_group_id"
  type        = "String"
  value       = module.vpc.default_security_group_id
}

resource "aws_ssm_parameter" "default_network_acl_id" {
  count       = length(module.vpc.default_network_acl_id) > 0 ? 1 : 0

  description = "The ID of the default network ACL"
  name        = "/infra/${var.environment}/networking/default_network_acl_id"
  type        = "String"
  value       = module.vpc.default_network_acl_id
}

resource "aws_ssm_parameter" "default_route_table_id" {
  count       = length(module.vpc.default_route_table_id) > 0 ? 1 : 0

  description = "The ID of the default route table"
  name        = "/infra/${var.environment}/networking/default_route_table_id"
  type        = "String"
  value       = module.vpc.default_route_table_id
}

resource "aws_ssm_parameter" "vpc_instance_tenancy" {
  count       = length(module.vpc.vpc_instance_tenancy) > 0 ? 1 : 0

  description = "Tenancy of instances spin up within VPC"
  name        = "/infra/${var.environment}/networking/vpc_instance_tenancy"
  type        = "String"
  value       = module.vpc.vpc_instance_tenancy
}

resource "aws_ssm_parameter" "vpc_enable_dns_support" {
  count       = length(tostring(module.vpc.vpc_enable_dns_support)) > 0 ? 1 : 0

  description = "Whether or not the VPC has DNS support"
  name        = "/infra/${var.environment}/networking/vpc_enable_dns_support"
  type        = "String"
  value       = module.vpc.vpc_enable_dns_support
}

resource "aws_ssm_parameter" "vpc_enable_dns_hostnames" {
  count       = length(tostring(module.vpc.vpc_enable_dns_hostnames)) > 0 ? 1 : 0

  description = "Whether or not the VPC has DNS hostname support"
  name        = "/infra/${var.environment}/networking/vpc_enable_dns_hostnames"
  type        = "String"
  value       = module.vpc.vpc_enable_dns_hostnames
}

resource "aws_ssm_parameter" "vpc_main_route_table_id" {
  count       = length(module.vpc.vpc_main_route_table_id) > 0 ? 1 : 0

  description = "The ID of the main route table associated with this VPC"
  name        = "/infra/${var.environment}/networking/vpc_main_route_table_id"
  type        = "String"
  value       = module.vpc.vpc_main_route_table_id
}

resource "aws_ssm_parameter" "vpc_ipv6_association_id" {
  count       = length(module.vpc.vpc_ipv6_association_id) > 0 ? 1 : 0

  description = "The association ID for the IPv6 CIDR block"
  name        = "/infra/${var.environment}/networking/vpc_ipv6_association_id"
  type        = "String"
  value       = module.vpc.vpc_ipv6_association_id
}

resource "aws_ssm_parameter" "vpc_ipv6_cidr_block" {
  count       = length(module.vpc.vpc_ipv6_cidr_block) > 0 ? 1 : 0

  description = "The IPv6 CIDR block"
  name        = "/infra/${var.environment}/networking/vpc_ipv6_cidr_block"
  type        = "String"
  value       = module.vpc.vpc_ipv6_cidr_block
}

resource "aws_ssm_parameter" "vpc_secondary_cidr_blocks" {
  count       = length(module.vpc.vpc_secondary_cidr_blocks) > 0 ? 1 : 0

  description = "List of secondary CIDR blocks of the VPC"
  name        = "/infra/${var.environment}/networking/vpc_secondary_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.vpc_secondary_cidr_blocks))
}

resource "aws_ssm_parameter" "vpc_owner_id" {
  count       = length(module.vpc.vpc_owner_id) > 0 ? 1 : 0

  description = "The ID of the AWS account that owns the VPC"
  name        = "/infra/${var.environment}/networking/vpc_owner_id"
  type        = "String"
  value       = module.vpc.vpc_owner_id
}

resource "aws_ssm_parameter" "private_subnets" {
  count       = length(module.vpc.private_subnets) > 0 ? 1 : 0

  description = "List of IDs of private subnets"
  name        = "/infra/${var.environment}/networking/private_subnets"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.private_subnets)) 
}

resource "aws_ssm_parameter" "private_subnet_arns" {
  count       = length(module.vpc.private_subnet_arns) > 0 ? 1 : 0

  description = "List of ARNs of private subnets"
  name        = "/infra/${var.environment}/networking/private_subnet_arns"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.private_subnet_arns))
}

resource "aws_ssm_parameter" "private_subnets_cidr_blocks" {
  count       = length(module.vpc.private_subnets_cidr_blocks) > 0 ? 1 : 0

  description = "List of cidr_blocks of private subnets"
  name        = "/infra/${var.environment}/networking/private_subnets_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.private_subnets_cidr_blocks))
}

resource "aws_ssm_parameter" "private_subnets_ipv6_cidr_blocks" {
  count       = length(module.vpc.private_subnets_ipv6_cidr_blocks) > 0 ? 1 : 0

  description = "List of IPv6 cidr_blocks of private subnets in an IPv6 enabled VPC"
  name        = "/infra/${var.environment}/networking/private_subnets_ipv6_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.private_subnets_ipv6_cidr_blocks))
}

resource "aws_ssm_parameter" "public_subnets" {
  count       = length(module.vpc.public_subnets) > 0 ? 1 : 0

  description = "List of IDs of public subnets"
  name        = "/infra/${var.environment}/networking/public_subnets"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.public_subnets))
}

resource "aws_ssm_parameter" "public_subnet_arns" {
  count       = length(module.vpc.public_subnet_arns) > 0 ? 1 : 0

  description = "List of ARNs of public subnets"
  name        = "/infra/${var.environment}/networking/public_subnet_arns"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.public_subnet_arns))
}

resource "aws_ssm_parameter" "public_subnets_cidr_blocks" {
  count       = length(module.vpc.public_subnets_cidr_blocks) > 0 ? 1 : 0

  description = "List of cidr_blocks of public subnets"
  name        = "/infra/${var.environment}/networking/public_subnets_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.public_subnets_cidr_blocks)) 
}

resource "aws_ssm_parameter" "public_subnets_ipv6_cidr_blocks" {
  count       = length(module.vpc.public_subnets_ipv6_cidr_blocks) > 0 ? 1 : 0

  description = "List of IPv6 cidr_blocks of public subnets in an IPv6 enabled VPC"
  name        = "/infra/${var.environment}/networking/public_subnets_ipv6_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.public_subnets_ipv6_cidr_blocks))
}

resource "aws_ssm_parameter" "outpost_subnets" {
  count       = length(module.vpc.outpost_subnets) > 0 ? 1 : 0

  description = "List of IDs of outpost subnets"
  name        = "/infra/${var.environment}/networking/outpost_subnets"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.outpost_subnets))
}

resource "aws_ssm_parameter" "outpost_subnet_arns" {
  count       = length(module.vpc.outpost_subnet_arns) > 0 ? 1 : 0

  description = "List of ARNs of outpost subnets"
  name        = "/infra/${var.environment}/networking/outpost_subnet_arns"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.outpost_subnet_arns))
}

resource "aws_ssm_parameter" "outpost_subnets_cidr_blocks" {
  count       = length(module.vpc.outpost_subnets_cidr_blocks) > 0 ? 1 : 0

  description = "List of cidr_blocks of outpost subnets"
  name        = "/infra/${var.environment}/networking/outpost_subnets_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.outpost_subnets_cidr_blocks))
}

resource "aws_ssm_parameter" "outpost_subnets_ipv6_cidr_blocks" {
  count       = length(module.vpc.outpost_subnets_ipv6_cidr_blocks) > 0 ? 1 : 0

  description = "List of IPv6 cidr_blocks of outpost subnets in an IPv6 enabled VPC"
  name        = "/infra/${var.environment}/networking/outpost_subnets_ipv6_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.outpost_subnets_ipv6_cidr_blocks))
}

resource "aws_ssm_parameter" "database_subnets" {
  count       = length(module.vpc.database_subnets) > 0 ? 1 : 0

  description = "List of IDs of database subnets"
  name        = "/infra/${var.environment}/networking/database_subnets"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.database_subnets))
}

resource "aws_ssm_parameter" "database_subnet_arns" {
  count       = length(module.vpc.database_subnet_arns) > 0 ? 1 : 0

  description = "List of ARNs of database subnets"
  name        = "/infra/${var.environment}/networking/database_subnet_arns"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.database_subnet_arns))
}

resource "aws_ssm_parameter" "database_subnets_cidr_blocks" {
  count       = length(module.vpc.database_subnets_cidr_blocks) > 0 ? 1 : 0

  description = "List of cidr_blocks of database subnets"
  name        = "/infra/${var.environment}/networking/database_subnets_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.database_subnets_cidr_blocks)) 
}

resource "aws_ssm_parameter" "database_subnets_ipv6_cidr_blocks" {
  count       = length(module.vpc.database_subnets_ipv6_cidr_blocks) > 0 ? 1 : 0

  description = "List of IPv6 cidr_blocks of database subnets in an IPv6 enabled VPC"
  name        = "/infra/${var.environment}/networking/database_subnets_ipv6_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.database_subnets_ipv6_cidr_blocks))
}

resource "aws_ssm_parameter" "database_subnet_group" {
  count       = length(module.vpc.database_subnet_group) > 0 ? 1 : 0

  description = "ID of database subnet group"
  name        = "/infra/${var.environment}/networking/database_subnet_group"
  type        = "String"
  value       = module.vpc.database_subnet_group
}

resource "aws_ssm_parameter" "database_subnet_group_name" {
  count       = length(module.vpc.database_subnet_group_name) > 0 ? 1 : 0

  description = "Name of database subnet group"
  name        = "/infra/${var.environment}/networking/database_subnet_group_name"
  type        = "String"
  value       = module.vpc.database_subnet_group_name
}

resource "aws_ssm_parameter" "redshift_subnets" {
  count       = length(module.vpc.redshift_subnets) > 0 ? 1 : 0

  description = "List of IDs of redshift subnets"
  name        = "/infra/${var.environment}/networking/redshift_subnets"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.redshift_subnets))
}

resource "aws_ssm_parameter" "redshift_subnet_arns" {
  count       = length(module.vpc.redshift_subnet_arns) > 0 ? 1 : 0

  description = "List of ARNs of redshift subnets"
  name        = "/infra/${var.environment}/networking/redshift_subnet_arns"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.redshift_subnet_arns))
}

resource "aws_ssm_parameter" "redshift_subnets_cidr_blocks" {
  count       = length(module.vpc.redshift_subnets_cidr_blocks) > 0 ? 1 : 0

  description = "List of cidr_blocks of redshift subnets"
  name        = "/infra/${var.environment}/networking/redshift_subnets_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.redshift_subnets_cidr_blocks)) 
}

resource "aws_ssm_parameter" "redshift_subnets_ipv6_cidr_blocks" {
  count       = length(module.vpc.redshift_subnets_ipv6_cidr_blocks) > 0 ? 1 : 0

  description = "List of IPv6 cidr_blocks of redshift subnets in an IPv6 enabled VPC"
  name        = "/infra/${var.environment}/networking/redshift_subnets_ipv6_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.redshift_subnets_ipv6_cidr_blocks))
}

resource "aws_ssm_parameter" "redshift_subnet_group" {
  count       = length(module.vpc.redshift_subnet_group) > 0 ? 1 : 0

  description = "ID of redshift subnet group"
  name        = "/infra/${var.environment}/networking/redshift_subnet_group"
  type        = "String"
  value       = module.vpc.redshift_subnet_group
}

resource "aws_ssm_parameter" "elasticache_subnets" {
  count       = length(module.vpc.elasticache_subnets) > 0 ? 1 : 0

  description = "List of IDs of elasticache subnets"
  name        = "/infra/${var.environment}/networking/elasticache_subnets"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.elasticache_subnets))
}

resource "aws_ssm_parameter" "elasticache_subnet_arns" {
  count       = length(module.vpc.elasticache_subnet_arns) > 0 ? 1 : 0

  description = "List of ARNs of elasticache subnets"
  name        = "/infra/${var.environment}/networking/elasticache_subnet_arns"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.elasticache_subnet_arns))
}

resource "aws_ssm_parameter" "elasticache_subnets_cidr_blocks" {
  count       = length(module.vpc.elasticache_subnets_cidr_blocks) > 0 ? 1 : 0

  description = "List of cidr_blocks of elasticache subnets"
  name        = "/infra/${var.environment}/networking/elasticache_subnets_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.elasticache_subnets_cidr_blocks))
}

resource "aws_ssm_parameter" "elasticache_subnets_ipv6_cidr_blocks" {
  count       = length(module.vpc.elasticache_subnets_cidr_blocks) > 0 ? 1 : 0

  description = "List of IPv6 cidr_blocks of elasticache subnets in an IPv6 enabled VPC"
  name        = "/infra/${var.environment}/networking/elasticache_subnets_ipv6_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.elasticache_subnets_cidr_blocks))
}

resource "aws_ssm_parameter" "intra_subnets" {
  count       = length(module.vpc.intra_subnets) > 0 ? 1 : 0

  description = "List of IDs of intra subnets"
  name        = "/infra/${var.environment}/networking/intra_subnets"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.intra_subnets))
}

resource "aws_ssm_parameter" "intra_subnet_arns" {
  count       = length(module.vpc.intra_subnet_arns) > 0 ? 1 : 0

  description = "List of ARNs of intra subnets"
  name        = "/infra/${var.environment}/networking/intra_subnet_arns"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.intra_subnet_arns))
}

resource "aws_ssm_parameter" "intra_subnets_cidr_blocks" {
  count       = length(module.vpc.intra_subnets_cidr_blocks) > 0 ? 1 : 0

  description = "List of cidr_blocks of intra subnets"
  name        = "/infra/${var.environment}/networking/intra_subnets_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.intra_subnets_cidr_blocks))
}

resource "aws_ssm_parameter" "intra_subnets_ipv6_cidr_blocks" {
  count       = length(module.vpc.intra_subnets_ipv6_cidr_blocks) > 0 ? 1 : 0

  description = "List of IPv6 cidr_blocks of intra subnets in an IPv6 enabled VPC"
  name        = "/infra/${var.environment}/networking/intra_subnets_ipv6_cidr_blocks"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.intra_subnets_ipv6_cidr_blocks))
}

resource "aws_ssm_parameter" "elasticache_subnet_group" {
  count       = length(module.vpc.elasticache_subnet_group) > 0 ? 1 : 0

  description = "ID of elasticache subnet group"
  name        = "/infra/${var.environment}/networking/elasticache_subnet_group"
  type        = "String"
  value       = module.vpc.elasticache_subnet_group
}

resource "aws_ssm_parameter" "elasticache_subnet_group_name" {
  count       = length(module.vpc.elasticache_subnet_group_name) > 0 ? 1 : 0

  description = "Name of elasticache subnet group"
  name        = "/infra/${var.environment}/networking/elasticache_subnet_group_name"
  type        = "String"
  value       = module.vpc.elasticache_subnet_group_name
}

resource "aws_ssm_parameter" "public_route_table_ids" {
  count       = length(module.vpc.public_route_table_ids) > 0 ? 1 : 0

  description = "List of IDs of public route tables"
  name        = "/infra/${var.environment}/networking/public_route_table_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.public_route_table_ids))
}

resource "aws_ssm_parameter" "private_route_table_ids" {
  count       = length(module.vpc.private_route_table_ids) > 0 ? 1 : 0

  description = "List of IDs of private route tables"
  name        = "/infra/${var.environment}/networking/private_route_table_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.private_route_table_ids))
}

resource "aws_ssm_parameter" "database_route_table_ids" {
  count       = length(module.vpc.database_route_table_ids) > 0 ? 1 : 0

  description = "List of IDs of database route tables"
  name        = "/infra/${var.environment}/networking/database_route_table_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.database_route_table_ids))
}

resource "aws_ssm_parameter" "redshift_route_table_ids" {
  count       = length(module.vpc.redshift_route_table_ids) > 0 ? 1 : 0

  description = "List of IDs of redshift route tables"
  name        = "/infra/${var.environment}/networking/redshift_route_table_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.redshift_route_table_ids))
}

resource "aws_ssm_parameter" "elasticache_route_table_ids" {
  count       = length(module.vpc.elasticache_route_table_ids) > 0 ? 1 : 0

  description = "List of IDs of elasticache route tables"
  name        = "/infra/${var.environment}/networking/elasticache_route_table_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.elasticache_route_table_ids))
}

resource "aws_ssm_parameter" "intra_route_table_ids" {
  count       = length(module.vpc.intra_route_table_ids) > 0 ? 1 : 0

  description = "List of IDs of intra route tables"
  name        = "/infra/${var.environment}/networking/intra_route_table_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.intra_route_table_ids))
}

resource "aws_ssm_parameter" "public_internet_gateway_route_id" {
  count       = length(module.vpc.public_internet_gateway_route_id) > 0 ? 1 : 0

  description = "ID of the internet gateway route"
  name        = "/infra/${var.environment}/networking/public_internet_gateway_route_id"
  type        = "String"
  value       = module.vpc.public_internet_gateway_route_id
}

resource "aws_ssm_parameter" "public_internet_gateway_ipv6_route_id" {
  count       = length(module.vpc.public_internet_gateway_ipv6_route_id) > 0 ? 1 : 0

  description = "ID of the IPv6 internet gateway route"
  name        = "/infra/${var.environment}/networking/public_internet_gateway_ipv6_route_id"
  type        = "String"
  value       = module.vpc.public_internet_gateway_ipv6_route_id
}

resource "aws_ssm_parameter" "database_internet_gateway_route_id" {
  count       = length(module.vpc.database_internet_gateway_route_id) > 0 ? 1 : 0

  description = "ID of the database internet gateway route"
  name        = "/infra/${var.environment}/networking/database_internet_gateway_route_id"
  type        = "String"
  value       = join(",", tolist(module.vpc.database_internet_gateway_route_id))
}

resource "aws_ssm_parameter" "database_nat_gateway_route_ids" {
  count       = length(module.vpc.database_nat_gateway_route_ids) > 0 ? 1 : 0

  description = "List of IDs of the database nat gateway route"
  name        = "/infra/${var.environment}/networking/database_nat_gateway_route_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.database_nat_gateway_route_ids))
}

resource "aws_ssm_parameter" "database_ipv6_egress_route_id" {
  count       = length(module.vpc.database_ipv6_egress_route_id) > 0 ? 1 : 0

  description = "ID of the database IPv6 egress route"
  name        = "/infra/${var.environment}/networking/database_ipv6_egress_route_id"
  type        = "String"
  value       = module.vpc.database_ipv6_egress_route_id
}

resource "aws_ssm_parameter" "private_nat_gateway_route_ids" {
  count       = length(module.vpc.private_nat_gateway_route_ids) > 0 ? 1 : 0

  description = "List of IDs of the private nat gateway route"
  name        = "/infra/${var.environment}/networking/private_nat_gateway_route_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.private_nat_gateway_route_ids))
}

resource "aws_ssm_parameter" "private_ipv6_egress_route_ids" {
  count       = length(module.vpc.private_ipv6_egress_route_ids) > 0 ? 1 : 0

  description = "List of IDs of the ipv6 egress route"
  name        = "/infra/${var.environment}/networking/private_ipv6_egress_route_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.private_ipv6_egress_route_ids))
}

resource "aws_ssm_parameter" "private_route_table_association_ids" {
  count       = length(module.vpc.private_route_table_association_ids) > 0 ? 1 : 0

  description = "List of IDs of the private route table association"
  name        = "/infra/${var.environment}/networking/private_route_table_association_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.private_route_table_association_ids))
}

resource "aws_ssm_parameter" "database_route_table_association_ids" {
  count       = length(module.vpc.database_route_table_association_ids) > 0 ? 1 : 0

  description = "List of IDs of the database route table association"
  name        = "/infra/${var.environment}/networking/database_route_table_association_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.database_route_table_association_ids))
}

resource "aws_ssm_parameter" "redshift_route_table_association_ids" {
  count       = length(module.vpc.redshift_route_table_association_ids) > 0 ? 1 : 0

  description = "List of IDs of the redshift route table association"
  name        = "/infra/${var.environment}/networking/redshift_route_table_association_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.redshift_route_table_association_ids))
}

resource "aws_ssm_parameter" "redshift_public_route_table_association_ids" {
  count       = length(module.vpc.redshift_public_route_table_association_ids) > 0 ? 1 : 0

  description = "List of IDs of the public redshidt route table association"
  name        = "/infra/${var.environment}/networking/redshift_public_route_table_association_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.redshift_public_route_table_association_ids))
}

resource "aws_ssm_parameter" "elasticache_route_table_association_ids" {
  count       = length(module.vpc.elasticache_route_table_association_ids) > 0 ? 1 : 0

  description = "List of IDs of the elasticache route table association"
  name        = "/infra/${var.environment}/networking/elasticache_route_table_association_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.elasticache_route_table_association_ids))
}

resource "aws_ssm_parameter" "intra_route_table_association_ids" {
  count       = length(module.vpc.intra_route_table_association_ids) > 0 ? 1 : 0

  description = "List of IDs of the intra route table association"
  name        = "/infra/${var.environment}/networking/intra_route_table_association_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.intra_route_table_association_ids))
}

resource "aws_ssm_parameter" "public_route_table_association_ids" {
  count       = length(module.vpc.public_route_table_association_ids) > 0 ? 1 : 0

  description = "List of IDs of the public route table association"
  name        = "/infra/${var.environment}/networking/public_route_table_association_ids"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.public_route_table_association_ids))
}

resource "aws_ssm_parameter" "dhcp_options_id" {
  count       = length(module.vpc.dhcp_options_id) > 0 ? 1 : 0

  description = "The ID of the DHCP options"
  name        = "/infra/${var.environment}/networking/dhcp_options_id"
  type        = "String"
  value       = join(",", tolist(module.vpc.dhcp_options_id))
}

resource "aws_ssm_parameter" "nat_ids" {
  count       = length(module.vpc.public_route_table_association_ids) > 0 ? 1 : 0

  description = "List of allocation ID of Elastic IPs created for AWS NAT Gateway"
  name        = "/infra/${var.environment}/networking/nat_ids"
  type        = "String"
  value       = join(",", tolist(module.vpc.public_route_table_association_ids))
}

resource "aws_ssm_parameter" "nat_public_ips" {
  count       = length(module.vpc.nat_public_ips) > 0 ? 1 : 0

  description = "List of public Elastic IPs created for AWS NAT Gateway"
  name        = "/infra/${var.environment}/networking/nat_public_ips"
  type        = "String"
  value       = join(",", tolist(module.vpc.nat_public_ips))
}

resource "aws_ssm_parameter" "natgw_ids" {
  count       = length(module.vpc.natgw_ids) > 0 ? 1 : 0

  description = "List of NAT Gateway IDs"
  name        = "/infra/${var.environment}/networking/natgw_ids"
  type        = "String"
  value       = join(",", tolist(module.vpc.natgw_ids))
}

resource "aws_ssm_parameter" "igw_id" {
  count       = length(module.vpc.igw_id) > 0 ? 1 : 0

  description = "The ID of the Internet Gateway"
  name        = "/infra/${var.environment}/networking/igw_id"
  type        = "String"
  value       = module.vpc.igw_id
}

resource "aws_ssm_parameter" "igw_arn" {
  count       = length(module.vpc.igw_arn) > 0 ? 1 : 0

  description = "The ARN of the Internet Gateway"
  name        = "/infra/${var.environment}/networking/igw_arn"
  type        = "String"
  value       = module.vpc.igw_arn
}

resource "aws_ssm_parameter" "egress_only_internet_gateway_id" {
  count       = length(module.vpc.egress_only_internet_gateway_id) > 0 ? 1 : 0

  description = "The ID of the egress only Internet Gateway"
  name        = "/infra/${var.environment}/networking/egress_only_internet_gateway_id"
  type        = "String"
  value       = join(",", tolist(module.vpc.egress_only_internet_gateway_id))
}

resource "aws_ssm_parameter" "cgw_ids" {
  count       = length(module.vpc.cgw_ids) > 0 ? 1 : 0

  description = "List of IDs of Customer Gateway"
  name        = "/infra/${var.environment}/networking/cgw_ids"
  type        = "String"
  value       = join(",", tolist(module.vpc.cgw_ids))
}

resource "aws_ssm_parameter" "cgw_arns" {
  count       = length(module.vpc.cgw_arns) > 0 ? 1 : 0

  description = "List of ARNs of Customer Gateway"
  name        = "/infra/${var.environment}/networking/cgw_arns"
  type        = "String"
  value       = join(",", tolist(module.vpc.cgw_arns)) 
}

resource "aws_ssm_parameter" "vgw_id" {
  count       = length(module.vpc.vgw_id) > 0 ? 1 : 0

  description = "The ID of the VPN Gateway"
  name        = "/infra/${var.environment}/networking/vgw_id"
  type        = "String"
  value       = join(",", tolist(module.vpc.vgw_id))
}

resource "aws_ssm_parameter" "vgw_arn" {
  count       = length(module.vpc.vgw_arn) > 0 ? 1 : 0

  description = "The ARN of the VPN Gateway"
  name        = "/infra/${var.environment}/networking/vgw_arn"
  type        = "String"
  value       = join(",", tolist(module.vpc.vgw_arn))
}

resource "aws_ssm_parameter" "default_vpc_id" {
  count       = length(module.vpc.default_vpc_id) > 0 ? 1 : 0

  description = "The ID of the Default VPC"
  name        = "/infra/${var.environment}/networking/default_vpc_id"
  type        = "String"
  value       = join(",", tolist(module.vpc.default_vpc_id))
}

resource "aws_ssm_parameter" "default_vpc_arn" {
  count       = length(module.vpc.default_vpc_arn) > 0 ? 1 : 0

  description = "The ARN of the Default VPC"
  name        = "/infra/${var.environment}/networking/default_vpc_arn"
  type        = "String"
  value       = join(",", tolist(module.vpc.default_vpc_arn))
}

resource "aws_ssm_parameter" "default_vpc_cidr_block" {
  count       = length(module.vpc.default_vpc_cidr_block) > 0 ? 1 : 0

  description = "The CIDR block of the Default VPC"
  name        = "/infra/${var.environment}/networking/default_vpc_cidr_block"
  type        = "String"
  value       = join(",", tolist(module.vpc.default_vpc_cidr_block)) 
}

resource "aws_ssm_parameter" "default_vpc_default_security_group_id" {
  count       = length(module.vpc.default_vpc_default_security_group_id) > 0 ? 1 : 0

  description = "The ID of the security group created by default on Default VPC creation"
  name        = "/infra/${var.environment}/networking/default_vpc_default_security_group_id"
  type        = "String"
  value       = join(",", tolist(module.vpc.default_vpc_default_security_group_id))
}

resource "aws_ssm_parameter" "default_vpc_default_network_acl_id" {
  count       = length(module.vpc.default_vpc_default_network_acl_id) > 0 ? 1 : 0

  description = "The ID of the default network ACL of the Default VPC"
  name        = "/infra/${var.environment}/networking/default_vpc_default_network_acl_id"
  type        = "String"
  value       = join(",", tolist(module.vpc.default_vpc_default_network_acl_id)) 
}

resource "aws_ssm_parameter" "default_vpc_default_route_table_id" {
  count       = length(module.vpc.default_vpc_default_route_table_id) > 0 ? 1 : 0

  description = "The ID of the default route table of the Default VPC"
  name        = "/infra/${var.environment}/networking/default_vpc_default_route_table_id"
  type        = "String"
  value       = join(",", tolist(module.vpc.default_vpc_default_route_table_id))
}

resource "aws_ssm_parameter" "default_vpc_instance_tenancy" {
  count       = length(module.vpc.default_vpc_instance_tenancy) > 0 ? 1 : 0

  description = "Tenancy of instances spin up within Default VPC"
  name        = "/infra/${var.environment}/networking/default_vpc_instance_tenancy"
  type        = "String"
  value       = join(",", tolist(module.vpc.default_vpc_instance_tenancy))
}

resource "aws_ssm_parameter" "default_vpc_enable_dns_support" {
  count       = length(module.vpc.default_vpc_enable_dns_support) > 0 ? 1 : 0

  description = "Whether or not the Default VPC has DNS support"
  name        = "/infra/${var.environment}/networking/default_vpc_enable_dns_support"
  type        = "String"
  value       = join(",", tolist(module.vpc.default_vpc_enable_dns_support))
}

resource "aws_ssm_parameter" "default_vpc_enable_dns_hostnames" {
  count       = length(module.vpc.default_vpc_enable_dns_hostnames) > 0 ? 1 : 0

  description = "Whether or not the Default VPC has DNS hostname support"
  name        = "/infra/${var.environment}/networking/default_vpc_enable_dns_hostnames"
  type        = "String"
  value       = join(",", tolist(module.vpc.default_vpc_enable_dns_hostnames))
}

resource "aws_ssm_parameter" "default_vpc_main_route_table_id" {
  count       = length(module.vpc.default_vpc_main_route_table_id) > 0 ? 1 : 0

  description = "The ID of the main route table associated with the Default VPC"
  name        = "/infra/${var.environment}/networking/default_vpc_main_route_table_id"
  type        = "String"
  value       = join(",", tolist(module.vpc.default_vpc_main_route_table_id))
}

resource "aws_ssm_parameter" "public_network_acl_id" {
  count       = length(module.vpc.public_network_acl_id) > 0 ? 1 : 0

  description = "ID of the public network ACL"
  name        = "/infra/${var.environment}/networking/public_network_acl_id"
  type        = "String"
  value       = join(",", tolist(module.vpc.public_network_acl_id)) 
}

resource "aws_ssm_parameter" "public_network_acl_arn" {
  count       = length(module.vpc.public_network_acl_arn) > 0 ? 1 : 0

  description = "ARN of the public network ACL"
  name        = "/infra/${var.environment}/networking/public_network_acl_arn"
  type        = "String"
  value       = join(",", tolist(module.vpc.public_network_acl_arn)) 
}

resource "aws_ssm_parameter" "private_network_acl_id" {
  count       = length(module.vpc.private_network_acl_id) > 0 ? 1 : 0

  description = "ID of the private network ACL"
  name        = "/infra/${var.environment}/networking/private_network_acl_id"
  type        = "String"
  value       = join(",", tolist(module.vpc.private_network_acl_id))
}

resource "aws_ssm_parameter" "private_network_acl_arn" {
  count       = length(module.vpc.private_network_acl_arn) > 0 ? 1 : 0

  description = "ARN of the private network ACL"
  name        = "/infra/${var.environment}/networking/private_network_acl_arn"
  type        = "String"
  value       = join(",", tolist(module.vpc.private_network_acl_arn))
}

resource "aws_ssm_parameter" "outpost_network_acl_id" {
  count       = length(module.vpc.outpost_network_acl_id) > 0 ? 1 : 0

  description = "ID of the outpost network ACL"
  name        = "/infra/${var.environment}/networking/outpost_network_acl_id"
  type        = "String"
  value       = join(",", tolist(module.vpc.outpost_network_acl_id)) 
}

resource "aws_ssm_parameter" "outpost_network_acl_arn" {
  count       = length(module.vpc.outpost_network_acl_arn) > 0 ? 1 : 0

  description = "ARN of the outpost network ACL"
  name        = "/infra/${var.environment}/networking/outpost_network_acl_arn"
  type        = "String"
  value       = join(",", tolist(module.vpc.outpost_network_acl_arn)) 
}

resource "aws_ssm_parameter" "intra_network_acl_id" {
  count       = length(module.vpc.intra_network_acl_id) > 0 ? 1 : 0

  description = "ID of the intra network ACL"
  name        = "/infra/${var.environment}/networking/intra_network_acl_id"
  type        = "String"
  value       = join(",", tolist(module.vpc.intra_network_acl_id))
}

resource "aws_ssm_parameter" "intra_network_acl_arn" {
  count       = length(module.vpc.intra_network_acl_arn) > 0 ? 1 : 0

  description = "ARN of the intra network ACL"
  name        = "/infra/${var.environment}/networking/intra_network_acl_arn"
  type        = "String"
  value       = join(",", tolist(module.vpc.intra_network_acl_arn))
}

resource "aws_ssm_parameter" "database_network_acl_id" {
  count       = length(module.vpc.database_network_acl_id) > 0 ? 1 : 0

  description = "ID of the database network ACL"
  name        = "/infra/${var.environment}/networking/database_network_acl_id"
  type        = "String"
  value       = join(",", tolist(module.vpc.database_network_acl_id))
}

resource "aws_ssm_parameter" "database_network_acl_arn" {
  count       = length(module.vpc.database_network_acl_arn) > 0 ? 1 : 0

  description = "ARN of the database network ACL"
  name        = "/infra/${var.environment}/networking/database_network_acl_arn"
  type        = "String"
  value       = join(",", tolist(module.vpc.database_network_acl_arn)) 
}

resource "aws_ssm_parameter" "redshift_network_acl_id" {
  count       = length(module.vpc.redshift_network_acl_id) > 0 ? 1 : 0

  description = "ID of the redshift network ACL"
  name        = "/infra/${var.environment}/networking/redshift_network_acl_id"
  type        = "String"
  value       = join(",", tolist(module.vpc.redshift_network_acl_id))
}

resource "aws_ssm_parameter" "redshift_network_acl_arn" {
  count       = length(module.vpc.redshift_network_acl_arn) > 0 ? 1 : 0

  description = "ARN of the redshift network ACL"
  name        = "/infra/${var.environment}/networking/redshift_network_acl_arn"
  type        = "String"
  value       = join(",", tolist(module.vpc.redshift_network_acl_arn)) 
}

resource "aws_ssm_parameter" "elasticache_network_acl_id" {
  count       = length(module.vpc.elasticache_network_acl_id) > 0 ? 1 : 0

  description = "ID of the elasticache network ACL"
  name        = "/infra/${var.environment}/networking/elasticache_network_acl_id"
  type        = "String"
  value       = join(",", tolist(module.vpc.elasticache_network_acl_id))
}

resource "aws_ssm_parameter" "elasticache_network_acl_arn" {
  count       = length(module.vpc.elasticache_network_acl_arn) > 0 ? 1 : 0

  description = "ARN of the elasticache network ACL"
  name        = "/infra/${var.environment}/networking/elasticache_network_acl_arn"
  type        = "String"
  value       = join(",", tolist(module.vpc.elasticache_network_acl_arn))
}

# VPC flow log
resource "aws_ssm_parameter" "vpc_flow_log_id" {
  count       = length(module.vpc.vpc_flow_log_id) > 0 ? 1 : 0

  description = "The ID of the Flow Log resource"
  name        = "/infra/${var.environment}/networking/vpc_flow_log_id"
  type        = "String"
  value       = module.vpc.vpc_flow_log_id
}

resource "aws_ssm_parameter" "vpc_flow_log_destination_arn" {
  count       = length(module.vpc.vpc_flow_log_destination_arn) > 0 ? 1 : 0

  description = "The ARN of the destination for VPC Flow Logs"
  name        = "/infra/${var.environment}/networking/vpc_flow_log_destination_arn"
  type        = "String"
  value       = module.vpc.vpc_flow_log_destination_arn
}

resource "aws_ssm_parameter" "vpc_flow_log_destination_type" {
  count       = length(module.vpc.vpc_flow_log_destination_type) > 0 ? 1 : 0

  description = "The type of the destination for VPC Flow Logs"
  name        = "/infra/${var.environment}/networking/vpc_flow_log_destination_type"
  type        = "String"
  value       = module.vpc.vpc_flow_log_destination_type
}

resource "aws_ssm_parameter" "vpc_flow_log_cloudwatch_iam_role_arn" {
  count       = length(module.vpc.vpc_flow_log_cloudwatch_iam_role_arn) > 0 ? 1 : 0

  description = "The ARN of the IAM role used when pushing logs to Cloudwatch log group"
  name        = "/infra/${var.environment}/networking/vpc_flow_log_cloudwatch_iam_role_arn"
  type        = "String"
  value       = module.vpc.vpc_flow_log_cloudwatch_iam_role_arn
}

# Static values (arguments)
resource "aws_ssm_parameter" "azs" {
  count       = length(module.vpc.azs) > 0 ? 1 : 0

  description = "A list of availability zones specified as argument to this module"
  name        = "/infra/${var.environment}/networking/vpc_availability_zones"
  type        = "StringList"
  value       = join(",", tolist(module.vpc.azs))
}

resource "aws_ssm_parameter" "name" {
  count       = length(module.vpc.name) > 0 ? 1 : 0

  description = "The name of the VPC specified as argument to this module"
  name        = "/infra/${var.environment}/networking/vpc_name"
  type        = "String"
  value       = module.vpc.name
}