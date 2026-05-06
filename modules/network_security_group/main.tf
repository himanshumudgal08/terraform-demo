resource "azurerm_network_security_group" "network_security_group" {
  name                = var.network_security_group_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  tags                = var.network_security_group_tags
}

resource "azurerm_network_security_rule" "security_group_rule" {
  count                       = length(var.network_security_rule_destination_port_range)
  name                        = var.network_security_rule_name[count.index]
  priority                    = var.network_security_rule_priority[count.index]
  direction                   = var.network_security_rule_direction[count.index]
  access                      = var.network_security_rule_access[count.index]
  protocol                    = var.network_security_rule_protocol[count.index]
  source_port_range           = var.network_security_rule_source_port_range[count.index]
  destination_port_range      = var.network_security_rule_destination_port_range[count.index]
  source_address_prefix       = var.network_security_group_source_address_prefix[count.index]
  destination_address_prefix  = var.network_security_rule_destination_address_prefix[count.index]
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.network_security_group.name
}