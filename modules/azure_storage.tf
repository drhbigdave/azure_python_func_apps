resource "azurerm_storage_account" "sa2" {
  name                     = var.sa2_name
  location                 = azurerm_resource_group.rg1.location
  resource_group_name      = azurerm_resource_group.rg1.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = var.sa1_environment_tag
  }
}
resource "azurerm_storage_account_network_rules" "sa2_rules" {
  resource_group_name  = azurerm_resource_group.rg1.name
  storage_account_name = azurerm_storage_account.sa2.name

  default_action             = "Deny"
  ip_rules                   = [data.azurerm_key_vault_secret.davids_home_ip.value, data.azurerm_key_vault_secret.shanikas_home_ip.value]
  virtual_network_subnet_ids = [data.azurerm_subnet.vm_subnet.id]
  bypass                     = ["AzureServices"]
}

resource "azurerm_storage_container" "container1" {
  name                  = var.container1_name
  storage_account_name  = azurerm_storage_account.sa2.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "container2" {
  name                  = var.container2_name
  storage_account_name  = azurerm_storage_account.sa2.name
  container_access_type = "private"
}


resource "azurerm_storage_account" "sa1" {
  name                     = var.sa1_name
  location                 = azurerm_resource_group.rg1.location
  resource_group_name      = azurerm_resource_group.rg1.name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = var.sa1_environment_tag
  }
}
resource "azurerm_storage_account_network_rules" "sa1_rules" {
  resource_group_name  = azurerm_resource_group.rg1.name
  storage_account_name = azurerm_storage_account.sa1.name

  default_action             = "Deny"
  ip_rules                   = [data.azurerm_key_vault_secret.davids_home_ip.value, data.azurerm_key_vault_secret.shanikas_home_ip.value]
  virtual_network_subnet_ids = [data.azurerm_subnet.vm_subnet.id]
  bypass                     = ["AzureServices"]
}