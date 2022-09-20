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

  depends_on = [module.vpc]

  # Tag(s)
  tags = merge(local.tags, {
    "Type": "jumpbox"
  })
}