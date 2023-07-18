# ------------------------------
# Module
# ------------------------------
locals {
  project              = "terraform-practice"
  env                  = "dev"
  availability_zone_1a = "1a"
  availability_zone_1c = "1c"
}

module "network" {
  source  = "../network"
  availability_zone_1a     = "1a"
  availability_zone_1c     = "1c"
  vpc_name                 = "${local.project}-${local.env}-vpc"
  public_route_table_name  = "${local.project}-${local.env}-public-rt"
  private_route_table_name = "${local.project}-${local.env}-private-rt"
  public_subnet_name_1a    = "${local.project}-${local.env}-public-subnet-${local.availability_zone_1a}"
  public_subnet_name_1c    = "${local.project}-${local.env}-public-subnet-${local.availability_zone_1c}"
  private_subnet_name_1a   = "${local.project}-${local.env}-private-subnet-${local.availability_zone_1a}"
  private_subnet_name_1c   = "${local.project}-${local.env}-private-subnet-${local.availability_zone_1c}"
  internet_gateway_name    = "${local.project}-${local.env}-igw"
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
  subnet_id     = var.public_subnet_id_1a
  allocation_id = aws_eip.nat_1a.id

  tags = {
    Name = var.nat_gateway_name_1a
  }
}

resource "aws_nat_gateway" "nat_1c" {
  subnet_id     = var.public_subnet_id_1c
  allocation_id = aws_eip.nat_1c.id

  tags = {
    Name = var.nat_gateway_name_1c
  }
}
