# Terraform Settings Block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0" # Optional but recommended in production
    }
  }
}

# Provider Block
provider "aws" {
  profile = "Kenmak" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  region  = "us-west-2"
}

# Resource Block

resource "aws_instance" "ec2demo" {
  ami           = "ami-0e5b6b6a9f3db6db8" # Amazon Linux in us-west-2, update as per your region
  instance_type = "t2.micro"

  tags = {
    Name = "myec2"
  }
}
