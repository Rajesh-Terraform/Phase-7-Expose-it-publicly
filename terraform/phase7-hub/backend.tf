terraform {
  backend "s3" {
    bucket         = "rajesh-terraform-state-878962827886"
    key            = "phase7/hub/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "YOUR-TERRAFORM-LOCK-TABLE"
    encrypt        = true
  }
}   