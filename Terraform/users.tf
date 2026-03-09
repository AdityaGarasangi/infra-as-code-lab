resource "aws_iam_user" "name" {
  name = var.username[count.index]
}
