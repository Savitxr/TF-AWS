resource "aws_internet_gateway" "myigw" {
    vpc_id = var.vpc_id
}

variable "vpc_id" {
    type = string
}