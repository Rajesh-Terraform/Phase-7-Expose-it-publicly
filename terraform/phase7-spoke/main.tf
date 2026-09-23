module "nlb" {
  source = "../modules/phase7-nlb"

  vpc_id     = var.spoke_vpc_id
  subnet_ids = var.spoke_private_subnet_ids
  app_port   = var.app_port
}


module "endpoint_service" {
  source = "../modules/phase7-endpoints-service"

  nlb_arn = module.nlb.nlb_arn
}  