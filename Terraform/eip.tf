resource "aws_eip" "tf_lb" {
  domain = "vpc"
}

resource "aws_eip_association" "tf_lb_assoc" {
  instance_id   = aws_instance.my_ec2.id
  allocation_id = aws_eip.tf_lb.id
}