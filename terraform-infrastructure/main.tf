# configure terraform backend
terraform {
  backend "s3" {
    bucket  = "techbleatweek8"
    key     = "env/dev/terraform.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
}

# Configure the AWS provider
provider "aws" {
  region = var.region
}