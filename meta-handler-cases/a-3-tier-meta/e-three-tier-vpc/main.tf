resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-vpc"
    }
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-igw"
    }
  )
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-nat-eip"
    }
  )
}

resource "aws_subnet" "subnets" {
  for_each = local.subnets

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = each.value.public

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${each.value.name}"
      Tier = each.value.tier
    }
  )
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.subnets["public_1"].id

  depends_on = [aws_internet_gateway.igw]

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-nat-gw"
    }
  )
}

resource "aws_route_table" "route_tables" {
  for_each = local.route_tables

  vpc_id = aws_vpc.vpc.id

  dynamic "route" {
    for_each = [1]

    content {
      cidr_block = "0.0.0.0/0"

      gateway_id = each.value.type == "igw" ? aws_internet_gateway.igw.id : null

      nat_gateway_id = each.value.type == "nat" ? aws_nat_gateway.nat_gw.id : null
    }
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${each.value.name}"
    }
  )
}

resource "aws_route_table_association" "assoc" {
  for_each = {
    public_1      = "public"
    public_2      = "public"
    private_app_1 = "private_app"
    private_app_2 = "private_app"
    private_db_1  = "private_db"
    private_db_2  = "private_db"
  }

  subnet_id = aws_subnet.subnets[each.key].id

  route_table_id = aws_route_table.route_tables[each.value].id
}


# resource "aws_security_group" "alb_sg" {
#   name        = "alb-sg"
#   description = "Allow HTTP"
#   vpc_id      = aws_vpc.vpc.id

#   ingress {
#     description = "HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   tags = {
#     Name = "alb-sg"
#   }
# }

# module "alb" {
#   source = "Savitxr/alb/aws"
#   version = "1.0.0"
#   alb_name = "alb-from-module"
#   internal = false
#   vpc_id = aws_vpc.vpc.id
#   subnet_ids = [
#     for key,subnet in aws_subnet.subnets:
#     subnet.id
#     if subnet.tags.Tier == "Public"
#   ]
#   security_group_ids = [aws_security_group.alb_sg.id]

#   listener_port = 80
#   listener_protocol = "HTTP"

#   target_port = 80
#   target_protocol = "HTTP"

#   health_check_path = "/"

#   tags = merge(
#     local.common_tags, {
#       Name = "${var.project_name}-alb"
#     }
#   )
# }