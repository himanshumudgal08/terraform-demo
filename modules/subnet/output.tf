output "subnet_id" {
  value = azurerm_subnet.subnet.id
}

output "subnet_address_space" {
  value = azurerm_subnet.subnet.address_prefixes
}

output "subnet_name" {
  value = azurerm_subnet.subnet.name
}