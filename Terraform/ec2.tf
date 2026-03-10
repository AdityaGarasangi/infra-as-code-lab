resource "aws_instance" "webServers" {
  ami                    = lookup(var.ami_id, var.region) #Map-Fnction
  instance_type          = var.env == "dev" && var.region == "ap-south-2" ? "t3.micro" : "r5.large" #Contional-Expression
  vpc_security_group_ids = [aws_security_group.tf_firewall.id]

  count = length(var.instance_name) #Collection-Functions

  tags = {
    name         = var.instance_name[count.index]
    CreationDate = formatdate("DD MMM YYY HH:MM", timestamp())
  }
}