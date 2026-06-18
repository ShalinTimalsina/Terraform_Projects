resource "aws_launch_template" "app_launch_template" {
  name_prefix   = "${local.name_prefix}-lt"
  description   = "Launch template for application"
  instance_type = var.instance_type_lt
  image_id      = var.ami_id_lt

  key_name = aws_key_pair.my_key.key_name

  # Assign public IP (IMPORTANT for your setup)
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.app_sg.id]
  }

  # User data
  user_data = base64encode(file("userdata.sh"))

  # Tags for EC2 instances
  tag_specifications {
    resource_type = "instance"

    tags = merge(
      local.common_tags,
      {
        Name = "${local.name_prefix}-instance"
      }
    )
  }
}