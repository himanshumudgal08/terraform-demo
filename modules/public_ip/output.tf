output "public_ip_address_id" {
  value = azurerm_public_ip.public_ip.ip_address
}

output "public_ip_id" {
  value = azurerm_public_ip.public_ip.id
}

output "public_ip_domain_name_label" {
  value = azurerm_public_ip.public_ip.domain_name_label
}