variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "availability_zone_1a" {
  type = string
}

variable "availability_zone_1c" {
  type = string
}

variable "vpc_name" {
  type = string
}
variable "public_route_table_name" {
  type = string
}

variable "private_route_table_name" {
  type = string
}

variable "public_subnet_name_1a" {
  type = string
}

variable "public_subnet_name_1c" {
  type = string
}

variable "private_subnet_name_1a" {
  type = string
}

variable "private_subnet_name_1c" {
  type = string
}

variable "internet_gateway_name" {
  type = string
}
