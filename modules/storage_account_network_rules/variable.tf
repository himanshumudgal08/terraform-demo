variable "storage_account_id" {
  type = string
}

variable "storage_account_network_rules_default_action" {
  type = string
}

variable "storage_account_network_rules_ip_rules" {
  type = list(string)
}

variable "virtual_network_subnet_ids" {
  type = list(string)
}

variable "storage_account_network_rules_bypass" {
  type = list(string)
}

variable "private_link_access" {
  type = list(object({
    endpoint_resource_id = string
    endpoint_tenant_id   = string
  }))
  default = []
}