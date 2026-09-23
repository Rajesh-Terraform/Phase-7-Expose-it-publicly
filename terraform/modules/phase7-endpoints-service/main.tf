resource "aws_vpc_endpoint_service" "this" {
  acceptance_required        = var.acceptance_required
  network_load_balancer_arns = [var.nlb_arn]

  tags = {
    Name = "phase7-private-link-service"
  }
}

resource "aws_vpc_endpoint_service_allowed_principal" "hub" {
  vpc_endpoint_service_id = aws_vpc_endpoint_service.this.id

  principal_arn = "arn:aws:iam::${var.hub_account_id}:root"
}  