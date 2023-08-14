# ---------------------------------------------
# EC2 Instance
# ---------------------------------------------
resource "aws_instance" "ec2" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids = var.security_group_ids
  key_name =  var.key_pair_name

  tags = {
    Name    = var.ec2_name
  }
}
