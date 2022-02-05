## **Introduction to Terraform**

Key Concepts:
a) **Infrastructure as a Code**
  - Managing and provisioning of infrastructure through code instead of manually
  - Files that contain configurations are created and makes it easy to edit and distribute
  - Ensures that the same environment is provisioned everytime.
  - Helps avoid undocumented, ad-hoc configuration changes
  - Easy to version control
  - Can create infrastructure in modular components
  - Gives you a template to follow for provisioning
b) **Benefits:**
  - Cost reduction
  - Increase in speed of deployment
  - Reduce errors
  - Improve infrastructure consistency
  - Eliminate configuration drift

##**What is Terraform?:**
  - IaaC tool from Hashicorp
  - Used for building, changing and managing infrastructure in a safe, repeatable way
  - Uses HCL - Hashicorp Configuration Language - human readable
  - Reads configuration files and provides an execution plan which can be reviewed before being applied.
  - It is platform agnostic - can manage a heterogeneous environment - multi cloud
  - State management - creates a state file when a project is first initialized. Uses this state file to  create plans and make changes based on the desired and current state of the infrastructure.
  - Creates operator confidence

  ##**Terraform Configuration Files**
- Terraform uses declarative syntax to describe your Infrastructure as Code (IaC) infrastructure
and then persist it in configuration files that can be shared, reviewed, edited, versioned,
preserved, and reused.
- Terraform configuration files can use either of two formats: Terraform domain-specific
language (HashiCorpConfiguration Language format [HCL]), which is the recommended
approach, or JSON format if the files need to be machine-readable.
- Configuration files that use the HCL format end with the .tf file extension;
- Those using JSON format end with the .tf.json file extension.
- The Terraform format is human-readable, while the JSON format is machine readable
