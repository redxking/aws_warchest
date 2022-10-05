terraform {
  backend "s3" {
    encrypt = true
    key     = "networking/03-routes/terraform.tfstate"
  }
}