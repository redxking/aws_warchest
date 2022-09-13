#  All module variables go here 

variable "vpc_id" {
  description = "Vpc Id"
  type        = string
}

variable "app_name" {
  description = "Application Name"
  type        = string
  default     = "MyApp"

  # Add validation when appropriate
  # validation {
  #     condition = <condition>
  #     error_message = "value"
  # }
}

variable "tags" {
  description = "Custom tags to apply to all resources."
  type        = map(string)
  default     = {}
}