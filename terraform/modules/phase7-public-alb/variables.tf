variable "vpc_id" {
  description = "Hub VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the ALB"
  type        = list(string)
}

variable "endpoint_subnet_ids" {
  description = "Private subnet IDs containing the VPC endpoint"
  type        = list(string)
}

variable "service_name" {
  description = "VPC Endpoint Service name from spoke"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access the ALB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "app_port" {
  description = "Application port"
  type        = number
}  