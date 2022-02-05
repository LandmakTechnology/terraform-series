# EC2 Instance
resource "aws_instance" "myec2" {
  ami = data.aws_ami.amzlinux2.id
  #instance_type = var.instance_type
  instance_type = var.instance_type_list[0]  # For List
  #instance_type = var.instance_type_map["dev"]  # For Map
  user_data = file("${path.module}/app1-install.sh")
  key_name = var.instance_keypair
  vpc_security_group_ids = [ aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id   ]
  count = 1
  tags = {
    "Name" = "Prod-${count.index}"
  }
}

/*
# Drawbacks of using count in this example
- Resource Instances in this case were identified using index numbers
instead of string values like actual subnet_id
- If an element was removed from the middle of the list,
every instance after that element would see its subnet_id value
change, resulting in more remote object changes than intended.
- Even the subnet_ids should be pre-defined or we need to get them again
using for_each or for using various datasources
- Using for_each gives the same flexibility without the extra churn.
*/
