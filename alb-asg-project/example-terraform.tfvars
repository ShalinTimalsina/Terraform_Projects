# AWS Configuration
aws_region = "us-east-1"

# VPC Configuration
vpc_cidr_block = "10.0.0.0/16"

# Project Info
project     = "alb-asg"
environment = "dev"

# EC2 / Launch Template
instance_type_lt = "t3.micro"

# Replace with valid AMI for your region
ami_id_lt = "ami-xxxxxxxxxxxxxxx"

# Auto Scaling Group Configuration
asg_config = {
  min     = 1
  max     = 3
  desired = 2
}

# SSH Key Path (LOCAL MACHINE)
# Replace this with your own path
public_key_path = "/path/to/your/.ssh/id_rsa.pub"