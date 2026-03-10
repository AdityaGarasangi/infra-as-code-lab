resource "aws_instance" "webServers" {
  ami = var.ami_id
  instance_type = var.env == "dev" && var.region == "ap-south-2" ? "t3.micro" : "r5.large"
  vpc_security_group_ids = [aws_security_group.tf_firewall.id]

  count = var.instance_count #Count-Meta-Argument

  tags = {
    name = var.instance_name[count.index]
  }
}