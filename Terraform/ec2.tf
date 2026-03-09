resource "aws_instance" "webServers" {
  ami = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.tf_firewall.id]
  region = var.region

  count = var.instance_count #Count-Meta-Argument

  tags = {
    name = var.instance_name[count.index]
  }
}