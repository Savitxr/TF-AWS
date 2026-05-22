terraform {
  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "dev_vpc" {
  source      = "./modules/vpc"
  vpc_name    = "dev"
  vpc_cidr    = "10.0.0.0/16"
  environment = "dev"
}

module "dev_subnet" {
  source             = "./modules/subnet"
  vpc_id             = module.dev_vpc.vpc_id
  vpc_name           = "dev"
  az                 = "us-east-1a"
  public_subnet_cidr = "10.0.1.0/24"
  environment        = "dev"
}

module "prod_vpc" {
  source      = "./modules/vpc"
  vpc_name    = "prod"
  vpc_cidr    = "10.10.0.0/16"
  environment = "prod"
}

module "prod_subnet" {
  source             = "./modules/subnet"
  vpc_id             = module.prod_vpc.vpc_id
  vpc_name           = "prod"
  public_subnet_cidr = "10.10.1.0/24"
  az                 = "us-east-1a"
  environment        = "prod"
}
