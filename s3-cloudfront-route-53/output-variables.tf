# Displaying the static web bucket name
output "bucket_name" {
  value = aws_s3_bucket.web_bucket.id
}

output "website_url" {
  value = "http://${aws_s3_bucket_website_configuration.configuration.website_endpoint}"
}

