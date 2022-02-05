variable "aws_region"{
  type = string
  default = "us-west-1"
}

variable "my_ami"{
  type = string
  default = "ami-0e0bf4b3a0c0e0adc"
}

variable "my_instance_type"{
  type = string
  default = "t2.medium"
}

variable "my_key"{
  type = string
  default = "Automationkey"
}
