
# #############################################################################################################
variable "common_tags_primary" {
  type = map(string)
}

variable "common_tags_secondary" {
  type = map(string)
}

variable "client_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "application" {
  type = string
}

variable "failover_enabled" {
  type    = bool
  default = false
}

variable "location_primary" {
  description = "The Azure Region in which to create the resources"
  type        = string
}

variable "location_secondary" {
  description = "The Azure Region in which to create the resources"
  type        = string
}

variable "location_primary_short" {
  description = "The Azure Region in which to create the resources"
  type        = string
}

variable "location_secondary_short" {
  description = "The Azure Region in which to create the resources"
  type        = string
}

variable "virtual_network_address_space" {
  type = list(string)
}

variable "subnet_01_address_prefixes" {
  type = list(string)
}

variable "subnet_01_delegation" {
  type = map(object({
    name = string
    service_delegation = map(object({
      name    = string
      actions = list(string)
    }))
  }))
}

variable "subnet_02_address_prefixes" {
  type = list(string)
}

variable "subnet_02_delegation" {
  type = map(object({
    name = string
    service_delegation = map(object({
      name    = string
      actions = list(string)
    }))
  }))
}

#################

variable "network_security_rule_name" {
  type = list(string)
}
variable "network_security_rule_priority" {
  type = list(number)
}
variable "network_security_rule_direction" {
  type = list(string)
}
variable "network_security_rule_access" {
  type = list(string)
}
variable "network_security_rule_protocol" {
  type = list(string)
}
variable "network_security_rule_source_port_range" {
  type = list(string)
}
variable "network_security_rule_destination_port_range" {
  type = list(string)
}
variable "network_security_group_source_address_prefix" {
  type = list(string)
}
variable "network_security_rule_destination_address_prefix" {
  type = list(string)
}


####################

# variable "storage_account_account_tier" {
#   type        = string
#   description = " Defines the Tier to use for this storage account."

# }
# variable "storage_account_account_replication_type" {
#   type        = string
#   description = "Defines the type of replication to use for this storage account."
# }