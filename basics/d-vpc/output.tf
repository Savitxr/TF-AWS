output "vpc_id" {
    value = aws_vpc.my_vpc.id
}

output "subnet_id" {
    value = aws_subnet.my_subnet.id
}

output "vpc_owner" {
    value = aws_vpc.my_vpc.owner_id
}

output "created_by" {
  value = aws_vpc.my_vpc.arn
}