variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "ami_id" {
    type = string
    default = "ami-0c02fb55956c7d316"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "instance_name" {
    type = string
    default = "LeoDasEC2"
}