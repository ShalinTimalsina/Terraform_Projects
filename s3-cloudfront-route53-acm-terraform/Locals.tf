locals {
  origin_id = "s3-origin"
}   

locals {
 description = "This is the full domain"
 full_domain = "${var.sub_domain}.${var.domain_name}" 
}

# ---------------------------
# Local processing
# ---------------------------
locals {
  all_images = fileset("${path.module}/Website-assets/Images", "**")

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
