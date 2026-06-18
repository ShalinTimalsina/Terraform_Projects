# Security Group for Application Load Balancer
resource "aws_security_group" "alb_sg" {
  vpc_id      = aws_vpc.my_vpc.id
  name        = "${local.name_prefix}-alb-sg"
  description = "Allow HTTP/HTTPS inbound traffic"


  ingress {
    description = "This allows the HTTP access from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "This allows the HTTPS access from the internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-alb_sg"
  })
}

# Security Group For Application 

resource "aws_security_group" "app_sg" {
  vpc_id      = aws_vpc.my_vpc.id
  name        = "${local.name_prefix}-app_sg"
  description = "This only allows traffic from alb-sg"

  ingress {
    description     = "HTTP From ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-alb_sg"
  })

}
