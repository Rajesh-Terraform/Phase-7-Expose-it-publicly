module "nlb" {
  source = "../modules/phase7-nlb"

  # NLB variables
}

module "endpoint_service" {
  source = "../modules/phase7-endpoint-service"

  # Endpoint service variables
}  