terraform {
  backend "s3" {
    encrypt = true
    key     = "networking/04-endpoints/terraform.tfstate"
  }
}