output "project_name" {
  value = var.project_name
}

output "Environment" {
  value = var.environment
}

output "owner" {
  value = var.owner
}

# Displaying the static web bucket name
output "bucket_name" {
  value = aws_s3_bucket.web_bucket.id
}


output "cloudfront_distribution_id" {
  value = "http://${aws_cloudfront_distribution.s3_distribution.domain_name}"

}

output "root_url" {
  description = "This is the root domain"
  value       = "https://${aws_route53_record.root.fqdn}"

}

output "subdomain_url" {
  description = "This is the domain with subdomain as www"
  value       = "https://${aws_route53_record.sub_domain.fqdn}"

}





