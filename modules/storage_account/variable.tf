variable "storage_account_name" {
  type        = string
  description = "(Required) Specifies the name of the storage account. "
}
variable "resource_group_name" {
  type        = string
  description = " The name of the resource group in which to create the storage account. Changing this forces a new resource to be created"

}
variable "resource_group_location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."

}

variable "storage_account_cross_tenant_replication_enabled" {
  type    = bool
  default = false
}

variable "tags" {
  type = map(string)
}