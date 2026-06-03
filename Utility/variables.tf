variable "aws_region" {
  type        = string
  description = "The AWS region to deploy resources into."
  default     = "us-east-1"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type        = string
  description = "The CIDR block for the public subnet."
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  type        = string
  description = "The CIDR block for the private subnet."
  default     = "10.0.2.0/24"
}

variable "bastion_instance_type" {
  type        = string
  description = "EC2 instance type for the Bastion host."
  default     = "t3.micro"
}

variable "private_instance_type" {
  type        = string
  description = "EC2 instance type for the private instance."
  default     = "t3.micro"
}

variable "key_name" {
  type        = string
  description = "The name of the existing AWS Key Pair to use for SSH access."
  default     = "JayabaaskarB"
}

variable "allowed_ssh_cidr" {
  type        = string
  description = "CIDR block permitted to SSH into the Bastion host (e.g., your public IP like 203.0.113.50/32)."
  default     = "0.0.0.0/0"
}

variable "ami_id" {
  type        = string
  description = "The Ubuntu AMI ID to use for both the Bastion and Private instances."
  default     = "ami-091138d0f0d41ff90"
}

