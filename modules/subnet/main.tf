resource "azurerm_subnet" "subnet" {
  name                              = var.subnet_name
  resource_group_name               = var.resource_group_name
  virtual_network_name              = var.virtual_network_name
  address_prefixes                  = var.subnet_address_prefixes
  service_endpoints                 = var.subnet_service_endpoints
  private_endpoint_network_policies = var.subnet_private_endpoint_network_policies

  dynamic "delegation" {
    for_each = var.delegation
    content {
      name = delegation.value.name

      dynamic "service_delegation" {
        for_each = delegation.value.service_delegation
        content {
          name    = service_delegation.value.name
          actions = service_delegation.value.actions
        }
      }
    }
  }
}
