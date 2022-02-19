
#Block-1: **Terraform Settings Block**
terraform {
  required_version = "~> 1.0"         1.1.4/5/6/7   1.2/3/4/5 1.1.4/5/6/7
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  
  # Adding Backend as S3 for Remote State Storage with State Locking
  backend "s3" {
    bucket = "terraform-mylandmark"
    key    = "prod/terraform.tfstate"
    region = "us-west-2"
    # For State Locking
    dynamodb_table = "terraform-lock"
  }
}

resource "aws_dynamodb_table" “tf_lock" {
  name = "terraform-lock"
  hash_key = "LockID"
  read_capacity = 3
  write_capacity = 3
  attribute {
     name = "LockID"
     type = "S"
   }
  tags  {
    Name = "Terraform Lock Table"
   }
 }


# Block-2: **Provider Block**
provider "aws" {
  profile = "default" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  region  = "us-west-2"
}

# Block-3: **Resource Block**
resource "aws_instance" "class25" {
  ami           = "ami-0e5b6b6a9f3db6db8" # Amazon Linux
  instance_type = var.instance_type
}

# Block-4: **Input Variables Block**
variable "instance_type" {
  default = "t2.micro"
  description = "EC2 Instance Type"
  type = string
}

# Block-5: **Output Values Block**
output "ec2_instance_publicip" {
  description = "EC2 Instance Public IP"
  value = aws_instance.class25.public_ip
}

# Block-6: **Local Values Block**
# Create S3 Bucket - with Input Variables & Local Values
locals {
  name = "${var.app_name}-${var.environment_name}"
}
bucket_name = locals.name


# Block-7: **Data sources Block**
# Get latest AMI ID for Amazon Linux2 OS
data "aws_ami" "amzlinux" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}


# Block-8: **Modules Block**
# AWS EC2 Instance Module

module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "my-modules-demo"
  instance_count         = 2

  ami                    = data.aws_ami.amzlinux.id
  instance_type          = "t2.micro"
  key_name               = "terraform-key"
  monitoring             = true
  vpc_security_group_ids = ["sg-08b25c5a5bf489ffa"]  # Get Default VPC Security Group ID and replace
  subnet_id              = "subnet-4ee95470" # Get one public subnet id from default vpc and replace
  user_data               = file("apache-install.sh")

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

