output "alb_id" {
  description = "The ID of the Application Load Balancer"
  value       = aws_lb.this.id
}

output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = aws_lb.this.arn
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.this.dns_name
}

output "alb_zone_id" {
  description = "The Route 53 hosted zone ID of the Application Load Balancer"
  value       = aws_lb.this.zone_id
}

output "alb_name" {
  description = "The name of the Application Load Balancer"
  value       = aws_lb.this.name
}   