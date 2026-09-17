data "aws_vpc" "hub" {
  filter {
    name   = "cidr"
    values = [var.hub_vpc_cidr]
  }
}

data "aws_vpc" "spoke" {
  filter {
    name   = "cidr"
    values = [var.spoke_vpc_cidr]
  }
}

data "aws_subnets" "hub_public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.hub.id]
  }

  tags = {
    Tier = "public"
  }
}

data "aws_instance" "app" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.spoke.id]
  }

  filter {
    name   = "tag:Name"
    values = ["phase6-private-app"]
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }
}

module "centralized_alb" {
  source = "./modules/centralized-alb"

  hub_vpc_id          = data.aws_vpc.hub.id
  spoke_vpc_cidr      = var.spoke_vpc_cidr
  public_subnet_ids   = data.aws_subnets.hub_public.ids
  application_ip      = data.aws_instance.app.private_ip
  application_port    = var.app_port
  application_name    = var.app_name
}   