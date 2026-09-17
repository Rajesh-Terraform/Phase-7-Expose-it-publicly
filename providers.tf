terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket = "harish-gaddam-bucket123"
    key    = "phase7/terraform.tfstate"
    region = "ap-south-1"
  }
}

# --------------------------------------------------
# Spoke Account
# GitHub Actions assumes this account
# --------------------------------------------------

provider "aws" {
  region = var.aws_region
}

# --------------------------------------------------
# Hub Account
# Terraform assumes a role in the Hub account
# --------------------------------------------------

provider "aws" {
  alias  = "hub"
  region = var.aws_region

  assume_role {
    role_arn = var.hub_role_arn
  }
} 