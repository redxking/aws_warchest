terraform {
  backend "s3" {
    encrypt = true
    key     = "iam/01-cross-account-roles/terraform.tfstate"
  }
}