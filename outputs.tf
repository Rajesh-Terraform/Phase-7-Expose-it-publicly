output "alb_dns_name" {
  description = "Public DNS name of Phase 7 ALB"
  value       = module.centralized_alb.alb_dns_name
}

output "application_private_ip" {
  description = "Private IP of Phase 7 application"
  value       = aws_instance.app.private_ip
} 