# --- IAM Users ---
variable "username" {
  type = list(string)
}

# --- Security Group / Firewall ---
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

# --- EC2 Instance Configuration ---
variable "env" {
  type    = string
  default = "dev"
}

variable "instance_name" {
  type = list(string)
}

variable "ami_id" {
  type = map(string) # Changed 'any' to 'string' for better validation
}

variable "region" {
  type = string
}

variable "sg_inbound_rules" {
  type = map(object({
    port     = number
    protocol = string
    cidr     = string
  }))
}