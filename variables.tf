variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "hub_vpc_cidr" {
  description = "Hub VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "spoke_vpc_cidr" {
  description = "Spoke VPC CIDR"
  type        = string
  default     = "10.1.0.0/16"
}

variable "hub_role_arn" {
  description = "IAM role ARN that Terraform can assume in the Hub account"
  type        = string
}

variable "app_port" {
  description = "Application port"
  type        = number
  default     = 80
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = "phase7-app"
} 