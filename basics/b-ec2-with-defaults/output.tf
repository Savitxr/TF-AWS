output "instance_id" {
  value = aws_instance.my_instance-with-default.id
}

output "instance_public_ip" {
    value = aws_instance.my_instance-with-default.public_ip
}

output "instance_arn" {
    value = aws_instance.my_instance-with-default.arn
}