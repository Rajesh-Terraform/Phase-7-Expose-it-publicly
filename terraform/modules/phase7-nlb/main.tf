resource "aws_lb" "this" {
  name               = var.name
  internal           = true
  load_balancer_type = "network"

  subnets = var.subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = var.name
  }
}

resource "aws_lb_target_group" "app" {
  name        = "${var.name}-tg"
  port        = var.target_port
  protocol    = "TCP"
  target_type = "ip"

  vpc_id = data.aws_vpc.selected.id

  health_check {
    protocol = "TCP"
    port     = var.health_check_port
  }

  tags = {
    Name = "${var.name}-tg"
  }
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

resource "aws_lb_target_group_attachment" "app" {
  for_each = toset(var.target_ips)

  target_group_arn = aws_lb_target_group.app.arn
  target_id        = each.value
  port             = var.target_port
}

resource "aws_lb_listener" "tcp" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.target_port
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}  