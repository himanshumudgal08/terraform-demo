module "resource_group" {
  source                  = "../modules/resource_group"
  resource_group_name     = "rg-${local.common_name}-001"
  resource_group_location = var.location_primary
  tags = merge(
    var.common_tags_primary,
    {
      Name          = "rg-${local.common_name}-001"
      resource_type = "Resource Group"
    }
  )
}

module "vnet" {
  source                                                    = "../modules/vnet"
  virtual_network_name                                      = "vnet-${local.common_name}-001"
  virtual_network_address_space                             = var.virtual_network_address_space
  virtual_network_location                                  = module.resource_group.resource_group_location
  resource_group_name                                       = module.resource_group.resource_group_name
  tags = merge(
    var.common_tags_primary,
    {
      Name          = "vnet-${local.common_name}-001"
      resource_type = "Virtual Network"
    }
  )
}

module "subnet_01" {
  source                   = "../modules/subnet"
  subnet_name              = "snet-bastion"
  resource_group_name      = module.resource_group.resource_group_name
  virtual_network_name     = module.vnet.virtual_network_name
  subnet_address_prefixes  = var.subnet_01_address_prefixes
  subnet_service_endpoints = []
  delegation               = var.subnet_01_delegation
}

module "subnet_02" {
  source                   = "../modules/subnet"
  subnet_name              = "snet-pvt"
  resource_group_name      = module.resource_group.resource_group_name
  virtual_network_name     = module.vnet.virtual_network_name
  subnet_address_prefixes  = var.subnet_02_address_prefixes
  subnet_service_endpoints = ["Microsoft.Storage"]
  delegation               = var.subnet_02_delegation
}

module "bastion_nsg" {
  source                                                = "../modules/network_security_group"
  network_security_group_name                           = "bastionnsg-${local.common_name}-001-nsg"
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
      Name          = "bastionnsg-${local.common_name}-001-nsg"
      resource_type = "Network Security Group"
    }
  )
}

module "bastion_subnet_nsg_association" {
  source = "./modules/subnet_network_security_group_association"
  subnet_id                 = module.subnet_01.subnet_id
  network_security_group_id = module.bastion_nsg.network_security_group_id
}

###############################################################################################################