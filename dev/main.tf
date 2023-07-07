# ------------------------------
# Terraform configuration
# ------------------------------
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# ------------------------------
# Provider
# ------------------------------
provider "aws" {
  profile = "terraform"
  region  = "ap-northeast-1"
}

# ------------------------------
# Variables
# ------------------------------
variable "project" {
  type = string
}

variable "enviroment" {
  type = string
}

# ------------------------------
# VPC
# ------------------------------

resource "aws_vpc" "vpc" {
  cidr_block                       = "192.168.0.0/16"
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name = "${var.project}-${var.enviroment}-vpc"
  }
}

# ------------------------------
# Subnet
# ------------------------------
resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-${var.enviroment}-public-subnet-1a"
  }
}

resource "aws_subnet" "public_subnet_1c" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1c"
  cidr_block              = "192.168.2.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-${var.enviroment}-public-subnet-1c"
  }
}

resource "aws_subnet" "private_subnet_1a" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "192.168.3.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-${var.enviroment}-private-subnet-1a"
  }
}

resource "aws_subnet" "private_subnet_1c" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1c"
  cidr_block              = "192.168.4.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-${var.enviroment}-private-subnet-1c"
  }
}

# ------------------------------
# Route table
# ------------------------------
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-${var.enviroment}-public-rt"
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
    Name = "${var.project}-${var.enviroment}-private-rt"
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
