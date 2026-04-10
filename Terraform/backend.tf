# terraform {
#   backend "local" {
#     path = "terraform.tfstate"
#   }
# }

terraform {
  backend "s3" {
    bucket = "infra-iac-bucket"
    key = "/key/infra-iac-bucket.pem"
    region = "us-east-1"
  }
}