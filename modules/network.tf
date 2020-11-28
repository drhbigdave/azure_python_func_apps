resource "azurerm_subnet" "subnet1" {
    name                    = var.subnet1_name
    resource_group_name     = var.vnet_rg_name
    virtual_network_name    = var.vnet_name
    address_prefixes        = var.subnet1_address_prefixes
    service_endpoints       = var.subnet1_service_endpoints
    delegation {
      name = "nix-func-delegation"

      service_delegation {
        name    = "Microsoft.Web/serverFarms"
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }

}

resource "azurerm_subnet_network_security_group_association" "subnet1_nsg_association1" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}

resource "azurerm_network_security_group" "nsg1" {
  name                = var.nsg1_name
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  tags = {
    environment = "standard_vm_vnet"
  }
}
#resource "azurerm_subnet_network_security_group_association" "subnet1NSG" {
#  subnet_id                 = azurerm_subnet.vnet1_subnet1.id
#  network_security_group_id = azurerm_network_security_group.vnet1_nsg.id
#}

resource "azurerm_network_security_rule" "vnet1_nsg1_outrule1" {
  name                        = "outbound"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "10.0.2.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg1.name
  network_security_group_name = azurerm_network_security_group.nsg1.name
}

resource "azurerm_network_security_rule" "vnet1_nsg1_inrule1" {
  name                        = "inbound_from_davids"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = data.azurerm_key_vault_secret.davids_home_ip.value
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg1.name
  network_security_group_name = azurerm_network_security_group.nsg1.name
}

resource "azurerm_network_security_rule" "vnet1_nsg1_inrule2" {
  name                        = "inbound_from_shanikas"
  priority                    = 201
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = data.azurerm_key_vault_secret.shanikas_home_ip.value
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg1.name
  network_security_group_name = azurerm_network_security_group.nsg1.name
}
