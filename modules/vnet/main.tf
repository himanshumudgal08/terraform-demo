resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  address_space       = var.virtual_network_address_space
  location            = var.virtual_network_location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "monitor_diagnostic_setting_vnet_logs" {
  count = (var.storage_account_id != null ||
    var.monitor_diagnostic_setting_eventhub_authorization_rule_id != null ||
    var.monitor_diagnostic_setting_log_analytics_workspace_id != null ||
  var.partner_solution_id != null) ? 1 : 0
  name                       = "diagnosticlog-${var.virtual_network_name}"
  target_resource_id         = azurerm_virtual_network.vnet.id
  log_analytics_workspace_id = var.monitor_diagnostic_setting_log_analytics_workspace_id
  # storage_account_id         = var.storage_account_id
  # partner_solution_id        = var.partner_solution_id
  enabled_log {
    category_group = "allLogs"
    category       = null
  }
  enabled_metric {
    category = "allMetrics"
  }
  depends_on = [azurerm_virtual_network.vnet]
}
