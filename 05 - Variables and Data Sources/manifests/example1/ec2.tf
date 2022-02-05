#resource block
resource "aws_instance" "my_ec2" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.my_instance_type
  key_name = var.my_key

  tags = {
    "Name" = "Ec2-Demo"
  }
}
