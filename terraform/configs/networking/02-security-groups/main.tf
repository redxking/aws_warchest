locals {
  tags = merge(
    { Namespace: var.namespace },
    { Environment: var.environment },
    { Region: var.region },
    { Provisioner: var.provisioner }
  )
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
      description = "Allow TLS Inbound Traffic - VPC Local"
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