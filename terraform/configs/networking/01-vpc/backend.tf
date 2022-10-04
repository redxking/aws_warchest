terraform {
  backend "s3" {
    encrypt = true
    key     = "networking/terraform.tfstate"
  }
}