# Terraform Settings Block
terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~> 3.0"
        # Optional but recommended in production
    }
  }
}

# Provider Block
provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

# Resource Block

resource "aws_vpc" "project1vpc" {
    cidr_block = "192.168.0.0/24"
    tags = {
        Name = "FirstVPC"
    }
}
