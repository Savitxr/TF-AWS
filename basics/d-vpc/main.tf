resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = "terra-vpc"
    }
}

resource "aws_subnet" "my_subnet_a" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.subnet_cidr
    availability_zone = var.availability_zone

    tags = {
        Name = "Subnet-1a"
    }
  
}
resource "aws_subnet" "my_subnet_b" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.subnet_cidr
    availability_zone = var.availability_zone

    tags = {
        Name = "Subnet-1b"
    }
  
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  
}
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}
resource "aws_nat_gateway" "my_nat" {  
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.my_subnet_a.id

    tags = {
        Name = "nat-gw"
    }
}

resource "aws_route_table" "subnet_a_rt" {
    vpc_id = aws_vpc.my_vpc

    route {
        cidr_block = var.subnet_cidr
        gateway_id = aws_internet_gateway.my_igw.id
    }
    tags = {
        Name = "RouteTableOfA"
    }
}
