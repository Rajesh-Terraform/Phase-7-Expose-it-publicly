# ============================================================
# ALB SECURITY GROUP
# HUB ACCOUNT
# ============================================================

resource "aws_security_group" "alb" {
  name        = "${var.application_name}-alb-sg"
  description = "Security group for Phase 7 public ALB"
  vpc_id      = var.hub_vpc_id

  ingress {
    description = "HTTP from Internet"
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "HTTP to Spoke application"
    protocol    = "tcp"
    from_port   = var.application_port
    to_port     = var.application_port
    cidr_blocks = [var.spoke_vpc_cidr]
  }

  tags = {
    Name = "${var.application_name}-alb-sg"
  }
}


# ============================================================
# INTERNET-FACING APPLICATION LOAD BALANCER
# ============================================================

resource "aws_lb" "this" {
  name               = "${var.application_name}-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb.id
  ]

  subnets = var.public_subnet_ids

  tags = {
    Name = "${var.application_name}-alb"
  }
}


# ============================================================
# TARGET GROUP
# IP TARGET
# ============================================================

resource "aws_lb_target_group" "app" {
  name        = "${var.application_name}-tg"
  port        = var.application_port
  protocol    = "HTTP"
  target_type = "ip"

  vpc_id = var.hub_vpc_id

  health_check {
    enabled             = true
    protocol            = "HTTP"
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
  }

  tags = {
    Name = "${var.application_name}-tg"
  }
}


# ============================================================
# REGISTER SPOKE PRIVATE IP
# ============================================================

resource "aws_lb_target_group_attachment" "app" {
  target_group_arn = aws_lb_target_group.app.arn

  target_id = var.application_ip

  port = var.application_port
}


# ============================================================
# HTTP LISTENER
# ============================================================

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
} 