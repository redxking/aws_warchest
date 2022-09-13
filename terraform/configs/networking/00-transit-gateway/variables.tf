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
# Tag Variables
#

variable "namespace" {
    description = "Value for Resource Tag: Namespace"
    type        = string
}
