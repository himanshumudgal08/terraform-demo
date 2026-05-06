variable "public_ip_name" {
  type        = string
  description = "(Required) Specifies the name of the Public IP. Changing this forces a new Public IP to be created."
}

variable "resource_group_location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the Public IP should exist. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group where this Public IP should exist. Changing this forces a new Public IP to be created."
}

variable "public_ip_allocation_method" {
  type        = string
  description = "(Required) Defines the allocation method for this IP address. Possible values are Static or Dynamic."
}

variable "public_ip_sku" {
  type        = string
  description = "(Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic. Changing this forces a new resource to be created."
}

variable "domain_name_label" {
  type        = string
  description = "(Optional) Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system."
}

variable "public_ip_zones" {
  type    = list(string)
  default = []
}

variable "public_ip_tags" {
  type = map(string)
}