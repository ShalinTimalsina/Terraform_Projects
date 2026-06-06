# Displaying the static web bucket name
output "bucket_name" {
  value = aws_s3_bucket.web_bucket.id
}


output "cloudfront_distribution_id" {
  value = "http://${aws_cloudfront_distribution.s3_distribution.domain_name}"

}
