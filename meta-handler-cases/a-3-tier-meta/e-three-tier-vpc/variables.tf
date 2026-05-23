variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  type    = string
  default = "10.0.2.0/24"
}

variable "private_app_subnet_1_cidr" {
  type    = string
  default = "10.0.11.0/24"
}

variable "private_app_subnet_2_cidr" {
  type    = string
  default = "10.0.12.0/24"
}

variable "private_db_subnet_1_cidr" {
  type    = string
  default = "10.0.21.0/24"
}

variable "private_db_subnet_2_cidr" {
  type    = string
  default = "10.0.22.0/24"
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "environment" {
  type    = string
  default = "development"
}

variable "project_name" {
  type    = string
  default = "3-tier-mh"
}
