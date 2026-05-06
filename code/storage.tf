module "storage_account" {
  source                  = "../modules/storage_account"
  storage_account_name    = "stpoc${local.common_name_storage}001"
  resource_group_name     = module.resource_group.resource_group_name
  resource_group_location = module.resource_group.resource_group_location
  # storage_account_account_tier                              = var.storage_account_account_tier
  # storage_account_account_replication_type                  = var.storage_account_account_replication_type
  storage_account_cross_tenant_replication_enabled          = true
  tags = merge(
    var.common_tags_primary,
    {
      Name          = "stpoc${local.common_name_storage}001"
      resource_type = "Storage Account"
    }
  )
}

module "storage_account_network_rules" {
  source                                       = "../modules/storage_account_network_rules"
  storage_account_id                           = module.storage_account.storage_account_id
  storage_account_network_rules_default_action = "Deny"
  storage_account_network_rules_ip_rules       = ["49.47.69.70"]
  virtual_network_subnet_ids                   = [module.subnet_02.subnet_id]
  storage_account_network_rules_bypass         = ["AzureServices"]
  private_link_access                          = []
}