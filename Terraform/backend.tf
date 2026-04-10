# terraform {
#   backend "local" {
#     path = "terraform.tfstate"
#   }
# }

terraform {
  backend "s3" {
    bucket = "infra-iac-bucket"
    key = "terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
  }
}