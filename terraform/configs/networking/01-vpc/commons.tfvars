################################################################################
# Settings: VPC - Workload
################################################################################
vpc_name = "workload"
vpc_cidr_block = {
   us-east-1 = "172.16.152.0/21"
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

vpc_tags                   = {
    "Associate-with": "Flat",
    "Propagate-to": "Flat" 
}

################################################################################
# Settings: Subnet - Transit Gateway
################################################################################
vpc_intra_subnet_cidr_blocks           = {
    us-east-1 = ["172.16.152.0/24", "172.16.153.0/24"]
}
vpc_intra_subnet_suffix                = "transit-gateway"
vpc_intra_subnet_dedicated_network_acl = true
vpc_intra_subnet_inbound_acl_rules     = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "10.0.0.0/8"
    },
    {
      rule_number = 101
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "172.16.0.0/12"
    },
    {
      rule_number = 102
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "192.168.0.0/16"
    },
]
vpc_intra_subnet_outbound_acl_rules   = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "10.0.0.0/8"
    },
    {
      rule_number = 101
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "172.16.0.0/12"
    },
    {
      rule_number = 102
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "192.168.0.0/16"
    },
]
vpc_intra_subnet_tags                  = {
    "Type": "transit-gateway",
    "Attach-to-tgw": "STNO" 
}

################################################################################
# Settings: Subnet - Private
################################################################################
vpc_private_subnet_cidr_blocks    = {
   us-east-1 = ["172.16.154.0/24", "172.16.155.0/24"]
}
vpc_private_subnet_suffix = "private"
vpc_private_subnet_tags   = {
    "Type": "private"
}

################################################################################
# Settings: Subnet - Public
################################################################################
vpc_public_subnet_cidr_blocks    = {
    us-east-1 = ["172.16.156.0/24", "172.16.157.0/24"]
}
vpc_public_subnet_suffix  = "public"
vpc_public_subnet_tags    = {
    "Type": "public"
}