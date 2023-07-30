# ---------------------------------------------
# Security Group
# ---------------------------------------------
# app security group
resource "aws_security_group" "app_sg" {
  name = var.security_group_name
  description = "application server role security group"
  vpc_id = var.vpc_id

  tags = {
    Name    = var.security_group_name
  }
}

resource "aws_security_group_rule" "app_in_ssh" {
  security_group_id = aws_security_group.app_sg.id
  type = "ingress"
  protocol = "tcp"
  from_port = 22
  to_port = 22
  cidr_blocks = [ "0.0.0.0/0" ]
}

# ssh security group
resource "aws_security_group" "ssh_sg" {
  name = var.security_group_name
  description = "ssh role security group"
  vpc_id = var.vpc_id

  tags = {
    Name    = var.security_group_name
  }
}

resource "aws_security_group_rule" "ssh_in_ssh" {
  security_group_id = aws_security_group.ssh_sg.id
  type = "ingress"
  protocol = "tcp"
  from_port = 22
  to_port = 22
  cidr_blocks = [ "0.0.0.0/0" ]
}
