module "public_alb" {
  source = "../modules/phase7-public-alb"

  name = "phase7-hub-public-alb"

  vpc_id = var.hub_vpc_id

  public_subnet_ids = var.hub_public_subnet_ids

  endpoint_subnet_ids = var.hub_private_subnet_ids

  service_name = data.terraform_remote_state.spoke.outputs.endpoint_service_name

  allowed_cidr_blocks = [
    "0.0.0.0/0"
  ]

  app_port = var.app_port
} 