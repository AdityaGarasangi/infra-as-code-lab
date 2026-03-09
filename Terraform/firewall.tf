#Security Group
resource "aws_security_group" "tf_firewall" {
  name        = var.sg_name
  description = "This firewall is managed by Terraform"
  # vpc_id      = var.vpc_id
}

/*
#Inound Rules for Security Group
resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.tf_firewall.id #Cross-Resource Attribute Reference 
  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443
  cidr_ipv4   = "0.0.0.0/0" 
  description = "Allow HTTP from anywhere"
}

resource "aws_vpc_security_group_ingress_rule" "allow_app" {
  security_group_id = aws_security_group.tf_firewall.id #Cross-Resource Attribute Reference 
  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443
  cidr_ipv4   = "${aws_eip.tf_lb.public_ip}/32" #Cross-Resource Attribute Reference 
  description = "Allow HTTP from anywhere"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.tf_firewall.id #Cross-Resource Attribute Reference 
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
  cidr_ipv4   = "${aws_eip.tf_lb.public_ip}/32" #Cross-Resource Attribute Reference 
  description = "Allow HTTP from anywhere"
}
*/

#Inound Rules for Security Group
resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.tf_firewall.id #Cross-Resource Attribute Reference
  ip_protocol       = "tcp"
  from_port         = var.https_port #using variables
  to_port           = var.https_port #using variables
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow HTTPS from Anywhere"
}

resource "aws_vpc_security_group_ingress_rule" "app" {
  security_group_id = aws_security_group.tf_firewall.id #Cross-Resource Attribute Reference 
  ip_protocol       = "tcp"
  from_port         = var.app_port      #using variables
  to_port           = var.app_port      #using variables
  cidr_ipv4         = var.vpn_static_ip #using variables
  description       = "Allow Internal/admin from VPN static IP only"
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.tf_firewall.id #Cross-Resource Attribute Reference 
  ip_protocol       = "tcp"
  from_port         = var.ssh_port      #using variables
  to_port           = var.ssh_port      #using variables
  cidr_ipv4         = var.vpn_static_ip #using varibales
  description       = "Allow SSH from VPN static IP only"
}


#Outbound Rules for Security Group
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.tf_firewall.id #Cross-Resource Attribute Reference 
  ip_protocol       = "-1"
  from_port         = 0
  to_port           = 0
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow all outbound traffic"
}