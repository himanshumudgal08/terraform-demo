variable "subnet_name" {
  type        = string
  description = "(Required) The name of the subnet. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created."
}

variable "virtual_network_name" {
  type        = string
  description = "(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created."
}

variable "subnet_private_endpoint_network_policies" {
  type    = string
  default = "Enabled"
}

variable "subnet_address_prefixes" {
  type        = list(string)
  description = "(Required) The address prefixes to use for the subnet."
}

variable "subnet_service_endpoints" {
  type        = list(string)
  default     = []
  description = "(Optional) The name of the subnet endpoint."
}

variable "delegation" {
  type = map(object({
    name = string
    service_delegation = map(object({
      name    = string
      actions = list(string)
    }))
  }))
}
