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
variable "create_cross_account_automation_lambda_role" {
    description = "Controls if Cross Acount Automation Lambda role is created"
    type        = bool
}

variable "create_cross_account_automation_exec_role" {
    description = "Controls if Cross Acount Automation Execution role is created"
    type        = bool
}

variable "account_ids" {
    description = "AWS Account Ids"
    type        = map(string)
}

#
# Tag Variables
#
variable "provisioner" {
    description = "Value for Resource Tag: provisioner"
    type        = string
    default     = "terraform"
}