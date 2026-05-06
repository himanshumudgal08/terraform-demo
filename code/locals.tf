locals {
  common_name                   = "${var.application}-${var.environment}-${var.location_primary_short}-${var.client_name}"
  common_name_storage           = "${var.environment}${var.location_primary_short}${var.client_name}"
  common_name_secondary         = "${var.application}-${var.environment}-${var.location_secondary_short}-${var.client_name}"
  common_name_storage_secondary = "${var.environment}${var.location_secondary_short}${var.client_name}"
}