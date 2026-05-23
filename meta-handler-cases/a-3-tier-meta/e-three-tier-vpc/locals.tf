locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project_name
  }

  subnets = {
    public_1 = {
      cidr   = var.public_subnet_1_cidr
      az     = var.availability_zones[0]
      tier   = "Public"
      name   = "public-subnet-1a"
      public = true
    }

    public_2 = {
      cidr   = var.public_subnet_2_cidr
      az     = var.availability_zones[1]
      tier   = "Public"
      name   = "public-subnet-1b"
      public = true
    }

    private_app_1 = {
      cidr   = var.private_app_subnet_1_cidr
      az     = var.availability_zones[0]
      tier   = "Private-App"
      name   = "private-app-subnet-1a"
      public = false
    }

    private_app_2 = {
      cidr   = var.private_app_subnet_2_cidr
      az     = var.availability_zones[1]
      tier   = "Private-App"
      name   = "private-app-subnet-1b"
      public = false
    }

    private_db_1 = {
      cidr   = var.private_db_subnet_1_cidr
      az     = var.availability_zones[0]
      tier   = "Private-DB"
      name   = "private-db-subnet-1a"
      public = false
    }

    private_db_2 = {
      cidr   = var.private_db_subnet_2_cidr
      az     = var.availability_zones[1]
      tier   = "Private-DB"
      name   = "private-db-subnet-1b"
      public = false
    }
  }

  route_tables = {
    public = {
      name = "public-rt"
      type = "igw"
    }

    private_app = {
      name = "private-app-rt"
      type = "nat"
    }

    private_db = {
      name = "private-db-rt"
      type = "nat"
    }
  }
}