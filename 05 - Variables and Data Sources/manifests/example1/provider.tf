#terraform block
terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0" # Optional but recommended in production
    }
  }
}


#provider block
provider "aws" {
  region  = var.aws_region
  profile = "Landmark"
}
