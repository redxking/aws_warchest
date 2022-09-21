terraform {
  backend "s3" {
    encrypt = true
    key     = "networking/01-vpc/terraform.tfstate"
  }
}