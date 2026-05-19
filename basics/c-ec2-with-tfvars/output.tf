output "instance_id" {
  value = aws_instance.my_instance-with-tfvars.id
}

output "instance_public_ip" {
    value = aws_instance.my_instance-with-tfvars.public_ip
}
