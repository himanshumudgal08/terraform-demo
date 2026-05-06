
# #############################################################################################################
# Core - Resource Group
# #############################################################################################################
location_primary         = "uksouth"
location_primary_short   = "uks"
location_secondary       = "ukwest"
location_secondary_short = "ukw"
environment              = "dev"
application              = "vm"
client_name              = "ks"

common_tags_primary = {
  environment = "dev"
  app         = "PLS"
  costing     = "IT"
  criticality = "High"
  department  = "IT"
  location    = "UKS"
  deployment  = "terraform"
}

common_tags_secondary = {
  environment = "dev"
  app         = "PLS"
  costing     = "IT"
  criticality = "high"
  department  = "IT"
  location    = "UKW"
  deployment  = "terraform"
}

failover_enabled = true

virtual_network_address_space = ["10.0.0.0/16"]

subnet_01_address_prefixes = ["10.0.0.0/24"]
subnet_01_delegation       = {}

subnet_02_address_prefixes = ["10.0.1.0/24"]
subnet_02_delegation       = {}

#############################

network_security_rule_name                       = ["DenyInternetInbound", "AllowAnySSHInbound"]
network_security_rule_priority                   = [200, 100]
network_security_rule_direction                  = ["Inbound", "Inbound"]
network_security_rule_access                     = ["Deny", "Allow"]
network_security_rule_protocol                   = ["*", "Tcp"]
network_security_rule_source_port_range          = ["*", "*"]
network_security_rule_destination_port_range     = ["*", "22"]
network_security_group_source_address_prefix     = ["*", "49.47.69.70"]
network_security_rule_destination_address_prefix = ["*", "*"] 


####################3
# storage_account_account_tier             = "Standard"
# storage_account_account_replication_type = "RAGRS"
# #############################################################################################################