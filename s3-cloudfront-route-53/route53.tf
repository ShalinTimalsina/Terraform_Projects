# Looks in the existing zone instead of creating new one.
data "aws_route53_zone" "main" {
  name = var.domain_name
}

# Created a A name record in Route 53 for the root
resource "aws_route53_record" "root" {

    name = var.domain_name
    zone_id = data.aws_route53_zone.main.zone_id
    type = "A"

    alias {
      name = aws_cloudfront_distribution.s3_distribution.domain_name
      zone_id = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
      evaluate_target_health = false
    }
}

# Added the subdomain with www also
resource "aws_route53_record" "sub_domain" {

    name = local.full_domain
    zone_id = data.aws_route53_zone.main.zone_id
    type = "A"

    alias {
      name = aws_cloudfront_distribution.s3_distribution.domain_name
      zone_id = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
      evaluate_target_health = false
    }

  
}

# Creating the Records given by ACM for validation
resource "aws_route53_record" "acm_records" {
  for_each = {
    for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main.zone_id
}


