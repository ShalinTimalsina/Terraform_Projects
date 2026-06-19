locals {
  name_prefix = "${var.tags_config.project}-${var.tags_config.environment}"
  
  common_tags= {
    Project = var.tags_config.project
    Environment = var.tags_config.environment
    ManagedBy = "Terraform"
  }
}