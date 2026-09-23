resource "aws_vpc_endpoint_service" "this" {
  acceptance_required        = var.acceptance_required
  network_load_balancer_arns = var.network_load_balancer_arns

  tags = {
    Name = var.name
  }
} 