# ---------------------------------------------
# Security Group Rule
# ---------------------------------------------
resource "aws_security_group_rule" "inbound_rule" {
  type = "ingress"
  protocol = var.protocol
  from_port = var.from_port
  to_port = var.to_port
  cidr_blocks = var.cidr_block
  security_group_id = var.security_group_id
}
