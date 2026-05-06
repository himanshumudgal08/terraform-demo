resource "azurerm_linux_virtual_machine" "vm" {
  name                       = var.virtual_machine_name
  resource_group_name        = var.resource_group_name
  location                   = var.resource_group_location
  size                       = var.virtual_machine_size
  admin_username             = var.virtual_machine_admin_username
  network_interface_ids      = var.virtual_machine_network_interface_ids

  admin_ssh_key {
    username   = var.virtual_machine_admin_ssh_key_username
    public_key = var.virtual_machine_admin_ssh_key_public_key
  }

  dynamic "os_disk" {
    for_each = var.os_disk
    content {
      name                   = "${var.virtual_machine_name}-OsDisk"
      caching                = os_disk.value.caching
      storage_account_type   = os_disk.value.storage_account_type
      disk_size_gb           = os_disk.value.disk_size_gb
      disk_encryption_set_id = os_disk.value.disk_encryption_set_id
    }
  }

  dynamic "source_image_reference" {
    for_each = var.source_image_reference
    content {
      publisher = source_image_reference.value.publisher
      offer     = source_image_reference.value.offer
      sku       = source_image_reference.value.sku
      version   = source_image_reference.value.version
    }
  }
  custom_data = var.virtual_machine_custom_data
  tags        = var.vm_tags
}