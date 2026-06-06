# ---------------------------
# Random suffix for uniqueness
# ---------------------------
resource "random_id" "unique_id" {
  byte_length = 4
}

# ---------------------------
# S3 Bucket
# ---------------------------
resource "aws_s3_bucket" "web_bucket" {
  bucket = "shalin-timalsina.me-${random_id.unique_id.hex}"

  tags = {
    Name = "static_web"
  }
}

# ---------------------------
# Upload HTML file
# ---------------------------
resource "aws_s3_object" "html_file" {
  bucket       = aws_s3_bucket.web_bucket.id
  key          = "index.html"
  source       = "${path.module}/RiverBankinn/index.html"
  content_type = "text/html"

  lifecycle {
    ignore_changes = [etag]
  }
}

# ---------------------------
# Local processing
# ---------------------------
locals {
  all_images = fileset("${path.module}/RiverBankinn/Images", "**")

  mime_types = {
    html = "text/html"
    css  = "text/css"
    js   = "application/javascript"
    png  = "Images/png"
    jpg  = "Images/jpeg"
    jpeg = "Images/jpeg"
    gif  = "Images/gif"
    webp = "Images/webp"
  }
}

# ---------------------------
# Upload images
# ---------------------------
resource "aws_s3_object" "Images" {
  for_each = toset(local.all_images)

  bucket = aws_s3_bucket.web_bucket.id
  key    = "Images/${each.value}"
  source = "${path.module}/RiverBankinn/Images/${each.value}"

  content_type = lookup(
    local.mime_types,
    split(".", each.value)[length(split(".", each.value)) - 1],
    "application/octet-stream"
  )

  lifecycle {
    ignore_changes = [etag]
  }
}

# ---------------------------
# Public Access Block (Block all the public access directly to s3 bucket only cloudfront distribution can access it )
# ---------------------------
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.web_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ---------------------------
# Bucket Policy (Only for cloudfront to access)
# ---------------------------
resource "aws_s3_bucket_policy" "cloudfront-access" {
  bucket     = aws_s3_bucket.web_bucket.id
  depends_on = [aws_s3_bucket_public_access_block.public_access]

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "AllowCloudFrontRead",
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "cloudfront.amazonaws.com"
          },
          "Action" : [
            "s3:GetObject",
            
          ]
          "Resource" : "${aws_s3_bucket.web_bucket.arn}/*"
          "Condition" : {
            "StringEquals" : {
              "AWS:SourceArn" : "${aws_cloudfront_distribution.s3_distribution.arn}"
            }
          }
        }
      ]
    }
  )
}


