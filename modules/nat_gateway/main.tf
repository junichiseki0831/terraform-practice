# ------------------------------
# Elastic IP
# ------------------------------
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = var.elastic_ip_name_nat
  }
}

# ------------------------------
# Nat Gateway
# ------------------------------
resource "aws_nat_gateway" "ngw" {
  subnet_id     = var.public_subnet_id
  allocation_id = aws_eip.nat_eip.id

  tags = {
    Name = var.nat_gateway_name
  }
}

resource "aws_route" "private_rt_ngw" {
  route_table_id         = var.private_rt_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.ngw.id
}
