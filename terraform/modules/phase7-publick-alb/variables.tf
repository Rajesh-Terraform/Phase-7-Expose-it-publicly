variable "name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "security_group_ids" {
  description = "Security group IDs for the ALB"
  type        = list(string)
}

variable "subnet_ids" {
  description = "Public subnet IDs for the ALB"
  type        = list(string)
}  