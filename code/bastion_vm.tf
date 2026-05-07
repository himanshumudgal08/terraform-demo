
module "bastion_public_ip" {
  source                      = "../modules/public_ip"
  public_ip_name              = "bastionpip-${local.common_name}-001"
  resource_group_location     = module.resource_group.resource_group_location
  resource_group_name         = module.resource_group.resource_group_name
  public_ip_allocation_method = "Static"
  public_ip_sku               = "Standard"
  domain_name_label           = null
  public_ip_zones             = null
  public_ip_tags = merge(
    var.common_tags_primary,
    {
      Name          = "bastionpip-${local.common_name}-001"
      resource_type = "Network Interface"
    }  )
}

module "bastion_vm_nic" {
  source                        = "../modules/network_interface"
  network_interface_name        = "bastionvm-${local.common_name}-001-nic"
  resource_group_location       = module.resource_group.resource_group_location
  resource_group_name           = module.resource_group.resource_group_name
  network_interface_dns_servers = null
  ip_configuration = {
    "ip1" = {
      subnet_id                     = module.subnet_01.subnet_id
      private_ip_address_allocation = "Dynamic"
      public_ip_address_id          = module.bastion_public_ip.public_ip_id
    }
  }
  nic_tags = merge(
    var.common_tags_primary,
    {
      Name          = "bastionvm-${local.common_name}-001-nic"
      resource_type = "Network Interface"
    }
  )
}

module "vm_nsg" {
  source                                                = "../modules/network_security_group"
  network_security_group_name                           = "vm-${local.common_name}-001-nsg"
  resource_group_location                               = module.resource_group.resource_group_location
  resource_group_name                                   = module.resource_group.resource_group_name
  network_security_rule_name                            = var.network_security_rule_name
  network_security_rule_priority                        = var.network_security_rule_priority
  network_security_rule_direction                       = var.network_security_rule_direction
  network_security_rule_access                          = var.network_security_rule_access
  network_security_rule_protocol                        = var.network_security_rule_protocol
  network_security_rule_source_port_range               = var.network_security_rule_source_port_range
  network_security_rule_destination_port_range          = var.network_security_rule_destination_port_range
  network_security_group_source_address_prefix          = var.network_security_group_source_address_prefix
  network_security_rule_destination_address_prefix      = var.network_security_rule_destination_address_prefix
  network_security_group_tags = merge(
    var.common_tags_primary,
    {
      Name          = "vmvm-${local.common_name}-001-nsg"
      resource_type = "Network Security Group"
    }
  )

}

module "linux_bastion_vm" {
  source                                   = "../modules/linux_virtual_machine"
  virtual_machine_name                     = "bastionvm-${local.common_name}-001"
  resource_group_location                  = module.resource_group.resource_group_location
  resource_group_name                      = module.resource_group.resource_group_name
  virtual_machine_size                     = "Standard_F2"
  virtual_machine_admin_username           = "ubuntu"
  virtual_machine_network_interface_ids    = [module.bastion_vm_nic.network_interface_id]
  virtual_machine_admin_ssh_key_username   = "ubuntu"
  virtual_machine_admin_ssh_key_public_key = file("${path.module}/id_rsa.pub")

  os_disk = {
    "disk1" = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
      disk_size_gb         = 50
      disk_encryption_set_id = null

    }
  }

  source_image_reference = {
    "image1" = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }
  virtual_machine_custom_data = null
  vm_tags = merge(
    var.common_tags_primary,
    {
      Name          = "bastionvm-${local.common_name}-001"
      resource_type = "Virtual Machine"
    }
  )
}