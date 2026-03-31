# --- IAM Users ---
variable "username" {
  type = list(string)
  # Input Validation
  validation {
    condition     = length(var.username) <= 12
    error_message = "The number of usernames must be 12 or fewer"
  }
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

variable "instance_name" {}
variable "instance_type" {}

variable "ami_id" {
  type = map(string) # Changed 'any' to 'string' for better validation
}

variable "region" {
  type = string
}

#--- Data Type - Object ---
variable "server_config" {
  type = object({
    name          = string
    instance_type = string
    volume_size   = number
  })
}

variable "sg_inbound_rules" {
  type = map(object({
    port     = number
    protocol = string
    cidr     = string
  }))
}