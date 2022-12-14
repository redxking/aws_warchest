################################################################################
# Settngs: VPC - Workload
################################################################################
vpc_name = "workload"
vpc_cidr_block = {
   us-east-1 = "172.16.128.0/21"
}
vpc_availability_zones = {
    us-east-1 = ["us-east-1a", "us-east-1b"]
}

vpc_enable_nat_gateway     = true
vpc_single_nat_gateway     = false
vpc_one_nat_gateway_per_az = true

vpc_enable_vpn_gateway     = false
vpc_enable_dns_hostnames   = true
vpc_flow_log_cloudwatch_log_group_retention = 14

################################################################################
# Settings: Subnet - Transit Gateway
################################################################################
vpc_intra_subnet_cidr_blocks      = {
    us-east-1 = ["172.16.128.0/24", "172.16.129.0/24"]
}
vpc_intra_subnet_suffix    = "transit-gateway"
vpc_intra_subnet_tags      = {
    "Type": "transite-gateway",
    "Attach-to-tgw": "STNO" 
}

################################################################################
# Settings: Subnet - Database
################################################################################
vpc_database_subnet_cidr_blocks   = {
    us-east-1 = ["172.16.130.0/24", "172.16.131.0/24"]
}
vpc_database_subnet_suffix = "database"
vpc_database_subnet_tags   = {
    "Type": "database"
}
vpc_create_database_subnet_group = true

################################################################################
# Settings: Subnet - Private
################################################################################
vpc_private_subnet_cidr_blocks    = {
   us-east-1 = ["172.16.132.0/24", "172.16.133.0/24"]
}
vpc_private_subnet_suffix = "private"
vpc_private_subnet_tags   = {
    "Type": "private"
}

################################################################################
# Settings: Subnet - Public
################################################################################
vpc_public_subnet_cidr_blocks    = {
    us-east-1 = ["172.16.134.0/24", "172.16.135.0/24"]
}
vpc_public_subnet_suffix  = "public"
vpc_public_subnet_tags    = {
    "Type": "public"
}