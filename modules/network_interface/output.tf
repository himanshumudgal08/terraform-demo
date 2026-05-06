output "network_interface_id" {
  value = azurerm_network_interface.nic.id
}

output "network_interface_name" {
  value = azurerm_network_interface.nic.name
}

output "network_interface_virtual_machine_id" {
  value = azurerm_network_interface.nic.virtual_machine_id
}

output "network_interface_private_ip_address" {
  value = azurerm_network_interface.nic.private_ip_address
}

output "network_interface_mac_address" {
  value = azurerm_network_interface.nic.mac_address
}

output "network_interface_private_ip_addresses" {
  value = azurerm_network_interface.nic.private_ip_addresses
}