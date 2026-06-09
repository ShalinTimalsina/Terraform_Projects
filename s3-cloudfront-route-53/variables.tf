#  AWS Region
variable "aws_region" {
  description = "This is the value of AWS Region"
  type        = string
}


# S3 bucket name
variable "s3_bucket_name" {
  description = "This is the bucket name"
  type        = string
}

# Route 53 hosted zone name
variable "domain_name" {
  description = "This it public hosted zone name"
  type        = string
}

# Sub-domain
variable "sub_domain" {
  description = "This is the sub_domain like www or app or blog (eg: app.example.com)"
  default     = "www"
  type        = string
}

# Default Root Object
variable "default_root_object_s3" {
  description = "This is the default root object in s3 like (index.html)"
  type        = string
}

variable "price_class" {
  description = "Enter the desired price class for cloudfront (PriceClass_All , PriceClass_200, PriceClass_100)"
  type        = string
  default     = "PriceClass_100"

}

variable "project_name" {
  description = "Add a name for this project"
  type        = string
}

variable "environment" {
  description = "Add the environment like (prod , dev , test)"
  type        = string
}

variable "owner" {
  description = "Write the owner's name"
  type        = string

}
