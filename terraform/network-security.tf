resource "azurerm_network_security_group" "dsc-runner" {
  name                = "nsg-uks-m365dsc"
  resource_group_name = azurerm_resource_group.m365dsc.name
  location            = azurerm_resource_group.m365dsc.location
  #tags     = local.tags

}

resource "azurerm_network_interface_security_group_association" "mjwsite" {
  network_interface_id      = azurerm_network_interface.vm-nic.id
  network_security_group_id = azurerm_network_security_group.dsc-runner.id
}

resource "azurerm_network_security_rule" "permit-rdp" {
  name                        = "rdp"
  priority                    = 300
  direction                   = "Inbound"
  source_address_prefixes     = ["${local.ip-address}/32"]
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "3389"
  protocol                    = "Tcp"
  access                      = "Allow"
  resource_group_name         = azurerm_resource_group.m365dsc.name
  network_security_group_name = azurerm_network_security_group.dsc-runner.name
}
