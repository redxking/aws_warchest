terraform {
  backend "s3" {
    encrypt = true
    key     = "networking/05-ec2-instances/terraform.tfstate"
  }
}