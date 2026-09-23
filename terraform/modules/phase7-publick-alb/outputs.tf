output "alb_arn" {
  description = "ARN of the public Application Load Balancer"
  value       = aws_lb.public.arn
}

output "alb_dns_name" {
  description = "DNS name of the public Application Load Balancer"
  value       = aws_lb.public.dns_name
}

output "vpc_endpoint_id" {
  description = "Interface VPC Endpoint ID"
  value       = aws_vpc_endpoint.private_link.id
}

output "endpoint_ips" {
  description = "Private IP addresses of the Interface VPC Endpoint"
  value       = local.endpoint_ips
}

output "target_group_arn" {
  description = "ALB target group ARN"
  value       = aws_lb_target_group.private_link.arn
}  