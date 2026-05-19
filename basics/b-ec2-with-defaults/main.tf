terraform {
  required_providers {
    aws = {
        source = "registry.terraform.io/hashicorp/aws"
        version = "~> 6.0"
    }
  }
}

provider "aws" {
    region = var.aws_region
}

resource "aws_instance" "my_instance-with-default" {
    ami = var.ami_id
    instance_type = var.instance_type

    tags = {
        Name = var.instance_name
    }
}