variable "name" {
  type = string
}

variable "acceptance_required" {
  type    = bool
  default = false
}

variable "network_load_balancer_arns" {
  type = list(string)
} 