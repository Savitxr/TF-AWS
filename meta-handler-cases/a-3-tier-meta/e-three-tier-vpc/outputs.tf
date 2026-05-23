output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.vpc.id
}

output "vpc_cidr" {
  description = "VPC CIDR"
  value       = aws_vpc.vpc.cidr_block
}

output "public_subnets" {
  value = [
    for key, subnet in aws_subnet.subnets :
    subnet.id
    if subnet.tags.Tier == "Public"
  ]
}

output "private_app_subnet" {
  value = [
    for key, subnet in aws_subnet.subnets :
    subnet.id
    if subnet.tags.Tier == "Private-App"
  ]
}

output "private_db_subnets" {
  value = [
    for key, subnet in aws_subnet.subnets :
    subnet.id
    if subnet.tags.Tier == "Private-DB"
  ]
}

output "nat_gateway_ip" {
  value = aws_eip.nat_eip.public_ip
}