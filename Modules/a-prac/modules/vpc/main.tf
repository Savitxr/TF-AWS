resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "${var.vpc_name}-vpc" # ${} tells that the value within is read from a variable block
    Environment = var.environment
  }
}

output "vpc_id" {
    value = aws_vpc.this.id
}

