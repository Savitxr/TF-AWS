resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "demo-vpc"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "demo-igw"
  }
}

resource "aws_subnet" "public" {
  count = 2

  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = "us-east-1${element(["a", "b"], count.index)}"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index + 1}" #dynamically gives tags as 1,2,3...
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public_1_assoc" {
  subnet_id      = aws_subnet.public[0].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_2_assoc" {
  subnet_id      = aws_subnet.public[1].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow HTTP"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "alb-sg"
  }
}


module "alb" {
  source  = "Savitxr/alb/aws"
  version = "1.0.0"

  alb_name = "demo-alb"

  internal = false

  vpc_id = aws_vpc.my_vpc.id

  subnet_ids = aws_subnet.public[*].id

  security_group_ids = [
    aws_security_group.alb_sg.id
  ]

  listener_port     = 80
  listener_protocol = "HTTP"

  target_port     = 80
  target_protocol = "HTTP"

  health_check_path = "/"

  tags = {
    Environment = "dev"
    Project     = "terraform-demo"
  }
}



