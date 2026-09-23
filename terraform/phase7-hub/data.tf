data "terraform_remote_state" "spoke" {
  backend = "s3"

  config = {
    bucket = var.spoke_state_bucket
    key    = var.spoke_state_key
    region = var.aws_region
  }
} 