output "alb_dns_name" {
  description = "Public URL for Phase 7 application"
  value       = module.centralized_alb.alb_dns_name
}

output "application_private_ip" {
  description = "Private IP of application EC2"
  value       = data.aws_instance.app.private_ip
}  