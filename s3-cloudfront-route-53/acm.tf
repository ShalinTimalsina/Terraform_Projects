# Creting a ACM Certificate 
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

resource "aws_acm_certificate" "certificate" {
  provider          = aws.us_east_1 # Since acm generation only supports in this region.
  domain_name       = var.domain_name
  validation_method = "DNS"

  subject_alternative_names = [
    local.full_domain
  ]
  lifecycle {
    create_before_destroy = true
  }
}

# ACM Validation 
resource "aws_acm_certificate_validation" "validation" {
  
  certificate_arn = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [ for record in aws_route53_record.acm_records : record.fqdn]

}