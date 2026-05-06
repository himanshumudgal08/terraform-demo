variable "network_security_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

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

variable "network_security_group_tags" {
  type = map(string)
}

