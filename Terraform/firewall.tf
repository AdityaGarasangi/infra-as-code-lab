resource "aws_security_group" "tf_firewall" {
  name        = "tf_firewall"
  description = "This firewall is managed by Terraform"
  # vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.tf_firewall.id

  ip_protocol = "tcp"
  from_port   = 8080
  to_port     = 8089
  cidr_ipv4   = "0.0.0.0/0"

  description = "Allow HTTP from anywhere"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.tf_firewall.id

  ip_protocol = "-1" # "-1" means all protocols
  from_port   = 0
  to_port     = 0
  cidr_ipv4   = "0.0.0.0/0"

  description = "Allow all outbound traffic"
}