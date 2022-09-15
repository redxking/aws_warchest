#
# Common Variables
#
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
    default     = null
    description = "Name of the VPC to create - used for 'Name' tag on all resources (default: <company>-<environment>)"
    type        = string
}

variable "" {
  
}


#
# Tag Variables
#
variable "namespace" {
    description = "Value for Resource Tag: Namespace"
    type        = string
}
