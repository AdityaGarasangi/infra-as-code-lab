output "public-ip" {
  value = "https://${aws_eip.tf_lb.public_ip}:8000"
}

output "Instance-Summary" {
  value = [
    for i in aws_instance.webServers :
    "${i.tags["name"]} has ID ${i.id} in ${var.region}"
  ]
}

output "arns" {
  value = aws_iam_user.NonProd_users[*].arn
}

output "name" {
  value = aws_iam_user.NonProd_users[*].name
}

#--- ZipMap Function ---
output "Users_Created" {
  value = zipmap(aws_iam_user.NonProd_users[*].name, aws_iam_user.NonProd_users[*].arn)
}