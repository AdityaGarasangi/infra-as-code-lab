module "aplha_ec2" {
  source = "./modules/ec2"
  aplha_ec2_ami_id = "ami-08a0d1e16fc3f61ea"
  aplha_ec2_instance_type = var.instance_type
}
