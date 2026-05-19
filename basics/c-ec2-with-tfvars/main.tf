resource "aws_instance" "my_instance-with-tfvars" {
    ami = var.instance_ami
    instance_type = var.instance_type

    tags = {
        Name = var.instance_name
        Environment = var.environment
    }
}
