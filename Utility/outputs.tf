output "bastion_public_ip" {
  description = "The public IP address of the Bastion Host."
  value       = aws_instance.bastion.public_ip
}

output "private_instance_private_ip" {
  description = "The private IP address of the private EC2 instance."
  value       = aws_instance.private_instance.private_ip
}

output "ssh_connection_command" {
  description = "Convenient SSH ProxyJump command to connect directly to the private instance through the Bastion host."
  value       = "ssh -i /path/to/${var.key_name}.pem -J ubuntu@${aws_instance.bastion.public_ip} ubuntu@${aws_instance.private_instance.private_ip}"
}

