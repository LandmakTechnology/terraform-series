# Project 2 solution
1) Create an ec2 instance
2) Attach an elastic IP to the instance
3) Output the value of the public IP of the eip.

# **Terraform block**
```t
terraform {
  required_version = "~> 1.0" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Provider Block
provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "ec2" {
    ami = "ami-0e5b6b6a9f3db6db8"
    instance_type = "t2.micro"
}

# Refer to the arguments section for the eip (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip#argument-reference)
resource "aws_eip" "elasticeip" {
    instance = aws_instance.ec2.id
}
# Refer to the attribute section for the eip (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip#attributes-reference)
output "EIP" {
    value = aws_eip.elasticeip.public_ip
}
