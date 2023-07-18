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
# Locals
# ------------------------------
locals {
  project              = "terraform-practice"
  env                  = "dev"
  availability_zone_1a = "1a"
  availability_zone_1c = "1c"
}

# ------------------------------
# Module
# ------------------------------
module "network" {
  source                   = "../modules/network"
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

module "nat_gateway" {
  source              = "../modules/nat_gateway"
  elastic_ip_name_1a  = "${local.project}-${local.env}-eip-${local.availability_zone_1a}"
  elastic_ip_name_1c  = "${local.project}-${local.env}-eip-${local.availability_zone_1c}"
  nat_gateway_name_1a = "${local.project}-${local.env}-ngw-${local.availability_zone_1a}"
  nat_gateway_name_1c = "${local.project}-${local.env}-ngw-${local.availability_zone_1c}"
  public_subnet_id_1a = module.network.public_subnet_id_1a
  public_subnet_id_1c = module.network.public_subnet_id_1c
}
