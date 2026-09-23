output "public_alb_dns_name" {
  description = "Public ALB DNS name"
  value       = aws_lb.public.dns_name
}

output "public_alb_arn" {
  description = "Public ALB ARN"
  value       = aws_lb.public.arn
}

output "target_group_arn" {
  description = "ALB target group ARN"
  value       = aws_lb_target_group.app.arn
}  