resource "aws_lb_target_group" "default" {
  name        = "${var.name}-target-group"
  target_type = "ip"
  vpc_id      = var.vpc_id

  port     = var.port
  protocol = "HTTP"

  health_check {
    path     = var.health_check_path
    protocol = "HTTP"
    matcher  = "200"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb" "default" {
  name               = var.name
  security_groups    = var.security_group_ids
  load_balancer_type = "application"
  subnets            = var.subnet_ids
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.default.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      protocol    = "HTTPS"
      port        = "443"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.default.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default.arn
  }
}
