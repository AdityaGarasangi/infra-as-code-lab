output "public-ip" {
  value = "https://${aws_eip.tf_lb.public_ip}:8000"
}

output "Instance-Summary" {
  value = [
    for i in aws_instance.webServers :
    "${i.tags["name"]} has ID ${i.id} in ${var.region}"
  ]
}

