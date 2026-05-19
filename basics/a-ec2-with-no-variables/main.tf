terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.44.0"
    }
  }
}

provider "aws" {
        region = "us-east-1"
}

resource "aws_instance" "my_instance" {
    ami = "ami-0c02fb55956c7d316"
    instance_type = "t2.micro"

    tags = {
        Name = "demo-instance"
    }
}