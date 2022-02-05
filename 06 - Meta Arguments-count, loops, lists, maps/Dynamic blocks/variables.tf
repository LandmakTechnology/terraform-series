variable "ingressrules" {
    type = list(number)
    default = [80,443,8080]
}

variable "egressrules" {
    type = list(number)
    default = [80,443,25,3306,53,8080]
}

variable "my_instance_type"{
  type = string
  default = "t2.micro"
}
