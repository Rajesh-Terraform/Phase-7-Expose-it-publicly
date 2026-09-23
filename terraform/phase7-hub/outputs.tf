output "alb_dns_name" {
  value = module.public_alb.alb_dns_name
}

output "alb_url" {
  value = "http://${module.public_alb.alb_dns_name}"
}

output "vpc_endpoint_id" {
  value = module.public_alb.endpoint_id
}

output "endpoint_ips" {
  value = module.public_alb.endpoint_ips
}  