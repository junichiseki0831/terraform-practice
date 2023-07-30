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

module "nat_gateway_1a" {
  source              = "../modules/nat_gateway"
  elastic_ip_name_nat = "${local.project}-${local.env}-eip-${local.availability_zone_1a}"
  nat_gateway_name    = "${local.project}-${local.env}-ngw-${local.availability_zone_1a}"
  public_subnet_id    = module.network.public_subnet_id_1a
}

module "nat_gateway_1c" {
  source              = "../modules/nat_gateway"
  elastic_ip_name_nat = "${local.project}-${local.env}-eip-${local.availability_zone_1c}"
  nat_gateway_name    = "${local.project}-${local.env}-ngw-${local.availability_zone_1c}"
  public_subnet_id    = module.network.public_subnet_id_1c
}

module "security_group_ssh" {
  source              = "../modules/security_group"
  security_group_name = "${local.project}-${local.env}-ssh-sg"
  vpc_id              = module.network.vpc
}

module "security_group_app" {
  source              = "../modules/security_group"
  security_group_name = "${local.project}-${local.env}-app-sg"
  vpc_id              = module.network.vpc
}

module "ec2_ssh_1a" {
  source                      = "../modules/ec2"
  key_pair_name               = "${local.project}-${local.env}-key-pair"
  ec2_name                    = "${local.project}-${local.env}-ssh-ec2-${local.availability_zone_1a}"
  subnet_id                   = module.network.public_subnet_id_1a
  associate_public_ip_address = true
  security_group_ids          = [module.security_group_ssh.ssh_sg]
}

module "ec2_ssh_1c" {
  source                      = "../modules/ec2"
  key_pair_name               = "${local.project}-${local.env}-key-pair"
  ec2_name                    = "${local.project}-${local.env}-ssh-ec2-${local.availability_zone_1c}"
  subnet_id                   = module.network.public_subnet_id_1c
  associate_public_ip_address = true
  security_group_ids          = [module.security_group_ssh.ssh_sg]
}

module "ec2_app_1a" {
  source                      = "../modules/ec2"
  key_pair_name               = "${local.project}-${local.env}-key-pair"
  ec2_name                    = "${local.project}-${local.env}-ssh-ec2-${local.availability_zone_1a}"
  subnet_id                   = module.network.private_subnet_id_1a
  associate_public_ip_address = false
  security_group_ids          = [module.security_group_app.app_sg]
}

module "ec2_app_1c" {
  source                      = "../modules/ec2"
  key_pair_name               = "${local.project}-${local.env}-key-pair"
  ec2_name                    = "${local.project}-${local.env}-ssh-ec2-${local.availability_zone_1c}"
  subnet_id                   = module.network.private_subnet_id_1c
  associate_public_ip_address = false
  security_group_ids          = [module.security_group_app.app_sg]
}
