# --- EC2 Instance --- 
locals {
  instance_type = var.env == "dev" && var.region == "ap-south-2" ? "t3.micro" : "r5.large" #Conditional-Expression

  naming_suffix = "${var.region}.${local.instance_type}"

  common_tags = {
    ManagedBy   = "Terraform"
    Project     = "Infra-Lab"
    Environment = var.env
  }
}
