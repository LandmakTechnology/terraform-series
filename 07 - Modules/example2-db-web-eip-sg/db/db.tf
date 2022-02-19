resource "aws_instance" "db" {
    ami = data.aws_ami.amzlinux2.id
    instance_type = "t2.micro"

    tags = {
        Name = "DB Server"
    }
}

output "PrivateIP" {
    value = aws_instance.db.private_ip
}
