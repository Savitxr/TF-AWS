resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.project_name}-vpc"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.project_name}-igw"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name        = "${var.project_name}-nat-eip"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name        = "${var.project_name}-nat-gw"
    Environment = var.environment
    Project     = var.project_name
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-public-subnet-1a"
    Environment = var.environment
    Tier        = "Public"
    Project     = var.project_name
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-public-subnet-1b"
    Environment = var.environment
    Tier        = "Public"
    Project     = var.project_name
  }
}

resource "aws_subnet" "private_app_subnet_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_app_subnet_1_cidr
  availability_zone = var.availability_zones[0]

  tags = {
    Name        = "${var.project_name}-private-app-subnet-1a"
    Environment = var.environment
    Tier        = "Private-App"
    Project     = var.project_name
  }
}

resource "aws_subnet" "private_app_subnet_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_app_subnet_2_cidr
  availability_zone = var.availability_zones[1]

  tags = {
    Name        = "${var.project_name}-private-app-subnet-1b"
    Environment = var.environment
    Tier        = "Private-App"
    Project     = var.project_name
  }
}

resource "aws_subnet" "private_db_subnet_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_db_subnet_1_cidr
  availability_zone = var.availability_zones[0]

  tags = {
    Name        = "${var.project_name}-private-db-subnet-1a"
    Environment = var.environment
    Tier        = "Private-DB"
    Project     = var.project_name
  }
}

resource "aws_subnet" "private_db_subnet_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_db_subnet_2_cidr
  availability_zone = var.availability_zones[1]

  tags = {
    Name        = "${var.project_name}-private-db-subnet-1b"
    Environment = var.environment
    Tier        = "Private-DB"
    Project     = var.project_name
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${var.project_name}-public-rt"
    Environment = var.environment
    Project     = var.project_name
  }
}

# --- Private Route Table (App Subnets) ---
resource "aws_route_table" "private_app_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name        = "${var.project_name}-private-app-rt"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_route_table" "private_db_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name        = "${var.project_name}-private-db-rt"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_route_table_association" "public_1_assoc" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_2_assoc" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_app_1_assoc" {
  subnet_id      = aws_subnet.private_app_subnet_1.id
  route_table_id = aws_route_table.private_app_rt.id
}

resource "aws_route_table_association" "private_app_2_assoc" {
  subnet_id      = aws_subnet.private_app_subnet_2.id
  route_table_id = aws_route_table.private_app_rt.id
}

resource "aws_route_table_association" "private_db_1_assoc" {
  subnet_id      = aws_subnet.private_db_subnet_1.id
  route_table_id = aws_route_table.private_db_rt.id
}

resource "aws_route_table_association" "private_db_2_assoc" {
  subnet_id      = aws_subnet.private_db_subnet_2.id
  route_table_id = aws_route_table.private_db_rt.id
}
