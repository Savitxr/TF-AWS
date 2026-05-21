terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}

module "my-ec2" {
  #   source = "git::https://github.com/Savitxr/terraform-jb.git"
  source        = "Savitxr/module/ec2"
  version       = "v1.0.0"
  ami_id        = "ami-0911338d0f0d41ff90"
  instance_type = "t2.micro"
  instance_name = "git-demo"
}