module "vpc-2-tier" {
  source = "../../modules/networking/security_group"

  vpc_id = data.aws_vpc.default.id
}

