terraform {
  backend "s3" {
    bucket         = "harish-gaddam-bucket123"
    key            = "phase7/spoke/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "YOUR-TERRAFORM-LOCK-TABLE"
    encrypt        = true
  }
}  