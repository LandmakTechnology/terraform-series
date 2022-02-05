## **Sensitive values in state**

- When you run Terraform commands with a local state file, Terraform stores the state as plain text, including variable values, even if you have flagged them as sensitive. Terraform needs to store these values in your state so that it can tell if you have changed them since the last time you applied your configuration.
- Since Terraform state can contain sensitive values, you must keep your state file secure to avoid exposing this data. Refer to the Terraform documentation to learn more about securing your state file.

## **Backend**
- Each Terraform configuration can specify a backend, which defines exactly where and how operations are performed, where state snapshots are stored, etc.

- If a configuration includes no backend block, Terraform defaults to using the local backend, which performs operations on the local system and stores state as a plain file in the current working directory.

- When changing backends, Terraform will give you the option to migrate your state to the new backend. This lets you adopt backends without losing any existing state.

- You can change your backend configuration at any time. You can change both the configuration itself as well as the type of backend (for example from "consul" to "s3").

- Terraform will automatically detect any changes in your configuration and request a reinitialization. As part of the reinitialization process, Terraform will ask if you'd like to migrate your existing state to the new configuration. This allows you to easily switch from one backend to another.

# **S3 Backend (with locking via DynamoDB)**
- Stores the state as a given key in a given bucket on Amazon S3. This backend also supports state locking and consistency checking via Dynamo DB, which can be enabled by setting the dynamodb_table field to an existing DynamoDB table name. A single DynamoDB table can be used to lock multiple remote state files. Terraform generates key names that include the values of the bucket and key variables.

- It is highly recommended that you enable Bucket Versioning on the S3 bucket to allow for state recovery in the case of accidental deletions and human error.

##**DynamoDB State Locking**
The following configuration is optional:

**dynamodb_table**
- (Optional) Name of DynamoDB Table to use for state locking and consistency. The table must have a primary key named LockID with type of string. If not configured, state locking will be disabled.

# **DynamoDB Table Permissions**
If you are using state locking, Terraform will need the following AWS IAM permissions on the DynamoDB table (arn:aws:dynamodb:::table/mytable):

     dynamodb:GetItem
     dynamodb:PutItem
     dynamodb:DeleteItem


##**Data Source configurations**
- To make use of the S3 remote state in another configuration, use the terraform_remote_state data source.

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "terraform-state-prod"
    key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}
