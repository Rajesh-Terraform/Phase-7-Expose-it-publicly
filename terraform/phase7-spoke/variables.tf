variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "spoke_vpc_id" {
  type = string
}

variable "spoke_private_subnet_ids" {
  type = list(string)
}

variable "app_private_ips" {
  type = list(string)
}

variable "hub_account_id" {
  type = string
}

variable "app_port" {
  type    = number
  default = 80
}  