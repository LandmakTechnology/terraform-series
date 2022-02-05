The AWS provider offers a flexible means of providing credentials for authentication. The following methods are supported, in this order, and explained below:

- **Static credentials**
     provider "aws" {
       region     = "us-west-2"
       access_key = "my-access-key"
       secret_key = "my-secret-key"
    }
    
- **Environment variables**
     $ export AWS_ACCESS_KEY_ID="accesskey"
     $ export AWS_SECRET_ACCESS_KEY="secretkey"
     $ export AWS_DEFAULT_REGION="us-west-2"

- **Shared credentials/configuration file**
    provider "aws" {
      region                  = "us-west-2"
      shared_credentials_file = "/Users/tf_user/.aws/creds"
      profile                 = "dev"
  }
