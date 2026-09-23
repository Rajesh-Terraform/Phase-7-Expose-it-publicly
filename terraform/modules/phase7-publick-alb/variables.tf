variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "endpoint_subnet_ids" {
  type = list(string)
}

variable "service_name" {
  type = string
}

variable "allowed_cidr_blocks" {
  type = list(string)
}

variable "app_port" {
  type    = number
  default = 80
}  