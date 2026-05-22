resource "aws_subnet" "public" {
  vpc_id = var.vpc_id
  cidr_block = var.public_subnet_cidr
  availability_zone = var.az

    tags = {
        Name = "${var.vpc_name}-public-subnet"
        Environment = var.environment
    }
}