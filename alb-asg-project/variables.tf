variable "aws_region" {
    description = "This is the value of aws region"
    type = string
}

variable "vpc_config" {
  description = "This is the configurations of the vpc"
  type = object({
    vpc_cidr_block = string 
    cidr_public_subnet = string
    az_public_subnet = string
    igw_cidr_block = optional(string, "0.0.0.0/0")
  })

}

variable "project" {
  description = "This is the name of the project"
  type = string
}

variable "environment" {
description = "This is the name of the environment"
type = string
}

variable "launch_temp_config" {
  description = "The is the configuration for launch template"
  type = object({
    ami_id  = string
    instance_type = string
  })
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
