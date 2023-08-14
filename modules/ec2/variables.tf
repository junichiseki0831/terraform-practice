variable "key_pair_name" {
  type = string
}

variable "ami" {
  type = string
}

variable "ec2_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "instance_type" {
  default = "t2.micro"
  type = string
}

variable "associate_public_ip_address" {
  type = bool
}

variable "security_group_ids" {
  type = list(string)
}
