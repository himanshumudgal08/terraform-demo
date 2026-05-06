output "storage_account_id" {
  value       = azurerm_storage_account.storage_acc.id
  description = "The ID of the Storage Account"
}

output "storage_account_primary_location" {
  value       = azurerm_storage_account.storage_acc.primary_location
  description = "The primary location of the storage account."
}

output "storage_account_id_secondary_location" {
  value       = azurerm_storage_account.storage_acc.secondary_location
  description = "The secondary location of the storage account"
}

output "storage_account_url" {
  value       = azurerm_storage_account.storage_acc.primary_web_endpoint
  description = "The ID of the Storage Account"
}

output "storage_account_primary_connection_string" {
  value = azurerm_storage_account.storage_acc.primary_connection_string
}

output "storage_account_primary_blob_endpoint" {
  value = azurerm_storage_account.storage_acc.primary_blob_endpoint
}