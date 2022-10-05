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
# Tag Variables
#
variable "provisioner" {
    description = "Value for Resource Tag: provisioner"
    type        = string
    default     = "terraform"
}