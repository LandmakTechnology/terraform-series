## **Variables**

- A variable is a value that can change, depending on conditions or on information passed to the program.
- Variables are used to store information to be referenced and manipulated in a computer program.
- They also provide a way of labeling data with a descriptive name, so our programs can be understood more clearly by the reader and ourselves.
- It is helpful to think of variables as containers that hold information. Their sole purpose is to label and store data in memory. This data can then be used throughout your program.

The following example shows the variable types that are supported by terraform.

#**String**
 - Strings are usually represented by a double-quoted sequence of Unicode characters, "like this"
```t
variable "vpcname" {
  type    = string
  default = "myvpc"
}

```
#**Number**

- Numbers are represented by unquoted sequences of digits with or without a decimal point, like 15 or 6.283185.
```t
variable "sshport" {
  type    = number
  default = 22
}
```

#**Boolean**
- Bools are represented by the unquoted symbols true and false.
```t
variable "enabled" {
  default = false
}
```
#**List**
- Lists is represented by a pair of square brackets containing a comma-separated sequence of values, like ["a", 15, true].
```t
variable "mylist" {
  type    = list(string)
  default = ["Value1", "Value2"]
}
```
#How to reference List values ?

instance_type = var.mylist[1]

#**Map**
- Maps/objects are represented by a pair of curly braces containing a series of <KEY> = <VALUE> pairs:
```T
variable "mymap" {
  type = map
  default = {
    Key1 = "Value1"
    Key2 = "Value2"
  }
}
```
#How to reference Map values ?
 
instance_type = var.mymap["key1"]

#**Input**
 ```t
variable "inputname" {
  type        = string
  description = "Set the name of the VPC"
}
```
- note that if no default value is provided, then the variable will be an input variable and will prompt you to enter a value at runtime.

 ```t
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.inputname
  }
}
```
#**Output**
```t
output "vpcid" {
  value = aws_vpc.myvpc.id
}
```
#**Tuple**
- Lists/tuples are represented by a pair of square brackets containing a comma-separated sequence of values, like ["a", 15, true].
```t
variable "mytuple" {
  type    = tuple([string, number, string])
  default = ["cat", 1, "dog"]
}
```
#**Objects**
```t
variable "myobject" {
  type = object({ name = string, port = list(number) })
  default = {
    name = "Landmark"
    port = [22, 25, 80]
  }
}
```
#**Variables with Lists and Maps**

#AWS EC2 Instance Type - List
```t
 variable "instance_type_list" {
  description = "EC2 Instance Type"
  type = list(string)
  default = ["t3.micro", "t3.small"]
}

#instance_type = var.instance_type_list[0]
```
 
#AWS EC2 Instance Type - Map
```t
 variable "instance_type_map" {
  description = "EC2 Instance Type"
  type = map(string)
  default = {
    "dev" = "t3.micro"
    "qa"  = "t3.small"
    "prod" = "t3.large"
  }
}

#instance_type = var.instance_type_map["qa"]
```
