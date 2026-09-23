output "nlb_arn" {
  description = "Network Load Balancer ARN"
  value       = aws_lb.nlb.arn
}

output "nlb_dns_name" {
  description = "Network Load Balancer DNS name"
  value       = aws_lb.nlb.dns_name
}   