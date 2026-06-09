terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.44.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.9.0"
    }
    
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      project_name = var.project_name
      environment = var.environment
      owner = var.owner
    }
  }
}


