# Terraform Command Basics

## Step-01: Terraform configuration files
   - Terraform uses declarative syntax to describe your Infrastructure as Code (IaC) infrastructure
   and then persist it in configuration files that can be shared, reviewed, edited, versioned,
   preserved, and reused.
   - Terraform configuration files can use either of two formats: Terraform domain-specific
   language (HashiCorp Configuration Language format [HCL]), which is the recommended
   approach, or JSON format if the files need to be machine-readable.
   - Configuration files that use the HCL format end with the .tf file extension;
   - Those using JSON format end with the .tf.json file extension.
   - The Terraform format is human-readable, while the JSON format is machine readable


## Step-01: Introduction to Terraform workflow - main commands
**Terraform init**:
    - Used to initialize a working directory containing terraform config files.
    - This is the first command that should be run after writing a new terraform configuration file.
    - It downloads providers and modules
**Terraform validate**:
    - Validates the configuration files in the respective directory to ensure that they are syntactically valid and internally consistent.
**Terraform plan**:
    - Creates an execution plan
    - Terraform performs a refresh and determines what actions are necessary to achieve the desired state specified in the configuration files
**Terraform apply**:
    - Used to apply the changes required to reach the desired state of the configuration
    - By default, apply scans the current directory for the configuration and applies the changes appropriately.
    - The state file is created when apply is ran the first time.
**Terraform destroy**:
    - Use to destroy terraform managed infrastructure.
    - This will ask for confirmation before destroying.    

## Step-02: Review terraform manifest for EC2 Instance
- **Pre-Conditions-1:** Ensure you have **default-vpc** in that respective region
- **Pre-Conditions-2:** Ensure AMI you are provisioning exists in that region if not update AMI ID
- **Pre-Conditions-3:** Verify your AWS Credentials in **$HOME/.aws/credentials**

```
# Terraform Settings Block
terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"            # Optional but recommended in production
    }
  }
}

# Provider Block
provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

# Resource Block
resource "aws_instance" "ec2demo" {
  ami           = "ami-0e5b6b6a9f3db6db8"
  instance_type = "t2.micro"
}
```

## Step-03: Terraform Core Commands

# Initialize Terraform
terraform init

# Terraform Validate
terraform validate

# Terraform Plan to Verify what it is going to create / update / destroy
terraform plan

# Terraform Apply to Create EC2 Instance
terraform apply


## Step-04: Verify the EC2 Instance in AWS Management Console
- Go to AWS Management Console -> Services -> EC2
- Verify newly created EC2 instance


## Step-05: Destroy Infrastructure

# Destroy EC2 Instance
terraform destroy
