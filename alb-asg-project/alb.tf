# Creating a Target Group 
resource "aws_lb_target_group" "alb_tg" {
  name        = "alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.my_vpc.id
  target_type = "instance"


  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

}

# Creating the ALB
resource "aws_lb" "my_alb" {

  name               = "${local.name_prefix}-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.alb_sg.id]

  subnets = aws_subnet.public_subnet[*].id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-alb"
  })

}

# Creating the Listners Rule

resource "aws_lb_listener" "alb_listner_rule" {

  load_balancer_arn = aws_lb.my_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }

}
