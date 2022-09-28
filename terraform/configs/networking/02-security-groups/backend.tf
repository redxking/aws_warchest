terraform {
  backend "s3" {
    encrypt = true
    key     = "networking/02-security-groups/terraform.tfstate"
  }
}