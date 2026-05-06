resource "azurerm_storage_account_network_rules" "network_rules" {
  storage_account_id         = var.storage_account_id
  default_action             = var.storage_account_network_rules_default_action
  ip_rules                   = var.storage_account_network_rules_ip_rules
  virtual_network_subnet_ids = var.virtual_network_subnet_ids
  bypass                     = var.storage_account_network_rules_bypass
  dynamic "private_link_access" {
    for_each = var.private_link_access
    content {
      endpoint_resource_id = private_link_access.value.endpoint_resource_id
      endpoint_tenant_id   = private_link_access.value.endpoint_tenant_id
    }
  }
}