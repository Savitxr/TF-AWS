output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}