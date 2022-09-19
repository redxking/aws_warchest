locals {
  jumpbox_amis = {
    us-east-1      = "ami-02538f8925e3aa27a",
    us-west-2      = "ami-07d59d159373b8030",
    eu-central-1   = "ami-041e64b0129bffca9",
    eu-west-1      = "ami-038e9cdc714b15936",
    ap-northeast-1 = "ami-0b069de314c9ab4c4",
    ap-southeast-1 = "ami-013586750d303f89d"
  }
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

################################################################################
# VPC Routes Module
################################################################################
resource "aws_route" "transit_gateway_route" {
  for_each = toset(var.transit_gateway_rfc1918_cidr)

  route_table_id            = module.vpc.intra_route_table_ids[0]
  destination_cidr_block    = each.value
  transit_gateway_id        = var.transit_gateway_id[var.region]
  depends_on                = [module.vpc]
}

################################################################################
# VPC Endpoints Module
################################################################################
module "vpc_endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id             = module.vpc.vpc_id
  security_group_ids = [data.aws_security_group.default.id]

  endpoints = {
    s3 = {
      service = "s3"
      tags    = { Name = "s3-vpc-endpoint" }
    },
    dynamodb = {
      service         = "dynamodb"
      service_type    = "Gateway"
      route_table_ids = flatten([module.vpc.intra_route_table_ids, module.vpc.private_route_table_ids, module.vpc.public_route_table_ids])
      policy          = data.aws_iam_policy_document.dynamodb_endpoint_policy.json
      tags            = { Name = "dynamodb-vpc-endpoint" }
    },
    ssm = {
      service             = "ssm"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      security_group_ids  = [module.systems_manager_sg.security_group_id]
    },
    ssmmessages = {
      service             = "ssmmessages"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      security_group_ids  = [module.systems_manager_sg.security_group_id]
    },
    lambda = {
      service             = "lambda"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
    },
    ecs = {
      service             = "ecs"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
    },
    ecs_telemetry = {
      create              = false
      service             = "ecs-telemetry"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
    },
    ec2 = {
      service             = "ec2"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      security_group_ids  = [module.systems_manager_sg.security_group_id]
    },
    ec2messages = {
      service             = "ec2messages"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      security_group_ids  = [module.systems_manager_sg.security_group_id]
    },
    ecr_api = {
      service             = "ecr.api"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
    },
    ecr_dkr = {
      service             = "ecr.dkr"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
    },
    kms = {
      service             = "kms"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      security_group_ids  = [module.systems_manager_sg.security_group_id]
    },
    codedeploy = {
      service             = "codedeploy"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
    },
    codedeploy_commands_secure = {
      service             = "codedeploy-commands-secure"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
    },
  }

  tags = merge(local.tags, {
    Endpoint = "true"
  })
}


################################################################################
# VPC Jumpbox Module
################################################################################
resource "aws_iam_instance_profile" "jumpbox_profile" {
  name = "jumpbox_profile"
  role = aws_iam_role.jumpbox_role.name
}

resource "aws_iam_role" "jumpbox_role" {
  name = "jumpbox_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow"
        }
    ]
}
EOF
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  ]
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(module.vpc.private_subnets)

  name = "jumpbox-${index(module.vpc.private_subnets, each.value) + 1}"

  ami                    = local.jumpbox_amis[var.region]
  instance_type          = "t2.micro"
  key_name               = "jumpbox"
  monitoring             = true
  vpc_security_group_ids = [
    module.transit_gateway_sg.security_group_id,
    module.systems_manager_sg.security_group_id
  ]
  subnet_id              = each.value
  iam_instance_profile   = aws_iam_instance_profile.jumpbox_profile.id

  # Tag(s)
  tags = merge(
    local.tags,
    { "Type": "jumpbox" }
  )
}