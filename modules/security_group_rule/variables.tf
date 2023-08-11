variable "protocol" {
  type = string
}

variable "from_port" {
  type = number
}

variable "to_port" {
  type = number
}

variable "cidr_block" {
  type = list(string)
  default = [ "0.0.0.0/0" ]
}

variable "security_group_id" {
  type = string
}
