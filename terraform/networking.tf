resource "azurerm_virtual_network" "dsc-runner" {
  name                = "vnet-uks-m365dsc"
  address_space       = ["10.42.0.0/20"]
  location            = azurerm_resource_group.m365dsc.location
  resource_group_name = azurerm_resource_group.m365dsc.name
}

resource "azurerm_subnet" "m365dsc" {
  name                 = "sn-uks-dscrunner"
  resource_group_name  = azurerm_resource_group.m365dsc.name
  virtual_network_name = azurerm_virtual_network.dsc-runner.name
  address_prefixes     = ["10.42.1.0/28"]
}

resource "azurerm_subnet" "private-endpoint" {
    name = "sn-uks-privateendpoint"
    resource_group_name = azurerm_resource_group.m365dsc.name
    virtual_network_name = azurerm_virtual_network.dsc-runner.name
    address_prefixes = ["10.42.1.128/25"]
}