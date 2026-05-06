variable "virtual_network_name" {
  type        = string
  description = "(Required) The name of the virtual network. Changing this forces a new resource to be created."
}

variable "virtual_network_address_space" {
  type        = list(string)
  description = "(Required) The address space that is used the virtual network. You can supply more than one address space."
}

variable "virtual_network_location" {
  type        = string
  description = "(Required) The location/region where the virtual network is created. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created."
}

variable "tags" {
  type = map(string)
}

variable "monitor_diagnostic_setting_eventhub_name" {
  type    = string
  default = null
}
variable "monitor_diagnostic_setting_eventhub_authorization_rule_id" {
  type    = string
  default = null
}

variable "log_analytics_destination_type" {
  type    = string
  default = null
}
# variable "monitor_diagnostic_setting_enabled_log_category_group_1" {
#   type = list(map(string))
# }
# variable "monitor_diagnostic_setting_enabled_log_category_group_2" {
#   type = list(map(string))
# }


variable "monitor_diagnostic_setting_log_analytics_workspace_id" {
  type    = string
  default = null
}

# variable "monitor_diagnostic_setting_enabled_log_category_group_2" {
#   type = map(object({
#     category_group = string
#   }))
# }

variable "storage_account_id" {
  type    = string
  default = null
}

variable "partner_solution_id" {
  type    = string
  default = null
}

# variable "azurerm_network_watcher_id" {
#   type = string
# }

# variable "storage_account_flow_logs_id" {
#   type = string
# }