# https://www.terraform.io/docs/configuration/terraform.html
terraform {
  required_version = ">= 1.0, < 2.0"

  required_providers {
    aws = ">= 4.5.0"
  }
}
