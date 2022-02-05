resource "aws_instance" "ec2" {
    ami = data.aws_ami.amzlinux2.id
    instance_type = var.my_instance_type
    security_groups = [aws_security_group.web-traffic.name]

    tags = {
      "Name" = "Prod_ec2"
    }
}
