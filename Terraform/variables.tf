# --- IAM Users ---
variable "username" {
  type = list(string)
}

# --- Security Group / Firewall ---
variable "sg_name" {
  type = string
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