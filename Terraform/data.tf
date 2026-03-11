data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"] #Amazon Linux 2023 64-bit (x86) image
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}