terraform {
  backend "s3" {
    bucket = "health-buddy-terraform"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}