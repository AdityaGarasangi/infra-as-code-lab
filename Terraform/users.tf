resource "aws_iam_user" "NonProd_users" {
  for_each = toset(var.username)
  name  = each.value
}

resource "aws_iam_user_policy" "NonProd_users_policy" {
  for_each = toset(var.username)
  name  = "NonProd-policy-${each.value}"
  user  = aws_iam_user.NonProd_users[each.key].name

  policy = file("${path.module}/iam-user-policy.json") #Filesystem-Function
}