variable "aws_region" {
  type = string
}

variable "instance_ami" {
  type = string  
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "instance_name" {  
  type = string
}

variable "environment" {
  type = string
}