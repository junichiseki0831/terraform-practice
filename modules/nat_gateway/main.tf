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
