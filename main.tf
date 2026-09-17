# ============================================================
# SPOKE VPC
# ============================================================

data "aws_vpc" "spoke" {
  provider = aws

  filter {
    name   = "cidr"
    values = [var.spoke_vpc_cidr]
  }
}


# ============================================================
# SPOKE PRIVATE SUBNETS
# ============================================================

data "aws_subnets" "spoke_private" {
  provider = aws

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.spoke.id]
  }

  tags = {
    Tier = "private"
  }
}


# ============================================================
# HUB VPC
# IMPORTANT: Use aws.hub provider
# ============================================================

data "aws_vpc" "hub" {
  provider = aws.hub

  filter {
    name   = "cidr"
    values = [var.hub_vpc_cidr]
  }
}


# ============================================================
# HUB PUBLIC SUBNETS
# ============================================================

data "aws_subnets" "hub_public" {
  provider = aws.hub

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.hub.id]
  }

  tags = {
    Tier = "public"
  }
}


# ============================================================
# AMAZON LINUX AMI
# ============================================================

data "aws_ami" "amazon_linux" {
  provider = aws

  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}


# ============================================================
# APPLICATION SECURITY GROUP
# SPOKE ACCOUNT
# ============================================================

resource "aws_security_group" "app" {
  provider = aws

  name        = "phase7-app-sg"
  description = "Security group for Phase 7 private application"
  vpc_id      = data.aws_vpc.spoke.id

  ingress {
    description = "HTTP from Hub VPC"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = [var.hub_vpc_cidr]
  }

  egress {
    description = "Application outbound"
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "phase7-app-sg"
  }
}


# ============================================================
# PRIVATE APPLICATION EC2
# SPOKE ACCOUNT
# ============================================================

resource "aws_instance" "app" {
  provider = aws

  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  subnet_id = data.aws_subnets.spoke_private.ids[0]

  associate_public_ip_address = false

  vpc_security_group_ids = [
    aws_security_group.app.id
  ]

  user_data = <<-EOF
              #!/bin/bash
              mkdir -p /opt/phase7
              cat > /opt/phase7/index.html <<'HTML'
              <html>
              <head>
                <title>Phase 7 Application</title>
              </head>
              <body>
                <h1>Phase 7 Centralized ALB</h1>
                <p>Hello from the private Spoke application!</p>
              </body>
              </html>
              HTML

              cat > /etc/systemd/system/phase7-app.service <<'SERVICE'
              [Unit]
              Description=Phase 7 HTTP Application
              After=network.target

              [Service]
              ExecStart=/usr/bin/python3 -m http.server 80 --directory /opt/phase7
              Restart=always

              [Install]
              WantedBy=multi-user.target
              SERVICE

              systemctl daemon-reload
              systemctl enable phase7-app
              systemctl start phase7-app
              EOF

  tags = {
    Name = "phase7-private-app"
  }
}


# ============================================================
# CENTRALIZED ALB
# HUB ACCOUNT
# ============================================================

module "centralized_alb" {
  source = "./modules/centralized-alb"

  providers = {
    aws = aws.hub
  }

  hub_vpc_id = data.aws_vpc.hub.id

  spoke_vpc_cidr = var.spoke_vpc_cidr

  public_subnet_ids = data.aws_subnets.hub_public.ids

  application_ip = aws_instance.app.private_ip

  application_port = var.app_port

  application_name = var.app_name
} 