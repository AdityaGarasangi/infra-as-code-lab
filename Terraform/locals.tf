# --- EC2 Instance --- 
locals {
  naming_suffix = "${var.region}.${var.instance_type}"

  common_tags = {
    ManagedBy   = "Terraform"
    Project     = "Infra-Lab"
    Environment = var.env
  }
}