resource "aws_vpc_endpoint_service" "this" {
  acceptance_required        = false
  network_load_balancer_arns = [var.nlb_arn]

  tags = {
    Name = "phase7-endpoint-service"
  }
}    