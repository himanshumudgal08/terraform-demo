variable "virtual_machine_name" {
  type = string
}

variable "resource_group_location" {
  type        = string
  description = "  (Required) The location where the Network Interface should exist. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which to create the Network Interface. Changing this forces a new resource to be created."
}
variable "virtual_machine_size" {
  type = string
}
variable "virtual_machine_admin_username" {
  type = string
}
variable "virtual_machine_network_interface_ids" {
  type = list(string)
}

variable "vm_tags" {
  type = map(string)
}

variable "virtual_machine_admin_ssh_key_username" {
  type = string
}

variable "virtual_machine_admin_ssh_key_public_key" {
  type = string
}

variable "os_disk" {
  description = "Map of IP configurations for the network interface"
  type = map(object({
    caching                = string
    storage_account_type   = string
    disk_size_gb           = number
    disk_encryption_set_id = string
  }))
}

variable "source_image_reference" {
  description = "Map of IP configurations for the network interface"
  type = map(object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  }))
}

variable "virtual_machine_custom_data" {
  type = any
}