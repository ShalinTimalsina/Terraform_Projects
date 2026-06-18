variable "aws_region" {
    description = "This is the value of aws region"
    type = string
}

variable "vpc_cidr_block" {
  description = "This is the CIDR Block for the main VPC"
  type = string
}

variable "cidr_public_subnet" {
  description = "This is the cidr range for public subnet"
  type = string
}

variable "az_public_subnet" {
  description = "This is the availability zone for public subnet"
  type = string
}

variable "igw_cidr_block" {
  description = "This is the cidr block for internet gateway"
  type = string
  default = "0.0.0.0/0"
}

variable "project" {
  description = "This is the name of the project"
  type = string
}

variable "environment" {
description = "This is the name of the environment"
type = string
}

# Launch Template 
variable "instance_type_lt" {
    description = "This is the instance type for the launch template"
    type = string
}

variable "ami_id_lt" {
  description = "This is the ami id of the instance in the launch template"
  type = string
}

variable "asg_config" {
  description = "ASG capacity configuration"
  type = object({
    availability_zone = string
    min     = number
    max     = number
    desired = number
  })
  
 validation {
    condition     = var.asg_config.min <= var.asg_config.desired && var.asg_config.desired <= var.asg_config.max
    error_message = "Ensure: min should be less than desired and max should be more than desired (min <= desired <= max)"
  }

}

variable "public_key_path" {
    description = "This is the path where your public key is stored locally"
    type = string
  
}
