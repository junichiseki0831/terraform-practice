# ---------------------------------------------
# key pair
# ---------------------------------------------
resource "aws_key_pair" "keypair" {
  key_name   = var.key_pair_name
  public_key = file("./terraform-practice.pub")

  tags = {
    Name    = var.key_pair_name
  }
}

# ---------------------------------------------
# EC2 Instance
# ---------------------------------------------
resource "aws_instance" "ec2" {
  ami = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids = var.security_group_ids
  key_name =  aws_key_pair.keypair.key_name

  tags = {
    Name    = var.ec2_name
  }
}
