module "public_alb" {
  source = "../modules/phase7-public-alb"

  name            = var.name
  security_groups = var.security_groups
  subnets         = var.subnets
}  