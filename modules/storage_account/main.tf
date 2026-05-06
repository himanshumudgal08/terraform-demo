resource "azurerm_storage_account" "storage_acc" {
  name                              = var.storage_account_name
  resource_group_name               = var.resource_group_name
  location                          = var.resource_group_location
  account_tier                      = "Standard"
  account_replication_type          = "RAGRS"
  cross_tenant_replication_enabled  = var.storage_account_cross_tenant_replication_enabled
  min_tls_version                   = "TLS1_2"
  https_traffic_only_enabled        = true
  allow_nested_items_to_be_public   = false
  infrastructure_encryption_enabled = true
  public_network_access_enabled     = true

  tags = var.tags
}