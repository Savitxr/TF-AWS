variable "aws_region" {
  type        = string
  description = "The AWS region to deploy resources into"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  type        = string
  description = "CIDR block for public subnet 1 (Tier 1 - Web/Frontend AZ A)"
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  type        = string
  description = "CIDR block for public subnet 2 (Tier 1 - Web/Frontend AZ B)"
  default     = "10.0.2.0/24"
}

variable "private_app_subnet_1_cidr" {
  type        = string
  description = "CIDR block for private app subnet 1 (Tier 2 - Application AZ A)"
  default     = "10.0.11.0/24"
}

variable "private_app_subnet_2_cidr" {
  type        = string
  description = "CIDR block for private app subnet 2 (Tier 2 - Application AZ B)"
  default     = "10.0.12.0/24"
}

variable "private_db_subnet_1_cidr" {
  type        = string
  description = "CIDR block for private database subnet 1 (Tier 3 - DB AZ A)"
  default     = "10.0.21.0/24"
}

variable "private_db_subnet_2_cidr" {
  type        = string
  description = "CIDR block for private database subnet 2 (Tier 3 - DB AZ B)"
  default     = "10.0.22.0/24"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of Availability Zones to distribute subnets across"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "environment" {
  type        = string
  description = "Environment name used for tagging resources"
  default     = "development"
}

variable "project_name" {
  type        = string
  description = "Project name prefix for tags and naming resources"
  default     = "3-tier-learning"
}
