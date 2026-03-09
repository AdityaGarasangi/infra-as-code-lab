#users
variable "username" {
  type = string
}

#firewall
variable "sg_name" {
  type = string
}
variable "vpn_static_ip" {
    type = string
}
variable "https_port" {
    type = number
}
variable "app_port" {
    type = number
}
variable "ssh_port" {
    type = number
}

#ec2Instance
variable "ami_id" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "region" {
  type = string
}
