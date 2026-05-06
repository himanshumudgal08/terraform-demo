variable "network_interface_name" {
  type        = string
  description = "(Required) The name of the Network Interface. Changing this forces a new resource to be created."
}

variable "resource_group_location" {
  type        = string
  description = "  (Required) The location where the Network Interface should exist. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created."
}

variable "network_interface_dns_servers" {
  type    = list(string)
  default = []
}

variable "nic_tags" {
  type = map(string)
}

variable "ip_configuration" {
  description = "Map of IP configurations for the network interface"
  type = map(object({
    subnet_id                     = string
    private_ip_address_allocation = string
    public_ip_address_id          = string
  }))
}


variable "monitor_diagnostic_setting_eventhub_name" {
  type    = string
  default = null
}

variable "monitor_diagnostic_setting_eventhub_authorization_rule_id" {
  type    = string
  default = null
}

variable "monitor_diagnostic_setting_log_analytics_workspace_id" {
  type    = string
  default = null
}

variable "monitor_diagnostic_setting_storage_account_id" {
  type    = string
  default = null
}

variable "monitor_diagnostic_setting_partner_solution_id" {
  type    = string
  default = null
}