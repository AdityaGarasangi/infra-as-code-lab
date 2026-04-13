resource "aws_instance" "web_server" {
  ami                    = lookup(var.ami_id, var.region) #Map-Fnction
  region                 = var.region
  instance_type          = local.instance_type
  vpc_security_group_ids = [aws_security_group.tf_firewall.id] #Implicit Resource Dependency

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
    prevent_destroy       = true
    create_before_destroy = true
    ignore_changes        = [tags["CreationDate"]]
    replace_triggered_by  = [vpc_security_group_ids.webServers]
  }
}

/*
resource "aws_instance" "data_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = local.instance_type
  depends_on    = [aws_s3_bucket.dataserver_content] #Explicit Resource Dependency

  tags = {
    Name         = "AL-DataServer"
    CreationDate = formatdate("DD MMM YYY HH:MM", timestamp())
  }

  #Lifecycle Meta-Argument
  lifecycle {
    ignore_changes = [tags]
  }

}
*/

# Removed Blocks
removed {
  from = aws_instance.data_server
  lifecycle {
    destroy = false
  }
}

resource "aws_instance" "appServer" {
  ami                    = "ami-123456"
  instance_type          = var.server_config.instance_type
  vpc_security_group_ids = [aws_security_group.tf_firewall.id]
  key_name               = appserver.pem

  tags = {
    Name = var.server_config.name
  }

  #Remote Provisioner
  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./privatekeys/appserver.pem")
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y nginx",
      "sudo systemctl start nginx"
    ]
    on_failure = continue
  }

  # Local Provisioner
  provisioner "local-exec" {
    command = <<-EOT
      echo "Starting the process" > ./result.txt
      echo "Instance IP: ${self.public_ip}" >> ./result.txt
      echo "Created Instance" >> ./result.txt
      echo "Started nginx in instance" >> ./result.txt
    EOT
  }
  provisioner "local-exec" {
    when       = destroy
    command    = "echo 'Instance was destroyed at $(date)' >> ./result.txt"
    on_failure = continue
  }

  lifecycle {
    # Pre-Condition
    precondition {
      condition     = contains(["m5.large", "r5.xlarge"], var.server_config.instance_type)
      error_message = "Only m5.large , r5.xlarge types are allowed"
    }

    #Post-Condition
    postcondition {
      condition     = self.public_ip != null && self.public_ip != ""
      error_message = "EC2 must have public IP"
    }
  }
}