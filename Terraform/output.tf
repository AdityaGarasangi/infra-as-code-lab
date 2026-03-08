output "public-ip" {
  value = "https://${aws_eip.tf_lb.public_ip}:8000"
}
