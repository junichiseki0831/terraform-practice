# ------------------------------
# VPC
# ------------------------------

resource "aws_vpc" "vpc" {
  cidr_block                       = var.vpc_cidr_block
  instance_tenancy                 = "default"
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name = var.vpc_name
  }
}

# ------------------------------
# Subnet
# ------------------------------
resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = var.public-subnet-cidr-block-1a
  map_public_ip_on_launch = false

  tags = {
    Name = var.public_subnet_name_1a
  }
}

resource "aws_subnet" "public_subnet_1c" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1c"
  cidr_block              = var.public-subnet-cidr-block-1c
  map_public_ip_on_launch = false

  tags = {
    Name = var.public_subnet_name_1c
  }
}

resource "aws_subnet" "private_subnet_1a" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = var.private-subnet-cidr-block-1a
  map_public_ip_on_launch = false

  tags = {
    Name = var.private_subnet_name_1a
  }
}

resource "aws_subnet" "private_subnet_1c" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1c"
  cidr_block              = var.private-subnet-cidr-block-1c
  map_public_ip_on_launch = false

  tags = {
    Name = var.private_subnet_name_1c
  }
}

# ------------------------------
# Route table
# ------------------------------
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.public_route_table_name
  }
}

resource "aws_route_table_association" "public_rt_1a" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public_subnet_1a.id
}

resource "aws_route_table_association" "public_rt_1c" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public_subnet_1c.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.private_route_table_name
  }
}

resource "aws_route_table_association" "private_rt_1a" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.private_subnet_1a.id
}

resource "aws_route_table_association" "private_rt_1c" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.private_subnet_1c.id
}

# ------------------------------
# Internet Gateway
# ------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.internet_gateway_name
  }
}

resource "aws_route" "public_rt_igw_r" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# ------------------------------
# Elastic IP
# ------------------------------
resource "aws_eip" "nat_1a" {
  domain = "vpc"

  tags = {
    Name = var.elastic_ip_name_1a
  }
}

resource "aws_eip" "nat_1c" {
  domain = "vpc"

  tags = {
    Name = var.elastic_ip_name_1c
  }
}

# ------------------------------
# Nat Gateway
# ------------------------------
resource "aws_nat_gateway" "nat_1a" {
  subnet_id     = aws_subnet.public_subnet_1a.id
  allocation_id = aws_eip.nat_1a.id

  tags = {
    Name = var.nat_gateway_name_1a
  }
}

resource "aws_nat_gateway" "nat_1c" {
  subnet_id     = aws_subnet.public_subnet_1c.id
  allocation_id = aws_eip.nat_1c.id

  tags = {
    Name = var.nat_gateway_name_1c
  }
}
