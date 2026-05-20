output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.vpc.cidr_block
}

output "public_subnets" {
  description = "List of IDs of the public subnets"
  value = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]
}

output "private_app_subnets" {
  description = "List of IDs of the private application subnets"
  value = [
    aws_subnet.private_app_subnet_1.id,
    aws_subnet.private_app_subnet_2.id
  ]
}

output "private_db_subnets" {
  description = "List of IDs of the private database subnets"
  value = [
    aws_subnet.private_db_subnet_1.id,
    aws_subnet.private_db_subnet_2.id
  ]
}

output "nat_gateway_ip" {
  description = "The public IP of the NAT Gateway"
  value       = aws_eip.nat_eip.public_ip
}
