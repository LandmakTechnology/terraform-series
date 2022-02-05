## **Variable files**

- Values for the input variables of a root module can be gathered in variable definition files and passed together using the -var-file=FILE option.

- For all files which match terraform.tfvars or *.auto.tfvars present in the current directory, Terraform automatically loads them to populate variables. If the file is located somewhere else, you can pass the path to the file using the -var-file flag. It is recommended to name such files with names ending in .tfvars.

- The -var-file flag can be used multiple times per command invocation:

    $ terraform apply -var-file=foo.tfvars -var-file=bar.tfvars

- According to the terraform documentation on input variables, Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

    - Environment variables
    - The tfvarsfile, if present.
    - The tfvars.jsonfile, if present.
    - Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
    Any -var and -var-file options on the command line, in order they are provided. (This includes variables set by a Terraform Cloud workspace.)

# **Environmental variables**

- When Terraform runs, it looks in your environment for variables that match the pattern TF_VAR_<VARIABLE_NAME>, and assigns those values to the corresponding Terraform variables in your configuration.
- Assign values to the database administrator username and password using environment variables.

  $ export TF_VAR_db_username=admin TF_VAR_db_password=adifferentpassword

# **.tfvars file**
- Terraform supports setting variable values with variable definition (.tfvars) files. You can use multiple variable definition files, and many practitioners use a separate file to set sensitive or secret values.
- Create a new file called secret.tfvars to assign values to the new variables.

      db_username = "admin"
      db_password = "insecurepassword"

- Apply these changes using the -var-file parameter. Respond to the confirmation prompt with yes.

    $ terraform apply -var-file="secret.tfvars"
