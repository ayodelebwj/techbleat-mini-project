resource "aws_lb" "public_alb" {
  name               = "public-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public_1.id, aws_subnet.public_2.id]
  security_groups    = [aws_security_group.public_alb_sg.id]
}

resource "aws_lb" "internal_alb" {
  name               = "private-alb"
  internal           = true
  load_balancer_type = "application"
  subnets            = [aws_subnet.private_1.id, aws_subnet.private_2.id]
  security_groups    = [aws_security_group.internal_alb_sg.id]
}

resource "aws_lb_target_group" "public_tg" {
  name        = "public-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.techbleatvpc.id
  target_type = "instance"

  health_check {
    protocol            = "HTTP"
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }
}

resource "aws_lb_target_group" "private_tg" {
  name        = "private-tg"
  port        = 8000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.techbleatvpc.id
  target_type = "instance"

  health_check {
    protocol            = "HTTP"
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }
}

resource "aws_lb_listener" "public_listener" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      protocol    = "HTTPS"
      port        = "443"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "internal_listener" {
  load_balancer_arn = aws_lb.internal_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_tg.arn
  }
}



