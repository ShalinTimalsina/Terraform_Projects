# Creating a Auto Scale Group
resource "aws_autoscaling_group" "app_asg" {


  target_group_arns   = [aws_lb_target_group.alb_tg.arn]
  vpc_zone_identifier = aws_subnet.public_subnet[*].id
  min_size            = var.asg_config.min
  max_size            = var.asg_config.max
  desired_capacity    = var.asg_config.desired

  launch_template {
    id      = aws_launch_template.app_launch_template.id
    version = "$Latest"
  }
}
