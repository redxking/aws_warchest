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

variable "account_id_commons" {
    description = "AWS Account Id: Commons"
    type        = string
}

variable "account_id_sandbox" {
    description = "AWS Account Id: Sandbox"
    type        = string
}

variable "account_id_develop" {
    description = "AWS Account Id: Develop"
    type        = string
}

variable "account_id_staging" {
    description = "AWS Account Id: Staging"
    type        = string
}

variable "account_id_product" {
    description = "AWS Account Id: Product"
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