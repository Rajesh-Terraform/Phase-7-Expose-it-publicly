module "nlb" {
  source = "../modules/phase7-nlb"

  name = "phase7-spoke-nlb"

  vpc_id = var.spoke_vpc_id

  subnet_ids = var.spoke_private_subnet_ids

  target_ips = var.app_private_ips

  target_port = var.app_port
}

module "endpoint_service" {
  source = "../modules/phase7-endpoint-service"

  nlb_arn = module.nlb.nlb_arn

  hub_account_id = var.hub_account_id

  acceptance_required = false
}  