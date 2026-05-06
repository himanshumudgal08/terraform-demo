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
  subnet_name              = "snet-public"
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


###############################################################################################################