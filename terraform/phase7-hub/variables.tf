variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "hub_vpc_id" {
  description = "Hub VPC ID"
  type        = string
}

variable "hub_public_subnet_ids" {
  description = "Hub public subnet IDs"
  type        = list(string)
}

variable "hub_private_subnet_ids" {
  description = "Hub private subnet IDs for interface endpoint"
  type        = list(string)
}

variable "spoke_state_bucket" {
  description = "S3 bucket containing Spoke Terraform state"
  type        = string
}

variable "spoke_state_key" {
  description = "S3 key for Spoke Phase 7 Terraform state"
  type        = string
  default     = "phase7/spoke/terraform.tfstate"
}

variable "app_port" {
  description = "Application port"
  type        = number
  default     = 80
}  