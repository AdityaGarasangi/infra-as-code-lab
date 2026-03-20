resource "aws_instance" "webServers" {
  ami                    = lookup(var.ami_id, var.region) #Map-Fnction
  region                 = var.region
  instance_type          = local.instance_type
  vpc_security_group_ids = [aws_security_group.tf_firewall.id]

  count = length(var.instance_name) #Collection-Functions

  #Collection functions 
  tags = merge(
    local.common_tags, {
      name         = "${var.instance_name[count.index]}.${local.naming_suffix}"
      CreationDate = formatdate("DD MMM YYY HH:MM", timestamp())
    }
  )

  #Lifecycle Meta-Argument
  lifecycle {
    prevent_destroy = true
    create_before_destroy = true
    ignore_changes = [tags["CreationDate"]]
    replace_triggered_by = [vpc_security_group_ids]
  }
}

resource "aws_instance" "DataServer" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = local.instance_type

  tags = {
    Name = "AL-DataServer"
    CreationDate = formatdate("DD MMM YYY HH:MM", timestamp())
  }

  #Lifecycle Meta-Argument
  lifecycle {
    ignore_changes = [tags]
  }

}