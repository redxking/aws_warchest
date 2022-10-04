#
# Common Variables
#
variable "namespace" {
    description = "Namespace to Deploy Resources"
    type        = string
}

variable "environment" {
    description = "Environment to Deploy Resources"
    type        = string
}

variable "region" {
    description = "AWS Region to Deploy Resources"
    type        = string
}

#
# Resource Variables
#
variable "vpc_name" {
    description = "Name of the VPC to create - used for 'Name' tag on all resources (default: <company>-<environment>)"
    type        = string
}

variable "vpc_cidr_blocks"  {
    description = "CIDR(s) of the VPC to create"
    type        = map(string)
}

variable "vpc_secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks to associate with the VPC to extend the IP Address pool"
  type        = map(list(string))
  default     = {}
}

variable "vpc_availability_zones" {
    description = "Availability Zone of the VPC to create"
    type        = map(list(string))
}

variable "vpc_enable_ipv6" {
    description = ""
    type        = bool
    default     = false
}

variable "vpc_enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "vpc_enable_dns_hostnames" {
    description = "Enable DNS hostnames in the VPC"
    type        = bool
    default     = true
}

variable "vpc_enable_vpn_gateway" {
    description = "Provison a new VPN Gateway resource and attach it to the VPC"
    type        = bool
    default     = false
}

variable "vpc_enable_nat_gateway" {
    description = "Provision NAT Gateways for each of your private networks"
    type        = bool
    default     = true
}

variable "vpc_single_nat_gateway" {
    description = "Provision a single shared NAT Gateway across all of your private networks"
    type        = bool
    default     = false
}

variable "vpc_one_nat_gateway_per_az" {
    description = "Provision only one NAT Gateway per availability zone"
    type        = bool
    default     = true
}

variable "vpc_enable_internet_gateway" {
  description = "Controls if an Internet Gateway is created for public subnets and the related routes that connect them."
  type        = bool
  default     = true
}

variable "vpc_customer_gateways" {
  description = "Maps of Customer Gateway's attributes (BGP ASN and Gateway's Internet-routable external IP address)"
  type        = map(map(any))
  default     = {}
}

variable "vpc_database_subnet_cidr_blocks" {
    description = "Subnet CIDR(s) of the VPC to create: Database"
    type        = map(list(string))
    default     = {}
}

variable "vpc_database_subnet_suffix" {
    description = "Subnet Suffix of the VPC to create: Database"
    type        = string
    default     = null
}

variable "vpc_database_subnet_tags" {
    description = "Subnet Tag(s) of the VPC to create: Database"
    type        = map(string)
    default     = {}
}

variable "vpc_create_database_subnet_group" {
    description = "Subnet Group of the VPC to create: Database"
    type        = string
    default     = true
}

variable "vpc_elasticache_subnet_cidr_blocks" {
    description = "Subnet CIDR(s) of the VPC to create: Elasticache"
    type        = map(list(string))
    default     = {}
}

variable "vpc_elasticache_subnet_suffix" {
    description = "Subnet Suffix of the VPC to create: Elasticache"
    type        = string
    default     = null
}

variable "vpc_elasticache_subnet_tags" {
    description = "Subnet Tag(s) of the VPC to create: Elasticache"
    type        = map(string)
    default     = {}
}

variable "vpc_create_elasticache_subnet_group" {
    description = "Subnet Group of the VPC to create: Elasticache"
    type        = string
    default     = true
}

variable "vpc_intra_subnet_cidr_blocks" {
    description = "Subnet CIDR(s) of the VPC to create: Intra (Transit Gateway)"
    type        = map(list(string))
    default     = {}
}

variable "vpc_intra_subnet_suffix" {
    description = "Subnet Suffix of the VPC to create: Intra (Transit Gateway)"
    type        = string
    default     = null
}

variable "vpc_intra_subnet_tags" {
    description = "Subnet Tag(s) of the VPC to create: Intra (Transit Gateway)"
    type        = map(string)
    default     = {}
}

variable "vpc_private_subnet_cidr_blocks" {
    description = "Subnet CIDR(s) of the VPC to create: Private"
    type        = map(list(string))
    default     = {}
}

variable "vpc_private_subnet_suffix" {
    description = "Subnet Suffix of the VPC to create: Private"
    type        = string
    default     = null
}

variable "vpc_private_subnet_tags" {
    description = "Subnet Tag(s) of the VPC to create: Private"
    type        = map(string)
    default     = {}
}

variable "vpc_public_subnet_cidr_blocks" {
    description = "Subnet CIDR(s) of the VPC to create: Public"
    type        = map(list(string))
    default     = {}
}

variable "vpc_public_subnet_suffix" {
    description = "Subnet Suffix of the VPC to create: Private"
    type        = string
    default     = null
}

variable "vpc_public_subnet_tags" {
    description = "Subnet Tag(s) of the VPC to create: Public"
    type        = map(string)
    default     = {}
}
  
variable "vpc_redshift_subnet_cidr_blocks" {
    description = "Subnet CIDR(s) of the VPC to create: Redshift"
    type        = map(list(string))
    default     = {}
}

variable "vpc_redshift_subnet_suffix" {
    description = "Subnet Suffix of the VPC to create: Redshift"
    type        = string
    default     = null
}

variable "vpc_redshift_subnet_tags" {
    description = "Subnet Tag(s) of the VPC to create: Redshift"
    type        = map(string)
    default     = {}
}

variable "vpc_create_redshift_subnet_group" {
    description = "Subnet Group of the VPC to create: Redshift"
    type        = string
    default     = true
} 

variable "vpc_enable_flow_log" {
    description = ""
    type        = bool
    default     = true
}

variable "vpc_create_flow_log_cloudwatch_iam_role" {
    description = ""
    type        = bool
    default     = true
}

variable "vpc_create_flow_log_cloudwatch_log_group" {
    description = ""
    type        = bool
    default     = true
}

variable "vpc_flow_log_cloudwatch_log_group_retention" {
    description = "Cloudwatch Log Group Retention in Days: VPC Flow"
    type        = number
}

#
# Tag Variables
#
variable "provisioner" {
    description = "Value for Resource Tag: provisioner"
    type        = string
    default     = "terraform"
}
