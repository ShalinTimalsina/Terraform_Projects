# Creting a ACM Certificate 
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

resource "aws_acm_certificate" "certificate" {
  provider          = aws.us_east_1 # Since acm generation only supports in this region.
  domain_name       = "shalin-timalsina.me"
  validation_method = "DNS"

  subject_alternative_names = [
    "www.shalin-timalsina.me"
  ]
  lifecycle {
    create_before_destroy = true
  }
}

