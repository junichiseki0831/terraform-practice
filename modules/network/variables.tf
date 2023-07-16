# variable "project" {
#   type = string
# }

# variable "env" {
#   type = string
# }
variable "vpc_cidr_block" {
  default = "192.168.0.0/16"
  type = string
}

variable "public-subnet-cidr-block-1a" {
  default = "192.168.1.0/24"
  type = string
}

variable "public-subnet-cidr-block-1c" {
  default = "192.168.2.0/24"
  type = string
}

variable "private-subnet-cidr-block-1a" {
  default = "192.168.3.0/24"
  type = string
}

variable "private-subnet-cidr-block-1c" {
  default = "192.168.4.0/24"
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

variable "elastic_ip_name_1a" {
  type = string
}

variable "elastic_ip_name_1c" {
  type = string
}

variable "nat_gateway_name_1a" {
  type = string
}

variable "nat_gateway_name_1c" {
  type = string
}
