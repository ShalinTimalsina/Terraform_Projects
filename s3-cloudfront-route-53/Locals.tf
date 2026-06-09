locals {
  origin_id = "s3-origin"
}   

locals {
 description = "This is the full domain"
 full_domain = "${var.sub_domain}.${var.domain_name}" 
}