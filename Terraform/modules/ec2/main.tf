terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}


resource "aws_instance" "alpha_ec2" {
  ami = var.aplha_ec2_ami_id
  instance_type = var.aplha_ec2_instance_type
}