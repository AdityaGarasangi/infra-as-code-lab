resource "aws_iam_user" "NonProd_users" {
  count = length(var.username) #Collection-Functions
  name  = var.username[count.index]
}

resource "aws_iam_user_policy" "NonProd_users_policy" {
  count = length(var.username) #Numeric-Function
  name  = "NonProd-policy-${var.username[count.index]}"
  user  = aws_iam_user.NonProd_users[count.index].name

  policy = file("./iam-user-policy.json") #Filesystem-Function
}