locals {  
  tags = merge(
    { Namespace: var.namespace },
    { Environment: var.environment },
    { Region: var.region },
    { Provisioner: var.provisioner }
  )
}


################################################################################
# VPC Security Groups Module(s) - Common
################################################################################
module "transit_gateway_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.13.1"

  name        = "transit-gateway-sg"
  description = "Security group for AWS Transit Gateway" 
  vpc_id      = data.external.vpc_id.result["value"] 
  
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
  version = "4.13.1"

  name        = "systems-manager-sg"
  description = "Security group for AWS Systems Manager" 
  vpc_id      = data.external.vpc_id.result["value"]
  
  ingress_with_cidr_blocks = [
    {
      description = "Allow TLS Inbound Traffic - VPC Local"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = data.external.vpc_cidr_block.result["value"]
    }
  ] 
  
  # Tag(s)
  tags = local.tags 
}

module "route53_resolver_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "4.13.1"

  name        = "route53-resolver-sg"
  description = "Security group for AWS Route53 Resolver" 
  vpc_id      = data.external.vpc_id.result["value"]
  
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
# VPC Security Groups Module(s) - Custom
################################################################################
