variable "hub_vpc_id" {
  description = "Existing Hub VPC ID"
  type        = string
}

variable "spoke_vpc_cidr" {
  description = "Spoke VPC CIDR"
  type        = string
}

variable "public_subnet_ids" {
  description = "Existing Hub public subnet IDs"
  type        = list(string)
}

variable "application_ip" {
  description = "Private IP address of application EC2"
  type        = string
}

variable "application_port" {
  description = "Application port"
  type        = number
  default     = 80
}

variable "application_name" {
  description = "Application name"
  type        = string
} 