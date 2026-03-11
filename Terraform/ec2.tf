resource "aws_instance" "webServers" {
  ami                    = lookup(var.ami_id, var.region) #Map-Fnction
  region                 = var.region
  instance_type          = var.env == "dev" && var.region == "ap-south-2" ? "t3.micro" : "r5.large" #Conditional-Expression
  vpc_security_group_ids = [aws_security_group.tf_firewall.id]

  count = length(var.instance_name) #Collection-Functions

  #Collection functions 
  tags = merge(
    local.common_tags, {
      name         = "${var.instance_name[count.index]}.${local.naming_suffix}"
      CreationDate = formatdate("DD MMM YYY HH:MM", timestamp())
    }
  )

  lifecycle {
    ignore_changes = [tags["CreationDate"]]
  }
}

resource "aws_instance" "DataServer" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  tags = {
    Name = "AL-DataServer"
  }
}