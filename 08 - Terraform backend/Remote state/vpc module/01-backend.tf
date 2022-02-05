terraform {
  required_version = "~> 1.0" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }


  backend "s3" {
    bucket = "my-terraformstate-landmark-buc"
    key = "terraform/terraform.tfstate"
    dynamodb_table = "terraform-lock"

    region = "us-west-1"

 }
}

/*resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-terraformstate-landmark-buc"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "My terraform-bucket"
    Environment = "Dev"
  }
}*/

resource "aws_dynamodb_table" "tf_lock" {
  name = "terraform-lock"
  hash_key = "LockID"
  read_capacity = 3
  write_capacity = 3
  attribute {
     name = "LockID"
     type = "S"
   }
  tags = {
    Name = "Terraform Lock Table"
   }
 }

 # Provider Block
provider "aws" {
   region  = "us-west-1"
   profile = "Kenmak"
 }
