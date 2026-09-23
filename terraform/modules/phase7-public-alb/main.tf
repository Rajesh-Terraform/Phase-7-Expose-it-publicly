resource "aws_security_group" "alb" {
  name        = "phase7-public-alb-sg"
  description = "Security group for public ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "phase7-public-alb-sg"
  }
}


resource "aws_lb" "public" {
  name               = "phase7-public-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb.id
  ]

  subnets = var.public_subnet_ids

  tags = {
    Name = "phase7-public-alb"
  }
}


resource "aws_lb_target_group" "app" {
  name        = "phase7-app-tg"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    enabled  = true
    protocol = "HTTP"
    port     = "traffic-port"
    path     = "/"
  }

  tags = {
    Name = "phase7-app-tg"
  }
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.public.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}   